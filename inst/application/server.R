library(ldsmls)
library(shiny)
library(RSQLite)
library(dplyr)

options(pixiedust_print_method = "html")

startup_initialize_database()

shinyServer(function(input, output, session){
  
  #*********************************************
  #* Global Variables
  
  ch <- dbConnect(RSQLite::SQLite(), "C:/ldsmls/congregation.db")

  #*********************************************
  #* Reactive Value Lists
  Congregation <- reactiveValues(
    Configured = startup_congregation_configured()
  )
  
  RV <- reactiveValues(
    Congregation = dbReadTable(ch, "Congregation"),
    Organization = dbReadTable(ch, "Organization"),
    Position = dbReadTable(ch, "Position"),
    Membership = dbReadTable(ch, "Membership"),
    CallingTrack = dbReadTable(ch, "CallingTrack")
  )
  

  #*********************************************
  #* Reactive Values
  
  Membership <- reactive({
    req(input[["membership_file"]])
    utils::read.csv(input$membership_file$datapath,
                    stringsAsFactors = FALSE,
                    na = "") %>%
      dplyr::mutate(Birth.Date = as.Date(Birth.Date, format = "%d %b %Y"), 
                    Name = ifelse(is.na(Maiden.Name),
                                  Full.Name, 
                                  Maiden.Name),
                    idstring = paste0(Record.Number, Birth.Date, RV$Congregation$UnitNumber, Name),
                    ID = vapply(idstring, util_encode_id, character(1))) %>%
      dplyr::filter(!is.na(Record.Number)) %>%
      dplyr::select(ID, Birth.Date, Sex, Full.Name, Maiden.Name) %>%
      dplyr::mutate(Birth.Date = format(Birth.Date, "%Y-%m-%d")) %>%
      stats::setNames(c("ID", "Birth_Date", "Sex", "Full_Name", "Maiden_Name"))
  })
  
  #*********************************************
  #* Control Toggles
  
  observe({
    toggle(id = "congregation_not_defined",
           condition = !Congregation$Configured)
    toggle(id = "congregation_defined",
           condition = Congregation$Configured)
  })
  
  observe({
    toggleState(id = "btn_configure_congregation",
                condition = trimws(input[["unit_number"]]) != "")
  })
  
  observe({
    req(input[["organization_selector"]])
    allow_add <- 
      RV$Position %>%
      filter(Organization == input[["organization_selector"]]) %>%
      `$`("Position") %>%
      (function(x) all(!is.na(x) & trimws(x) != ""))

    toggle(id = "btn_add_custom_position",
           condition = allow_add)
  })
           
  
  #*********************************************
  #* Action Buttons

  observeEvent(
    input[["btn_configure_congregation"]],
    {
      btn_configure_congregation(input = input)
      Congregation$Configured <- TRUE
    }
  )
  
  observeEvent(
    input[["call_add_new_calling"]],
    {
      dbSendQuery(ch,
                  "INSERT INTO Calling (MemberID) VALUES (NULL)")
      RV$Calling <- dbReadTable(ch, "Calling")
    }
  )
  
  observeEvent(
    input[["btn_add_custom_position"]],
    {
      btn_add_custom_position(input, Position = RV$Position)
      RV$Position <- dbReadTable(ch, "Position")
    }
  )
  
  observeEvent(
    input[["btn_save_custom_position_changes"]],
    {
      permit_save <- btn_save_custom_position_changes(input)
      if (!permit_save)
      {
        info(paste0("At least one position name was left blank. ",
                    "Please provide a name for every position ",
                    "before saving."))
      }
      RV$Position <- dbReadTable(ch, "Position")
    }
  )
  
  observeEvent(
    input[["btn_import_record"]],
    {
      btn_importRecords(Membership(), RV$Membership, conn = ch)
      RV$Membership <- dbReadTable(ch, "Membership")
    }
  )
  
  observeEvent(
    input[["btn_enable_unit_number_update"]],
    {
      info(paste0("Editing the unit number will alter the way internal ",
                  "membership identifiers are generated. Data existing ",
                  "in the database _will_ be corrupted if you proceed."))
      enable("update_unit_number")
    }
  ) 
  
  observeEvent(
    input[["btn_update_congregation"]],
    {
      btn_configure_congregation(input = input)
    }
  )
  
  #*********************************************
  #* Active Event Observers
  
  observe({
    position_enabler <- names(input)[grepl("position_enable", names(input))]
    lapply(
      position_enabler,
      function(x)
      {
        observeEvent(
          input[[x]],
          {
            dbSendPreparedQuery(
              conn = ch,
              statement = paste0("UPDATE Position ",
                                 "SET Enabled = ? ",
                                 "WHERE OID = ?;"),
              bind.data = data.frame(Enabled = as.numeric(input[[x]]),
                                     OID = as.numeric(sub("position_enable_", "", x)))
            )
            RV$Position <- dbReadTable(ch, "Position")
          }
        )
      }
    )
  })
  
  
  #*********************************************
  #* Passive Event Observers
  
  
  #*********************************************
  #* Output Elements
  
  output$call_track <- renderUI({
    req(nrow(RV$Calling) > 0)
    
    Track <- RV$CallingTrack
    Track$Member <-
      selectInput_cell(
        inputId = paste0("Member_", Track$OID),
        choices = RV$Membership$MemberID %>% setNames(RV$Membership$FullName) %>% c(" " = NA, .),
        selected = Track$MemberID
      )
    Track$Organization <- 
      selectInput_cell(
        inputId = paste0("Organization_", RV$CallingTrack$OID),
        choices = RV$Organization$OID %>% setNames(RV$Organization$OrganizationName) %>% c(" " = NA, .),
        selected = Track$OrganizationID
      )
    
    makePositionList <- function(OrgID, Position)
    {
      Pos <- filter(Position, Organization == OrgID) 
      Pos$OID %>% setNames(Pos$Position) %>% c(" " = NA, .)
    }
    
    Track$Position <- 
      selectInput_cell(
        inputId = paste0("Position_", Track$OID),
        choices = sapply(Track$OrganizationID, makePositionList, RV$Position),
        selected = Track$PositionID
      )

    
    select(Track, Member, Organization, Position) %>%
      dust() %>%
      print(asis = FALSE) %>%
      HTML()
  })
  
  output$pos_select_organization <- renderUI({
    shiny::selectInput(
      inputId = "organization_selector",
      label = "Organization",
      choices = RV$Organization[["OID"]] %>% setNames(RV$Organization[["OrganizationName"]])
    )
  })
  
  output$pos_edit_position <- renderUI({
    req(input[["organization_selector"]])
    ui_configure_position(input, Position = RV$Position)
  })
  
  output$ui_membership_file_display <- renderUI({
    Membership() %>%
      select(Full_Name, Birth_Date, Sex) %>%
      arrange(Full_Name) %>%
      dust(justify = "left") %>%
      medley_mls() %>%
      print(asis = FALSE) %>%
      HTML()
  })
  
  output$ui_congregation_parameters <- renderUI({
    ui_congregation_parameters(RV$Congregation)
  })
  
  #*********************************************
  #* Download Handlers
  
  
  
  #*********************************************
  #* Value check output

  output$value_check <- renderPrint({ 
    nrow(RV$Calling)
  })
  
 
})
library(ldsmls)
library(shiny)
library(RSQLite)
library(dplyr)

CONFIGURED <- startup_congregationConfigured()

shinyServer(function(input, output, session){
  CONFIG <- reactiveValues(congregationConfigured = CONFIGURED)
  
  output$msg_initializeDatabase <- 
    renderText({
      if (msg() == "SUCCESS") "" else msg()
    })

  observe({
    CONFIG$congregationConfigured <- msg() == "SUCCESS"
  })
  
  #*******************************************************
  #*******************************************************
  #*  USER INTERFACE CONSTRUCTION
  #*******************************************************
  #*******************************************************
  
  output$ui_initialize <- renderUI({
    if (CONFIG$congregationConfigured) 
    {
        fluidPage(
          titlePanel(title = "MLS Extended Utilities"),
          tabsetPanel(
            ui_reports(),
            ui_callings(),
            tabPanel(
              title = "Sacrament Meeting Agendas"
            ),
            ui_importRecords(input),
            ui_configureDatabase(input, output)
          )
        )
    }
    else{
      ui_initializeDatabase(input)
    }
  })
  

  
  #*******************************************************
  #*******************************************************
  #* ACTION BUTTONS
  #* 1. Initialize Unit Database (input$btn_initializeDatabase)
  #* 2. Configure Unit Database (input$btn_configureDatabase)
  #* 3. Preview Membership Records (input$membershipFile)
  #* 4. Import Membership Records (input$btn_importRecords)
  #* 5. Render Reports (input$btn_renderReport)
  #*******************************************************
  #*******************************************************
  
  #* 1. Initialize Unit Database (input$btn_initializeDatabase)
  msg <- eventReactive(
    input$btn_initializeDatabase,
    {
      btn_initializeDatabase(input)
    }
  )
  
  #* 2. Configure Unit Database (input$btn_configureDatabase)
  observeEvent(
    input$btn_configureDatabase,
    btn_configureDatabase(input)
  )
  
  #* 3. Preview Membership File (input$membershipFile)
  output$membershipFile <- 
    renderTable({
      if (is.null(input$membershipFile)) return(NULL)
      
      read.csv(input$membershipFile$datapath,
               stringsAsFactors = FALSE,
               na = "") %>%
        mutate(Birth.Date = as.Date(Birth.Date, format = "%d %b %Y"), 
               Name = ifelse(Sex == "female",
                             Maiden.Name, 
                             Full.Name),
               idstring = paste0(Record.Number, Birth.Date, "1234", Name),
               ID = vapply(idstring, util_encode_id, character(1))) %>%
        filter(Record.Number != "") %>%
        select(Birth.Date, Sex, Full.Name, Maiden.Name) %>%
        mutate(Birth.Date = format(Birth.Date, "%Y-%m-%d")) %>%
        setNames(c("Birth_Date", "Sex", "Full_Name", "Maiden_Name"))
      
      
    })
  
  #* 4. Import Membership Records (input$btn_importRecords)
  observeEvent(
    input$btn_importRecords,
    btn_importRecords(input)
  )
  
  #* 5. Render Reports (input$btn_renderReport)
  observeEvent(
    input$btn_renderReport,
    btn_renderReport(input)
  )
  
  #*******************************************************
  #*******************************************************
  #* REPORT PANELS
  #*******************************************************
  #*******************************************************
  
  output$report <- 
    renderText({
      switch(input$reportSelection,
             "Upcoming Baptisms" = rpt_baptisms(input$rpt_dateRange[[1]],
                                                input$rpt_dateRange[[2]],
                                                cat = FALSE),
             "Upcoming Youth" = rpt_youth(input$rpt_dateRange[[1]],
                                          input$rpt_dateRange[[2]],
                                          cat = FALSE),
             "Upcoming Nursery" = rpt_nursery(input$rpt_dateRange[[1]],
                                             input$rpt_dateRange[[2]],
                                             cat = FALSE),
             "Upcoming Sunbeam" = rpt_sunbeam(input$rpt_dateRange[[1]],
                                              input$rpt_dateRange[[2]],
                                              cat = FALSE)
      )
    })
  
})
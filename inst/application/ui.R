library(shiny)
library(shinydust)
library(shinyjs)

shinyUI(
  fluidPage(
    useShinyjs(),
    
    tags$style("body {background-color: #357EC7;}"),
    tags$style(".well { background-color: #B6B6B4; }"),
    tags$style(".btn {background-color: #357EC7; }"),
    tags$style(HTML("
        .tabs-above > .nav > li[class=active] > a {
           background-color: #488AC7;
           color: #FFFFFF;}

        .tabs-above > .nav > li > a {
          background-color: #95B9C7;
          color: #FFFFFF;
        }")),
    
    titlePanel(title = "MLS Extended Utilities"),
    verbatimTextOutput("value_check"),
    
    hidden(
      div(
        id = "congregation_not_defined",
        wellPanel(
          textInput(
            inputId = "unit_number",
            label = "Unit Number",
            width = "200px"
          ),
          textInput(
            inputId = "unit_name",
            label = "Unit Name",
            width = "200px"
          ),
          selectInput(
            inputId = "unit_type",
            label = "Unit Type",
            choices = c(" ", "Branch", "District", "Mission", "Stake", "Ward"),
            width = "200px"
          ),
          actionButton(
            inputId = "btn_configure_congregation",
            label = "Initialize Database"
          )
        )
      )
    ),
    
    hidden(
      div(
        id = "congregation_defined",
        tabsetPanel(
          tabPanel(
            title = "Callings Management",
            tabsetPanel(
              tabPanel(
                title = "Callings",
                uiOutput("call_track"),
                actionButton(
                  inputId = "call_add_new_calling",
                  label = "Add Another Calling"
                )
              ),
              tabPanel(
                title = "Releases"
              ),
              tabPanel(
                title = "Organizations and Positions",
                wellPanel(
                  div(
                    id = "position_configuration",
                    fluidRow(
                      column(
                        width = 2,
                        uiOutput("pos_select_organization")
                      ),
                      column(
                        width = 10,
                        fluidRow( uiOutput("pos_edit_position") ),
                        actionButton(
                          inputId = "btn_save_custom_position_changes",
                          label = "Save Changes"
                        ),
                        hidden(
                          actionButton(
                            inputId = "btn_add_custom_position",
                            label = "Add Custom Position"
                          )
                        )
                      )
                    )
                  ),
                  div(
                    id = "organization_configuration"
                  )
                )
              )
            )
          ),
          tabPanel(
            title = "Sacrament Meeting Agendas"
          ),
          tabPanel(
            title = "Reports"
          ),
          tabPanel(
            title = "Import Membership File",
            wellPanel(
              fluidRow(
                column(
                  width = 3,
                  fileInput(inputId = "membership_file",
                            label = "Select a Membership File",
                            multiple = FALSE),
                  actionButton(inputId = "btn_import_record",
                               label = "Import Records")
                ),
                column(
                  width = 9,
                  uiOutput("ui_membership_file_display")
                )
              )
            )
          ),
          tabPanel(
            title = "Congregation Parameters",
            uiOutput("ui_congregation_parameters")
          )
        )
      )
    )

    
 
    
  )
)


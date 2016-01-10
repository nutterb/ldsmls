#' @name ui_configureDatabase 
#' @title Configure Database User Interface
#' 
#' @description Renders the User Interface with Database Configuration
#'  options.  These are stored in the Congregation table.
#'  
#' @param input the input object from the shiny session
#' @param output the output object from the shiny session
#'  
#' @export

ui_configureDatabase <- function(input, output)
{
  conn <- RSQLite::dbConnect(RSQLite::SQLite(), 
                             util_databasePath())
  Congregation <- RSQLite::dbReadTable(conn, "Congregation")
      
  RSQLite::dbDisconnect(conn)
      
  shiny::tabPanel(
    title = "Configuration",
    shiny::wellPanel(
      shiny::h2("Configure Unit Database"),
      shiny::checkboxInput(inputId = "changeUnitNumber",
                           label = "Change Unit Number",
                           value = FALSE),
          shiny::conditionalPanel("input.changeUnitNumber == true",
            shiny::textInput(inputId = "unitNumber",
                             label = "Unit Number",
                             width = "400px",
                             value = Congregation$Unit_Number)
          ),
          shiny::p(paste0("Note: changing the unit number will result in ",
                          "altered unique identifiers.  Changes to the unit ",
                          "number should be avoided if at all possible. ",
                          "Proceeding to change the unit number is almost ", 
                          "certain to result in the loss of all previously ",
                          "entered information.")),
          shiny::textInput(inputId = "unitName",
                           label = "Unit Name",
                           width = "400px",
                           value = Congregation$Unit_Name),
          shiny::selectInput(inputId = "unitType",
                             label = "Unit Type", 
                             choices = c("Ward", "Branch"),
                             width = "400px",
                             selected = Congregation$Unit_Type),
          shiny::conditionalPanel("input.unitType == 'Ward'",
            shiny::textInput(inputId = "bishop",
                             label = "Bishop",
                             width = "400px",
                             value = Congregation$Bishop)
          ),
          shiny::conditionalPanel("input.unitType == 'Branch'",
            shiny::textInput(inputId = "bishop",
                             label = "Branch President",
                             width = "400px",
                             value = Congregation$Bishop)
          ),
          shiny::actionButton(inputId = "btn_configureDatabase",
                              label = "Configure Unit Database")
        )
      )
}
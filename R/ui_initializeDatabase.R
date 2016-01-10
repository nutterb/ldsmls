#' @name ui_initializeDatabase
#' @title User Interface for Initializing the Database
#' 
#' @description This user interface is displayed on the first time the 
#' application is run when the database needs to be configured with at
#' least a unit number.
#' 
#' @param input The input object from the shiny session
#' @param output The output object from the shiny session
#' 
#' @export

ui_initializeDatabase <- function(input, output)
{
  shiny::fluidPage(
    shiny::wellPanel(
      shiny::h2("Initialize Unit Database"),
      shiny::textInput(inputId = "initialize_unitNumber",
                       label = "Unit Number",
                       width = "400px"),
      shiny::textInput(inputId = "initialize_unitName",
                       label = "Unit Name",
                       width = "400px"),
      shiny::selectInput(inputId = "initialize_unitType",
                         label = "Unit Type", 
                         choices = c("Ward", "Branch"),
                         width = "400px"),
      shiny::conditionalPanel("input.initialize_unitType == 'Ward'",
        shiny::textInput(inputId = "initialize_bishop",
                         label = "Bishop",
                         width = "400px")
      ),
      shiny::conditionalPanel("input.initilize_unitType == 'Branch'",
        shiny::textInput(inputId = "initialize_bishop",
                         label = "Branch President",
                         width = "400px")
      ),
      shiny::actionButton(inputId = "btn_initializeDatabase",
                          label = "Initialize Unit Database"),
      shiny::textOutput("msg_initializeDatabase")
    )
  )
}
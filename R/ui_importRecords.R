#' @name ui_importRecords
#' @title Import Membership Records
#' 
#' @description Imports Membership Records and assigns a unique identifier.
#'   
#' @param input The input object from the shiny session
#' 
#' @export

ui_importRecords <- function(input)
{
  shiny::tabPanel(
    title = "Import Membership Records",
    shiny::fluidRow(
      shiny::column(
        width = 3,
        shiny::fileInput(inputId = "membershipFile",
                         label = "Select a Membership File",
                         multiple = FALSE,
                         accept = "text/plain"),
        shiny::actionButton(inputId = "btn_importRecords",
                            label = "Import Records")
      ),
      shiny::column(
        width = 9,
        shiny::tableOutput("membershipFile")
      )
    )
  )
}
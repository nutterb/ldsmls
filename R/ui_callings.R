#' @name ui_callings
#' @title Callings User Interface
#' 
#' @description Renders the User Interface for Managing Callings
#' 
#' @export

ui_callings <- function()
{
  shiny::tabPanel(
    title = "Callings",
    shiny::tabsetPanel(
      shiny::tabPanel(
        title = "Callings Tracking"
      ),
      shiny::tabPanel(
        title = "Releases Tracking"
      ),
      shiny::tabPanel(
        title = "Select for Consideration"
      ),
      shiny::tabPanel(
        title = "Callings Management",
        shiny::column(
          width = 3,
          shiny::selectInput(inputId = "call_mng_org",
                             label = "Organization",
                             choices = c("Bishopric",
                                         "Elders Quorum",
                                         "High Priests Groups",
                                         "Primary",
                                         "Relief Society",
                                         "Sunday School",
                                         "Ward Mission",
                                         "Young Men", 
                                         "Young Single Adults",
                                         "Young Women",
                                         "Other")
          )
        )
      )
    )
  )
}
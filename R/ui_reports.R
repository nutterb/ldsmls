#' @name ui_reports
#' @title User Interface Showing Reports Options
#' 
#' @description Lists the reports made available through the interface.
#' 
#' @export

ui_reports <- function()
{
  shiny::tabPanel(
    title = "Reports",
    shiny::fluidRow(
      shiny::column(
        width = 3,
        shiny::selectInput(inputId = "reportSelection",
                           label = "Report",
                            choices = c("Upcoming Baptisms",
                                        "Upcoming Youth",
                                        "Upcoming Nursery",
                                        "Upcoming Sunbeam",
                                        "Callings",
                                        "Releases",
                                        "Organization Chart")),
        shiny::conditionalPanel(
          paste0("input.reportSelection == 'Upcoming Youth' || ",
                 "input.reportSelection == 'Upcoming Baptisms' || ",
                 "input.reportSelection == 'Upcoming Nursery' || ",
                 "input.reportSelection == 'Upcoming Sunbeam'"),
          shiny::dateRangeInput(
            inputId = "rpt_dateRange",
            label = "Date Range for Report",
            start = as.Date(paste0(lubridate::year(Sys.Date()), "-01-01")),
            end = as.Date(paste0(lubridate::year(Sys.Date()), "-12-31")))
        ),
        shiny::actionButton(inputId = "btn_renderReport",
                            label = "Generate Report")
      ),
      shiny::column(
        width = 9,
        shiny::uiOutput("report")
      )
    )
  )
}
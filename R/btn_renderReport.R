#' @name btn_renderReport
#' @title Render a Report
#' 
#' @description Renders a report
#' 
#' @param input The input object from the shiny session
#' 
#' @export

btn_renderReport <- function(input)
{
  if (input$reportSelection == "Upcoming Youth")
  {
    rmarkdown::render(
      input = system.file("report_templates/UpcomingYouth.Rmd",
                          package = "ldsmls"),
      output_format = "html_document",
      params = list(start_date = input$rpt_dateRange[[1]],
                    end_date = input$rpt_dateRange[[2]]))
    file.show(system.file("report_templates/UpcomingYouth.html",
                            package="ldsmls"))
  }
  
  if (input$reportSelection == "Upcoming Baptisms")
  {
    rmarkdown::render(
      input = system.file("report_templates/UpcomingBaptisms.Rmd",
                          package = "ldsmls"),
      output_format = "html_document",
      params = list(start_date = input$rpt_dateRange[[1]],
                    end_date = input$rpt_dateRange[[2]]))
    file.show(system.file("report_templates/UpcomingBaptisms.html",
                          package="ldsmls"))
  }
  
  if (input$reportSelection == "Upcoming Nursery")
  {
    rmarkdown::render(
      input = system.file("report_templates/UpcomingNursery.Rmd",
                          package = "ldsmls"),
      output_format = "html_document",
      params = list(start_date = input$rpt_dateRange[[1]],
                    end_date = input$rpt_dateRange[[2]]))
    file.show(system.file("report_templates/UpcomingNursery.html",
                          package="ldsmls"))
  }
  
  if (input$reportSelection == "Upcoming Sunbeam")
  {
    rmarkdown::render(
      input = system.file("report_templates/UpcomingSunbeam.Rmd",
                          package = "ldsmls"),
      output_format = "html_document",
      params = list(start_date = input$rpt_dateRange[[1]],
                    end_date = input$rpt_dateRange[[2]]))
    file.show(system.file("report_templates/UpcomingSunbeam.html",
                          package="ldsmls"))
  }
}
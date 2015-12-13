library(shiny)
shinyUI(
  fluidPage(
    titlePanel(title = "MLS Extended Utilities"),
    tabsetPanel(
      tabPanel(
        title = "Import Membership Records"
      ),
      tabPanel(
        title = "Callings"
      ),
      tabPanel(
        title = "Sacrament Meeting Agendas"
      ),
      tabPanel(
        title = "Reports"
      )
    )
  )
)
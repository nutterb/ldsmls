#' @name ui_congregation_parameters
#' @title Render the UI for changing congregation parameters
#' 
#' @description Generates the UI for changing congregation parameters
#'   and populates it with the current values from the database.
#'   
#' @param Congregation The Congregration data frame from the RV list
#' 
#' @export

ui_congregation_parameters <- function(Congregation)
{
  wellPanel(
    disabled(
      textInput(
        inputId = "update_unit_number",
        label = "Unit Number",
        value = Congregation[["UnitNumber"]],
        width = "200px"
      )
    ),
    actionButton(
      inputId = "btn_enable_unit_number_update",
      label = "Edit Unit Number"
    ),
    textInput(
      inputId = "update_unit_name",
      label = "Unit Name",
      value = Congregation[["UnitName"]],
      width = "200px"
    ),
    selectInput(
      inputId = "update_unit_type",
      label = "Unit Type",
      choices = c(" ", "Branch", "District", "Mission", "Stake", "Ward"),
      selected = Congregation[["UnitType"]],
      width = "200px"
    ),
    actionButton(
      inputId = "btn_update_congregation",
      label = "Initialize Database"
    )
  )
}
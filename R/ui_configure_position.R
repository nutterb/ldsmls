#' @name ui_configure_position
#' @title User Interface for Configuring Positions
#' 
#' @description Generate a table for managing positions within organizations
#' 
#' @param input The input object from the shiny session
#' 
#' @export

ui_configure_position <- function(input, Position)
{
  Position %>%
    filter(Organization == input[["organization_selector"]]) %>%
    dplyr::mutate(
      Position = ifelse(Custom == 1,
                        shinydust::textInput_cell(
                          inputId = paste0("position_name_", OID),
                          label = "",
                          value = Position,
                          width = "100px"
                        ),
                        Position),
      OrderID = ifelse(Custom == 1,
                       shinydust::numericInput_cell(
                         inputId = paste0("position_order_", OID),
                         label = "",
                         value = OrderID,
                         min = 0,
                         width = "75px"
                       ),
                       OrderID),
      Enabled = shinydust::checkboxInput_cell(
        inputId = paste0("position_enable_", OID),
        label = "",
        value = as.logical(Enabled)
      )
    ) %>%
    dplyr::select(OrderID, Position, Enabled) %>%
    pixiedust::dust(justify = "left") %>%
    pixiedust::sprinkle_colnames("Order", "Position", "Enabled") %>%
    medley_mls() %>%
    print(asis = FALSE) %>%
    shiny::HTML()
}
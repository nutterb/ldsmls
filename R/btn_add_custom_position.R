#' @name btn_add_custom_position
#' @title Add a row to the Position Table for a custom position
#' 
#' @description Allows the user to add a row within an organization
#'   to create a custom position. In order to add a custom position, 
#'   there must not be any custom position input field without a name.
#'   
#' @param input
#' 
#' @export

btn_add_custom_position <- function(input, Position)
{
  Current <- 
    Position %>%
    filter(Organization == input[["organization_selector"]])

    dbSendPreparedQuery(
      conn = ch,
      statement = paste0("INSERT INTO Position ",
                         "(Organization, Position, Custom, Enabled) ",
                         "VALUES (?, '', 1, 1);"),
      bind.data = data.frame(input[["organization_selector"]])
    )
}
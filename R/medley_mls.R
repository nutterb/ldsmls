#' @name medley_mls
#' @title Table Formatting for MLS Tables
#' 
#' @description Applies pixiedust formatting to tables in the UI
#' 
#' @export

medley_mls <- function(x)
{
  x %>%
  pixiedust::sprinkle(bg_pattern = c("#FFFFFF", "#E5E4E2"),
                      border_color = "#848482") %>%
  pixiedust::sprinkle(bg = "#E5E4E2", part = "head") %>%
  pixiedust::sprinkle_table(halign = "left",
                            pad = 3) %>%
  pixiedust::sprinkle_print_method("html")
}
#' @name rpt_youth
#' @title Upcoming Youth
#' 
#' @description Provides a table of all members turning twelve years old
#'   within the specified time frame.
#'   
#' @param start_date The start date of the eligibility period
#' @param end_date The end date of the eligibility period
#' @param cat logical. Determines if the results should be printed with the
#'   \code{cat} function.
#' 
#' @return Returns a table with the member's name, date of the eighth 
#'   birthday, and sex.
#'   
#' @export

rpt_youth <- function(start_date, end_date, cat = FALSE)
{
  conn <- RSQLite::dbConnect(RSQLite::SQLite(), util_databasePath())
  Youth <- RSQLite::dbReadTable(conn, "Membership") %>%
    dplyr::mutate(Birth_Date = as.Date(Birth_Date)) %>%
    dplyr::filter(as.Date(start_date) <= (Birth_Date + lubridate::years(12)) & 
             as.Date(end_date) >= (Birth_Date + lubridate::years(12))) %>%
    dplyr::mutate(twelfth_birthday = Birth_Date + lubridate::years(12),
           Print_Birthdate = format(Birth_Date, format = "%d %B %Y"),
           twelfth_birthday = format(twelfth_birthday, format = "%d %B %Y")) %>%
    dplyr::select(Full_Name, Print_Birthdate, twelfth_birthday, Sex, Birth_Date) %>%
    dplyr::arrange(Birth_Date)
  
  YM <-
    Youth %>%
    dplyr::filter(Sex == 'male') %>%
    dplyr::select(-Print_Birthdate, -Sex, -Birth_Date) 
  
  if (nrow(YM) == 0) YM <- "N/A"
  else
  {
    YM %<>%
      pixiedust::dust() %>%
      pixiedust::sprinkle_colnames("Name", "Twelfth Birthday") %>%
      pixiedust::sprinkle_table(halign = "left") %>%
      pixiedust::sprinkle(bg_pattern = c("#FFFFFF", "#D0D0D0")) %>%
      pixiedust::sprinkle(cols = 1, 
               width = 3,
               width_units = "in") %>%
      pixiedust::sprinkle_print_method("html") %>%
      print(asis = FALSE)
  }

  YW <-
    Youth %>%
    dplyr::filter(Sex == 'female') %>%
    dplyr::select(-Print_Birthdate, -Sex, -Birth_Date) 
  
  if (nrow(YW) == 0) YW <- "N/A"
  else
  {
    YW %<>%
      pixiedust::dust() %>%
      pixiedust::sprinkle_colnames("Name", "Twelfth Birthday") %>%
      pixiedust::sprinkle_table(halign = "left") %>%
      pixiedust::sprinkle(bg_pattern = c("#FFFFFF", "#D0D0D0")) %>%
      pixiedust::sprinkle(cols = 1, 
               width = 3,
               width_units = "in") %>%
      pixiedust::sprinkle_print_method("html") %>%
      print(asis = FALSE)
  }
  
  out <- paste0("<h3>Young Men</h3><br/>", YM, 
         "<br/><br/>",
         "<h3>Young Women</h3><br/>", YW)
  
  if (cat) return(cat(out)) else return(out)
}

utils::globalVariables(c("Birth_Date", "twelfth_birthday", "Full_Name",
                         "Print_Birthdate", "Sex"))
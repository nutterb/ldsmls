#' @name rpt_baptisms
#' @title Upcoming Baptisms
#' 
#' @description Retrieve the membership records of individuals who will 
#'   turn eight years old between two dates.  This provides a list of 
#'   members who will become eligible for baptism in the specified time
#'   period.
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

rpt_baptisms <- function(start_date, end_date, cat = FALSE)
{
  conn <- RSQLite::dbConnect(RSQLite::SQLite(), util_databasePath())
  Baptisms <- 
    RSQLite::dbReadTable(conn, "Membership") %>%
    dplyr::mutate(Birth_Date = as.Date(Birth_Date)) %>%
    dplyr::filter(as.Date(start_date) <= (Birth_Date + lubridate::years(8)) & 
                  as.Date(end_date) >= (Birth_Date + lubridate::years(8))) %>%
    dplyr::mutate(eighth_birthday = Birth_Date + lubridate::years(8),
                  Print_Birthdate = format(Birth_Date, format = "%d %B %Y"),
                  eighth_birthday = format(eighth_birthday, format = "%d %B %Y")) %>%
    dplyr::select(Full_Name, Print_Birthdate, eighth_birthday, Sex, Birth_Date) %>%
    dplyr::arrange(Birth_Date) %>%
    dplyr::select(-Print_Birthdate, -Birth_Date) 
  
  if (nrow(Baptisms) == 0) return("N/A")
  
  Baptisms %<>%
    pixiedust::dust() %>%
    pixiedust::sprinkle_colnames("Name", "Eighth Birthday", "Sex") %>%
    pixiedust::sprinkle_table(halign = "left") %>%
    pixiedust::sprinkle(bg_pattern = c("#FFFFFF", "#D0D0D0")) %>%
    pixiedust::sprinkle(cols = 1, 
             width = 3,
             width_units = "in") %>%
    pixiedust::sprinkle_print_method("html") %>%
    print(asis = FALSE)
  
  if (cat) return(cat(Baptisms)) else return(Baptisms)
}

utils::globalVariables(c("Birth_Date", "eighth_birthday", "Full_Name",
                  "Print_Birthdate", "Sex"))
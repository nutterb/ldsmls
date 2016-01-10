#' @name rpt_sunbeam
#' @title Upcoming Sunbeam Children
#' 
#' @description Retrieve the membership records of individuals who will 
#'   turn three years old between two dates.  This provides a list of 
#'   members who will become eligible for Sunbeams in the specified time
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

rpt_sunbeam <- function(start_date, end_date, cat = FALSE)
{
  conn <- RSQLite::dbConnect(RSQLite::SQLite(), util_databasePath())
  Sunbeam <- 
    RSQLite::dbReadTable(conn, "Membership") %>%
    dplyr::mutate(Birth_Date = as.Date(Birth_Date)) %>%
    dplyr::filter(as.Date(start_date) <= (Birth_Date + lubridate::years(3)) & 
                  as.Date(end_date) >= (Birth_Date + lubridate::years(3))) %>%
    dplyr::mutate(nursery_birthday = Birth_Date + lubridate::years(3),
                  Print_Birthdate = format(Birth_Date, format = "%d %B %Y"),
                  nursery_birthday = format(nursery_birthday, format = "%d %B %Y")) %>%
    dplyr::select(Full_Name, Print_Birthdate, nursery_birthday, Sex, Birth_Date) %>%
    dplyr::arrange(Birth_Date) %>%
    dplyr::select(-Print_Birthdate, -Birth_Date) 
  
  if (nrow(Sunbeam) == 0) return("N/A")
  
  Sunbeam %<>%
    pixiedust::dust() %>%
    pixiedust::sprinkle_colnames("Name", "Third Birthday", "Sex") %>%
    pixiedust::sprinkle_table(halign = "left") %>%
    pixiedust::sprinkle(bg_pattern = c("#FFFFFF", "#D0D0D0")) %>%
    pixiedust::sprinkle(cols = 1, 
             width = 3,
             width_units = "in") %>%
    pixiedust::sprinkle_print_method("html") %>%
    print(asis = FALSE)
  
  if (cat) return(cat(Sunbeam)) else return(Sunbeam)
}

utils::globalVariables(c("Birth_Date", "nursery_birthday", 
                         "Full_Name", "Print_Birthdate", "Sex"))
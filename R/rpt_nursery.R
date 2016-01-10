#' @name rpt_nursery
#' @title Upcoming Nursery Children
#' 
#' @description Retrieve the membership records of individuals who will 
#'   turn eighteen months old between two dates.  This provides a list of 
#'   members who will become eligible for Nursery in the specified time
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

rpt_nursery <- function(start_date, end_date, cat = FALSE)
{
  conn <- RSQLite::dbConnect(RSQLite::SQLite(), util_databasePath())
  Nursery <- 
    RSQLite::dbReadTable(conn, "Membership") %>%
    dplyr::mutate(Birth_Date = as.Date(Birth_Date)) %>%
    dplyr::filter(as.Date(start_date) <= (Birth_Date + months(18)) & 
                  as.Date(end_date) >= (Birth_Date + months(18))) %>%
    dplyr::mutate(nursery_birthday = Birth_Date + months(18),
                  Print_Birthdate = format(Birth_Date, format = "%d %B %Y"),
                  nursery_birthday = format(nursery_birthday, format = "%d %B %Y")) %>%
    dplyr::select(Full_Name, Print_Birthdate, nursery_birthday, Sex, Birth_Date) %>%
    dplyr::arrange(Birth_Date) %>%
    dplyr::select(-Print_Birthdate, -Birth_Date) 
  
  if (nrow(Nursery) == 0) return("N/A")
  
  Nursery %<>%
    pixiedust::dust() %>%
    pixiedust::sprinkle_colnames("Name", "Eighteen Month Birthday", "Sex") %>%
    pixiedust::sprinkle_table(halign = "left") %>%
    pixiedust::sprinkle(bg_pattern = c("#FFFFFF", "#D0D0D0")) %>%
    pixiedust::sprinkle(cols = 1, 
             width = 3,
             width_units = "in") %>%
    pixiedust::sprinkle_print_method("html") %>%
    print(asis = FALSE)
  
  if (cat) return(cat(Nursery)) else return(Nursery)
}

utils::globalVariables(c("Birth_Date", "nursery_birthday", 
                  "Full_Name", "Print_Birthdate", "Sex"))
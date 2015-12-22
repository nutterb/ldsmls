#' @name encode_id
#' @title Generate a Unique Identifier for the Database
#' 
#' @description A unique identifier for each member is critical to correctly
#'   joining tables in the database.  In order to avoid using the the 
#'   membership number as the identifier, a string is generated consisting of
#'   the member's record number, date of birth, unit number, and name.
#'   This string is encoded, and then select positions are removed from the 
#'   encoded string to prevent reconstruction of the membership number and 
#'   birth date.  The remaining characters are encoded again and the resulting
#'   string is used as the identifier.
#'   
#' @param x The string to be encoded.
#' 
#' @details It is still possible that two members could generate the same 
#'   unique identifier, though it is unlikely. If such an event occurs, please
#'   report the error on GitHub.
#'   
#' @author Benjamin Nutter
#' 
#' @export

encode_id <- function(x)
{
  charToRaw(x) %>%
    base64encode() %>%
    strsplit("") %>%
    unlist() %>%
    `[`(-c(4:7, 9:12, 21:24)) %>% #, 11, 17, 37)) %>%
    paste0(collapse = "") %>%
    charToRaw() %>%
    base64encode()
}
#' @name util_sqlValuePrep
#' @title Prepare A Value for SQL Injection
#' 
#' @description Prepares values for injection into a SQL database
#'   by wrapping in quotes, if necessary, or assigning missing values to
#'   a SQL \code{NULL}.
#'   
#' @param x The value to be injected into SQL.
#' 
#' @export

util_sqlValuePrep <- function(x)
{
  if (is.null(x)) return("NULL")
  else if (is.na(x)) return("NULL")
  else if (is.character(x)) return(paste0("'", x, "'"))
  else return(x)
}
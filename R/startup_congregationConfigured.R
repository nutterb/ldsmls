#' @name startup_congregationConfigured
#' @title Determine if Congregation is Configured
#' 
#' @description At a minimum, \code{ldsmls} requires that a unit number be
#' associated with the database.  The unit number is used in determining the 
#' unique identifier for each member.  On start up, this function is run 
#' to determine if 1) the Congregation table has exactly one row, or 2) the
#' Congregation table has one row and a value in the Unit Number field.  If
#' neither condition is satisfied, \code{FALSE} is returned and triggers the
#' UI to force the user to enter a unit number.
#' 
#' @export

startup_congregationConfigured <- function()
{
  conn <- RSQLite::dbConnect(RSQLite::SQLite(), "C:/ldsmls/congregation.db")
  
  Congregation <- RSQLite::dbReadTable(conn, "Congregation")
  
  RSQLite::dbDisconnect(conn)
  
  if (nrow(Congregation) != 1) return(FALSE)
  else if (is.na(Congregation$Unit_Number)) return(FALSE)
  else return(TRUE)
}
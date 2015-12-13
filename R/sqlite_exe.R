#' @name sqlite_exe
#' @title Retrieve the Location of the SQLite Executable
#' 
#' @author Benjamin Nutter
#' 
#' @export

sqlite_exe <- function()
{
  system.file("sqlite3.exe", package = "ldsmls")
}
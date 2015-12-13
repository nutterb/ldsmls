#' @name initialize_database
#' @title Intitialize the MLS Membership Database
#' 
#' @description When the application is first started, it checks to see if the 
#'   database has previously been created.  If not, a new database is made and the 
#'   user is prompted to load a membership file.  If the database already exists, the
#'   application will start as usual.
#'   
#' @author Benjamin Nutter
#' @export

initialize_database <- function()
{
  if (file.exists(file.path(getOption("mls_db_dir"), "congregation.db"))) return(TRUE)
  
  system(paste0(sqlite_exe(), " C:/ldsmls/congregation "), 
                input=query_create_database())
}

#* Utility Functions

#* This creates the path to the sqlite executable.
#* It is present here only to simplify the code above.
sqlite_exe <- function()
{
  system.file("sqlite3.exe", package = "ldsmls")
}
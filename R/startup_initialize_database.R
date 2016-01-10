#' @name startup_initialize_database
#' @title Intitialize the MLS Membership Database
#' 
#' @description When the application is first started, it checks to see if the 
#'   database has previously been created.  If not, a new database is made and the 
#'   user is prompted to load a membership file.  If the database already exists, the
#'   application will start as usual.
#'   
#' @author Benjamin Nutter
#' @export

startup_initialize_database <- function()
{
  if (file.exists(file.path(getOption("mls_db_dir"), "congregation.db"))) return(TRUE)

  if (!dir.exists("C:/ldsmls")) dir.create("C:/ldsmls")
  
  system(paste0("\"", sqlite_exe(), "\" \"", 
                file.path(getOption("mls_db_dir"), "congregation.db\"")), 
                input=query_create_database())
  return(TRUE)
}

#* Utility Functions

#* This creates the path to the sqlite executable.
#* It is present here only to simplify the code above.
sqlite_exe <- function()
{
  system.file("sqlite3.exe", package = "ldsmls")
}
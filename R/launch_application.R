#' @name launch_application
#' @title Launch the LDS MLS Extension Application
#' 
#' @description Start the Application.  First, the system checks that the database 
#'   file has been initialized in the appropriate location.  If not, it creates the
#'   database and tables.  After this check, the application is launched.
#'   
#' @author Benjamin Nutter
#' @export

launch_application <- function()
{
  if (!file.exists("C:/ldsmls/congregation")) initialize_database()
  
  shiny::runApp(system.file("application", package = "ldsmls"))
}
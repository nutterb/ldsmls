#' @name launch_application
#' @title Launch the LDS MLS Extension Application
#' 
#' @description Start the Application.  First, the system checks that the database 
#'   file has been initialized in the appropriate location.  If not, it creates the
#'   database and tables.  After this check, the application is launched.
#'   
#' @author Benjamin Nutter
#' 
#' @examples
#' \dontrun{
#'   launch_application()
#' }
#' 
#' @export

launch_application <- function(launch_browser)
{
  if (!file.exists("C:/ldsmls/congregation")) startup_initialize_database()
  
  shiny::runApp(system.file("application", package = "ldsmls"),
                launch.browser = launch_browser)
}
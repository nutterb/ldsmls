#' @name startup_congregation_configured 
#' @title Determine if there congregation has a unit number
#' 
#' @description Returns a logical value when a single unit number
#'   exists in the Congregation table.
#'   
#' @export

startup_congregation_configured <- function()
{
  ch_local <- dbConnect(RSQLite::SQLite(), "C:/ldsmls/congregation.db")
  on.exit(dbDisconnect(ch_local))
  
  Congregation <- dbReadTable(ch_local, "Congregation")
  
  if (!nrow(Congregation)) return(FALSE)
  
  !is.na(Congregation[["UnitNumber"]])
}
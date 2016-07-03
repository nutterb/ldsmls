#' @name btn_configure_congregation
#' @title Send Configuration Details to the Database
#' 
#' @description Adds or updates unit number, unit name, and unit type to the 
#'   Congregation table.
#'  
#' @param input The input object from the Shiny session  
#'  
#' @export

btn_configure_congregation <- function(input)
{
  ch_local <- dbConnect(RSQLite::SQLite(), "C:/ldsmls/congregation.db")
  on.exit(dbDisconnect(ch_local))
  
  Congregation <- dbReadTable(ch_local, "Congregation")
  
  configured <- 
    if (!nrow(Congregation)) FALSE
    else !is.na(Congregation[["UnitNumber"]])
  
  if (!configured)
  {
    dbSendQuery(
      ch_local,
      paste0("INSERT INTO Congregation ",
             "(UnitName, UnitNumber, UnitType) ",
             "VALUES ",
             "('", input[["unit_name"]], "', '", input[["unit_number"]], 
               "', '", input[["unit_type"]], "');")
    )
  }
  else
  {
    dbSendQuery(
      ch_local,
      paste0("UPDATE Congregation ",
             "SET UnitName = '", input[["unit_name"]], "', ",
             "    UnitNumber = '", input[["unit_number"]], "', ",
             "    UnitType = '", input[["unit_type"]], "';")
    )
  }
}
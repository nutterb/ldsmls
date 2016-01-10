#' @name btn_configureDatabase
#' @title Configure the Values of the Unit Database.
#' 
#' @description Provide values to the unit number, unit name, unit type, 
#'   and unit leader fields in the CONGREGATION table.
#'   
#' @param input The input object from the shiny session.
#' 
#' @export

btn_configureDatabase <- function(input){
  conn <- RSQLite::dbConnect(RSQLite::SQLite(),
                             util_databasePath())
  RSQLite::dbSendQuery(
    conn,
    paste0("UPDATE CONGREGATION ",
           "SET ",
           "Unit_Name = ", util_sqlValuePrep(input$unitName), ", ",
           "Unit_Number = ", util_sqlValuePrep(input$unitNumber), ", ",
           "Unit_Type = ", util_sqlValuePrep(input$unitType), ", ",
           "Bishop = ", util_sqlValuePrep(input$bishop)))
  RSQLite::dbDisconnect(conn)
}
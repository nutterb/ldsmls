#' @name btn_initializeDatabase
#' @title Initialize the Values of the Unit Database.
#' 
#' @description Provide values to the unit number, unit name, unit type, 
#'   and unit leader fields in the CONGREGATION table.
#'   
#' @param input The input object from the shiny session.
#' 
#' @export

btn_initializeDatabase <- function(input){
  if (input$initialize_unitNumber == "")
  {
    msg <- "A Unit Number must be provided"
  } else
  {
    conn <- RSQLite::dbConnect(RSQLite::SQLite(),
                               file.path(getOption("mls_db_dir"), 
                                         "congregation.db"))
    RSQLite::dbSendQuery(
      conn,
      paste0("INSERT INTO CONGREGATION ",
             "(Unit_Name, Unit_Number, Unit_Type, Bishop) ",
             "VALUES ",
             "(", util_sqlValuePrep(input$initialize_unitName), ", ",
                  util_sqlValuePrep(input$initialize_unitNumber), ", ", 
                  util_sqlValuePrep(input$initialize_unitType), ", ",
                  util_sqlValuePrep(input$initialize_bishop), ")"))

    RSQLite::dbDisconnect(conn)
    msg <- "SUCCESS"
  }
  msg
}
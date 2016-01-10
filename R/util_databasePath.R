#' @name util_databasePath
#' @title Retrieve path to Database File
#' 
#' @description A wrapper function for getting the path to the database 
#'   file.
#'
#' @export

util_databasePath <- function()
{
  file.path(getOption("mls_db_dir"), "Congregation.db")
}
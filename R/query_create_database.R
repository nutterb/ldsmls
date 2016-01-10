#' @name query_create_database
#' @title Create the Tables for the Application Database
#' 
#' @description When \code{\link{startup_initialize_database}} runs, it executes a query 
#'   to create the database and various tables used by the application.  The SQL
#'   code used to generate those tables is called by this function.
#'   
#' @author Benjamin Nutter
#' @export

query_create_database <- function()
{
  paste0("CREATE TABLE Membership ",
         "  (ID VARCHAR, ",
         "   Birth_Date DATE, ", 
         "   Sex VARCHAR, ",
         "   Full_Name VARCHAR, ",
         "   Maiden_Name VARCHAR); ",
         " ",
         "CREATE TABLE Congregation ",
         "  (Unit_Name VARCHAR, ",
         "   Unit_Number VARCHAR, ",
         "   Unit_Type VARCHAR, ",
         "   Bishop VARCHAR); ",
         " ",
         "CREATE TABLE Callings ",
         "  (OID INT PRIMARY KEY, ",
         "   MemberID INT, ",
         "   Call_Consider BOOLEAN, ",
         "   Call_Decide BOOLEAN, ",
         "   Call_Extend BOOLEAN, ",
         "   Call_Sustain BOOLEAN, ",
         "   Record_Sustain DATE, ",
         "   Call_SetApart BOOLEAN, ",
         "   Record_SetApart BOOLEAN, ",
         "   Release_Consider BOOLEAN, ",
         "   Release_Decide BOOLEAN, ",
         "   Release_Date DATE, ",
         "   Record_Release BOOLEAN);"
  )
}
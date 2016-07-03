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
  if (file.exists(file.path(getOption("mls_db_dir"), "congregation.db"))) return(NULL)
  
  if (!dir.exists("C:/ldsmls")) dir.create("C:/ldsmls")
  
  sql <- 
    system.file("SQL/create_tables.sql", package = "ldsmls") %>%
    readLines()
  
  system(paste0("\"", sqlite_exe(), "\" \"", 
                file.path(getOption("mls_db_dir"), "congregation.db\"")), 
         input=sql)
  
  ch_local <- dbConnect(RSQLite::SQLite(), "C:/ldsmls/congregation.db")
  on.exit(dbDisconnect(ch_local))
  
  system.file("CallingsData/Organizations.csv", package = "ldsmls") %>%
    read.csv(stringsAsFactors = FALSE) %>%
    dplyr::mutate(
      Custom = 0,
      value = sprintf("(%s, '%s', %s, %s)",
                      OID, Organization, Custom, Enabled)
    ) %>%
    `$`("value") %>%
    paste0(collapse = ", ") %>%
    sprintf("INSERT INTO Organization (OID, OrganizationName, Custom, Enabled) VALUES %s;",
            .) %>%
    dbSendQuery(ch_local, .)
  
  system.file("CallingsData/StandardCallings.csv", package = "ldsmls") %>%
    read.csv(stringsAsFactors = FALSE) %>%
    dplyr::mutate(
      Custom = 0,
      value = sprintf("(%s, %s, %s, '%s', %s, %s)",
                      OID, Organization, OrderID, Position, Custom, Enabled)
    ) %>%
    `$`("value") %>%
    paste0(collapse = ", ") %>%
    sprintf("INSERT INTO Position (OID, Organization, OrderID, Position, Custom, Enabled) VALUES %s;",
            .) %>%
    dbSendQuery(ch_local, .)
}

#* Utility Functions

#* This creates the path to the sqlite executable.
#* It is present here only to simplify the code above.
sqlite_exe <- function()
{
  system.file("sqlite3.exe", package = "ldsmls")
}
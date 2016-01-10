#' @name btn_importRecords
#' @title Import Membership Records
#' 
#' @description Inserts or updates membership records from a CSV file into 
#'   the Membership table.
#'   
#' @param input the input object from the shiny session
#' 
#' @export

btn_importRecords <- function(input)
{
  Membership <- 
    utils::read.csv(input$membershipFile$datapath,
                    stringsAsFactors = FALSE,
                    na = "") %>%
    dplyr::mutate(Birth.Date = as.Date(Birth.Date, format = "%d %b %Y"), 
                  Full.Name = gsub("'", "''", Full.Name),
                  Maiden.Name = gsub("'", "''", Maiden.Name),
                  Name = ifelse(is.na(Maiden.Name),
                                Full.Name, 
                                Maiden.Name),
                  idstring = paste0(Record.Number, Birth.Date, "1234", Name),
                  ID = vapply(idstring, util_encode_id, character(1))) %>%
    dplyr::filter(!is.na(Record.Number)) %>%
    dplyr::select(ID, Birth.Date, Sex, Full.Name, Maiden.Name) %>%
    dplyr::mutate(Birth.Date = format(Birth.Date, "%Y-%m-%d")) %>%
    stats::setNames(c("ID", "Birth_Date", "Sex", "Full_Name", "Maiden_Name"))
  
  conn <- RSQLite::dbConnect(RSQLite::SQLite(),
                             util_databasePath())
  Current <- RSQLite::dbReadTable(conn, "Membership")
  
  for (i in 1:nrow(Membership))
  {
    if (!Membership$ID[i] %in% Current$ID[i])
    {
      query <- 
        paste0("INSERT INTO Membership ",
               "(ID, Birth_Date, Sex, Full_Name, Maiden_Name) ",
               "VALUES ",
               "(", 
               util_sqlValuePrep(Membership$ID[i]), ", ",
               util_sqlValuePrep(Membership$Birth_Date[i]), ", ",
               util_sqlValuePrep(Membership$Sex[i]), ", ",
               util_sqlValuePrep(Membership$Full_Name[i]), ", ",
               util_sqlValuePrep(Membership$Maiden_Name[i]), ")")
                                        
    }
    else
    {
      query <-  
        paste0("UPDATE Membership SET ",
               "Birth_Date = ", util_sqlValuePrep(Membership$Birth_Date[i]), ", ",
               "Sex = ", util_sqlValuePrep(Membership$Sex[i]), ", ",
               "Full_Name = ", util_sqlValuePrep(Membership$Full_Name[i]), ", ",
               "Maiden_Name = ", util_sqlValuePrep(Membership$Maiden_Name[i]), " ",
               "WHERE ID = ", util_sqlValuePrep(Membership$ID[i]))
    }
    
    RSQLite::dbSendQuery(conn, query)
  }
  
  RSQLite::dbDisconnect(conn)
}

utils::globalVariables(c("Birth.Date", "Full.Name", "Maiden.Name",
                  "Sex", "Record.Number", "Name", "idstring", "ID"))
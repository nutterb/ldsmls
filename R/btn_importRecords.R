#' @name btn_importRecords
#' @title Import Membership Records
#' 
#' @description Inserts or updates membership records from a CSV file into 
#'   the Membership table.
#'   
#' @param Import The data from the file being imported (Membership())
#' @param Current The Currently stored data (RV$Membership)
#' 
#' @export

btn_importRecords <- function(Import, Current, conn)
{
  if (nrow(Current))
  {
    New <- Import[!Import$ID %in% Current$MemberID, ]
    Exist <- Import[Import$ID %in% Current$MemberID, ]
  }
  else
  {
    New <- Import
    Exist <- Current
  }

  if (nrow(New))
  {
    sql <- 
      New %>%
      mutate(sql = sprintf("('%s', %s, '%s', '%s', %s, 1)",
                           ID, 
                           format(Birth_Date,
                                  format = "%Y-%m-%d"),
                           Sex, 
                           gsub("'", "''", Full_Name),
                           ifelse(is.na(Maiden_Name), 
                                  "NULL", 
                                  paste0("'", gsub("'", "''", Maiden_Name), "'")))) %>%
      `$`("sql") 
      
      dbSendQuery(
        conn = conn,
        statement =
          paste0("INSERT INTO Membership ",
                 "(MemberID, BirthDate, Sex, FullName, MaidenName, Enabled) ",
                 "VALUES ",
                 paste(sql, collapse = ", "))
      )
 
    # dbSendPreparedQuery(
    #   conn = ch,
    #   statement = paste0("INSERT INTO Membership ",
    #                      "(MemberID, BirthDate, Sex, FullName, MaidenName, Enabled) ",
    #                      "VALUES ",
    #                      "(?, ?, ?, ?, ?, 1);"),
    #   bind.table = dplyr::select(New, ID, Birth_Date, Sex, Full_Name, Maiden_Name)
    # )
  }
  # 
  # if (nrow(Exist))
  # {
  #   dbSendPreparedQuery(
  #     conn = ch,
  #     statement = paste0("UPDATE Membership ",
  #                        "SET BirthDate = ?, Sex = ?, FullName = ?, ",
  #                        "  MaidenName = ? WHERE MemberID = ?"),
  #     bind.table = Import[, c("Birth_Date", "Sex", "Full_Name", "Maiden_Name", "ID")]
  #   )
  # }
}
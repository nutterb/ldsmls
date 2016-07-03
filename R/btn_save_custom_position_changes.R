#' @name btn_save_custom_position_changes
#' @title Save Change to Custom Positions
#' 
#' @description Save current changes to custom positions
#' 
#' @param input The input object from the shiny session
#' 
#' @export

btn_save_custom_position_changes <- function(input)
{
  order_change <- vapply(names(input)[grepl("position_order_", names(input))],
                         function(x) input[[x]],
                         numeric(1))
  title_change <- vapply(names(input)[grepl("position_name_", names(input))],
                         function(x) input[[x]],
                         character(1))
  
  OID <- sub("position_order_", "",
             vapply(names(input)[grepl("position_order_", names(input))],
                    identity,
                    character(1))) %>%
    as.numeric()
  
  if (any(trimws(title_change) == ""))
  {
    return(FALSE)
  }
  
  dbSendPreparedQuery(
    conn = ch,
    statement = paste0("UPDATE Position ",
                       "SET OrderID = ?, ",
                       "    Position = ? ",
                       "WHERE OID = ?;"),
    bind.data = data.frame(OrderID = order_change,
                           Position = title_change,
                           OID = OID)
  )
  
  # for (i in seq_along(OID))
  # {
  #   sql <- paste0("UPDATE Position ",
  #                 "SET OrderID = ", order_change[i], ", ",
  #                 "    Position = '", gsub("'", "''", title_change[i]), "' ",
  #                 "WHERE OID = ", OID[i], ";")
  #   pritn(sql)
  #   dbSendQuery(ch, sql)
  # }
  
  TRUE
                         
}
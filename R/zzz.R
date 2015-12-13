.onLoad <- function(libname,pkgname)
{
  if (!file.exists("C:/ldsmls"))
  {
    dir.create("C:/ldsmls")
  }
  options(mls_db_dir = "C:/ldsmls")
}

.onUnload <- function(libPath)
{
  options(mls_db_dir = NULL)
}
# ldsmls
Utilities to extend functionality for LDS Member and Leader Services.

Member and Leader Services is the database application used by local congregations of the Church of Jesus Christ of Latter-day Saints for managing membership and financial records. The `ldsmls` package uses a SQLite database with a shiny application front end to provide additional options for organizing information to be entered into MLS.

`ldsmls` does not and cannot send information directly into MLS, and so use of this application requires that a certain amount of duplication of data entry. The goal of `ldsmls` is to help organize information prior to it being entered into MLS, as well as track tasks that need to be completed prior to recording information into MLS.

Core functionality for the application includes:

1. Tracking proposed callings and releases
2. A history of callings served by members of the congregation.
3. Checklists for members under consideration for the address unknown file.
4. Sacrament meeting agendas and programs/histories
5. Canned reports for certain life events (especially in Primary)

`ldsmls` requires the exported membership file from MLS and will not function without this file. Furthermore, it is intended to run on the congregation's local computer, and must not be utilized on any third party server. `ldsmls` makes no claim of security regarding membership data and assumes no responsibility for data leaks or breaches. It is used strictly at your own risk. However, if used as intended on the local congregation's computer, it should pose no threat to data security.

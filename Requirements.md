# MLS Extension Utilities

MLS Extension Utilities (MEU) is a WinForms application that provides structured, relational tools to assist ward and branch clerks with the day-to-day management of LDS wards and branches. The core features of the application are

1. Tracking callings from consideration through setting apart through release. 
2. Ward callings history reports.
3. Sacrament meeting agendas.
4. Checklists and notes for tracking the progress of locating and moving records for lost members.

MEU does not:

* Replace any functionality in MLS nor in the online Leader and Clerk Resources (LCR)
* Communicate in any way with MLS or other church databases

It is important to note that some data entries to MEU will require dual entry to MLS.  This is particularly true of callings data; callings must be properly logged in LCR to permit members access to Church-developed tools related to their callings.  It is believed that the advantages of tracking tools and historical reports will outweigh the disadvantage of dual data entry.

## System Requirements 

* Windows 7
* SQL Server Express 2014

This application is developef and tested on the Windows 7 operating system. Use Windows 8 or higher at your own risk. Note that Microsoft SQL Server Express 2016 does _not_ support Windows 7. If using Windows 8 or higher, you must install SQL Server Express 2016.

## Modules

MEU is organized into modules that focus on specific tasks.  Each module consists of at least one user interface panel and may consist of several. Specific requirements for each module are listed in the following sections.

1. Unit Configuration
2. Membership Record Import
3. Callings and Releases
4. Sacrament Meeting Programs
5. Membership Record Tracking
6. Budget formulation

Module requirements are numbered in the format `x.y`, where `x` represents the module number above, and `y` represents the requirement within that module.  Requirements are given to specify the behavior of the module in an observable, measurable manner that will guide both development and testing activities.

### Unit Configuration

| Requirement Number | Description                  | Event Tracked | 
|--------------------|------------------------------|---------------|
| 1.1 | Record the unit number from user input | Yes |
| 1.2 | Record the unit name from user input | Yes |
| 1.3 | Record the unit meeting schedule from user input | Yes |


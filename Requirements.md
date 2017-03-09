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

The Unit Configuration module accepts information from the user to be made available for potential reports about the unit.  Changes to the configuration are tracked so that they may be applied to historical reports.

| Requirement Number | Description                  | Event Tracked | 
|--------------------|------------------------------|---------------|
| 1.1 | Record the unit number from user input | Yes |
| 1.2 | Record the unit name from user input | Yes |
| 1.3 | Record the unit meeting schedule from user input | Yes |
| 1.4 | Changes to the unit meeting schedule require the date the changes take effect. | No |

### Membership Record Import

The Membership Record Import module assists the user with importing the Membership file obtained from MLS and populating the Membership table in MEU.  

| Requirement Number | Description                  | Event Tracked | 
|--------------------|------------------------------|---------------|
| 2.1 | Allow the user to import a file | No |
| 2.2 | Validate the column names in the file to include member name, preferred name, sex, and birthdate | No | 
| 2.3 | Generate a unique ID for each member based on the membership information | No |
| 2.4 | Add records from the membership file not present in the MEU database to the MEU database | Yes | 
| 2.5 | Update records from the membership file that differ from those in the MEU database | Yes | 

### Callings and Releases

The Callings and Releases module provides tools for tracking member callings. It provides checklists to guide clerks through callings being considered through the sustaining and setting apart.  Additionally, callings that have been issued may be selected when releases are being considered.  Maintaining the checklist assists clerks in building action lists to share with bishoprics and presidencies.


| Requirement Number | Description                  | Event Tracked | 
|--------------------|------------------------------|---------------|
| 3.1 | User may select any member in the MEU database for consideration in a calling | No |
| 3.2 | A selected user may be associated with an organization and calling within that organization | No | 
| 3.3 | Record when it has been decided to issue the calling to the member | No | 
| 3.4 | Record when a calling has been issued to the member | No | 
| 3.5 | Record the date a member is sustained to a callilng | No |
| 3.6 | Record when the sustaining has been entered into LCR | No | 
| 3.7 | Record when a member has been set apart to a calling | No |
| 3.8 | Record when a setting apart has been entered into LCR | No |
| 3.9 | An existing calling may be selected to be considered for release | No |
| 3.10 | Record when it has been decided to issue a release | No |
| 3.11 | Record when a release has been issued | No |
| 3.12 | Record the date the release is announced in the appropriate meeting | No |
| 3.13 | Record when the release has been entered into LCR | No |
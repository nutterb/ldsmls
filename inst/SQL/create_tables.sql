CREATE TABLE Membership 
  (OID INTEGER PRIMARY KEY, 
   MemberID VARCHAR,
   BirthDate DATE, 
   Sex VARCHAR, 
   FullName VARCHAR, 
   MaidenName VARCHAR,
   Enabled BOOLEAN); 

CREATE TABLE Congregation 
  (UnitName VARCHAR, 
   UnitNumber VARCHAR, 
   UnitType VARCHAR, 
   UnitLeader VARCHAR); 
   
CREATE TABLE Organization
  (OID INTEGER PRIMARY KEY, 
   OrganizationName VARCHAR,
   Custom BOOLEAN,
   Enabled BOOLEAN); 
   
CREATE TABLE Position
  (OID INTEGER PRIMARY KEY, 
   Organization INTEGER, 
   OrderID INTEGER, 
   Position VARCHAR,  
   Custom BOOLEAN,
   Enabled BOOLEAN); 
   
CREATE TABLE Calling 
  (OID INTEGER PRIMARY KEY, 
   MemberID VARCHAR, 
   Organization VARCHAR, 
   Position VARCHAR, 
   Decide BOOLEAN, 
   Extend BOOLEAN, 
   Sustain DATE, 
   RecordSustain BOOLEAN, 
   SetApart BOOLEAN, 
   RecordSetApart BOOLEAN);
   
CREATE TABLE Release
  (OID INTEGER PRIMARY KEY,
   Calling INTEGER,
   Consider BOOLEAN, 
   Decide BOOLEAN, 
   ReleaseDate DATE, 
   RecordRelease BOOLEAN); 
   
CREATE VIEW CallingTrack AS
  SELECT C.OID, C.MemberId, M.FullName,
         O.OID AS OrganizationID,
         O.OrganizationName,
         P.OID AS PositionID,
         P.Position,
         C.Decide,
         C.Extend,
         C.Sustain,
         C.RecordSustain,
         C.SetApart,
         C.RecordSetApart
  FROM Calling C 
    LEFT JOIN Membership M
      ON C.MemberID = M.MemberID
    LEFT JOIN Organization O
      ON C.Organization = O.OID
    LEFT JOIN Position P
      ON C.Position = P.OID;

| Table | Column | Type | Description |
| Membership | | | |
| Callings | OID | INT | Object identifier |
| Callings | MemberID | INT | Member identifier from Membership table |
| Callings | Call_Consider | BOOLEAN | Flag to identify that the member is under consideration for a calling. |
| Callings | Call_Decide | BOOLEAN | Flag that the decision has been made to call the member. |
| Callings | Call_Extend | BOOLEAN | Flag that the calling has been extended to the member. |
| Callings | Call_Sustain | DATE | Date that the member was sustained. | 
| Callings | Record_Sustain | BOOLEAN | Flag that the sustaining date has been recorded in MLS. |
| Callings | Call_SetApart | BOOLEAN | Flag that the member has been set apart to the calling. | 
| Callings | Record_SetApart | BOOLEAN | Flag that the setting apart has been recorded in MLS. | 
| Callings | Release_Consider | BOOLEAN | Flag that the member is being considered for release. | 
| Callings | Release_Decide | BOOLEAN | Flag that the decision has been made to release the member. | 
| Callings | Release_Date | DATE | Date the member was released. | 
| Callings | Record_Release | BOOLEAN | Flag that the release has been recorded in MLS. | 

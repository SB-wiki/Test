# Error-log-sync-in-Sunbird-Desktop-App

\*\*Overview: \*\* Currently, Deskstop App has a logging system that stores the log in the file system. These logs have the type of log, error message, time-stamp. We can debug the errors locally by accessing the log files.&#x20;

\*\*Problem  statement: \*\* As part of the error log sync to the server, the system should not have the repetitive/duplicate logs, and it should have the required data to make debugging easier. So we should have listed down some possible errors along with there unique CODE and Identifier

\*\*Solution: \*\* We will list all the possible scenarios where fatal errors might come. Code is a Unique key for error where ID is a combination of the CODE and ID, where ID is an individual attribute for the error such as do\_id, batchId. For better implementation, we can encode ID with base64 Encoding.

The following are some Generic errors which may occur during the App lifecycle:

\| | **CODE** | **ID** | | 1 | ecar\_filename | | 2 | low\_disk\_space | | 3 | ecar\_already\_added | | 4 | content\_do\_id | | 5 | content\_do\_id | | 6 | content\_do\_id | | 7 | content\_do\_id | | 8 | content\_do\_id | | 9 | batchId | | 10 | file\_path | | 11 | batch\_ID | | 12 | help\_desk\_down | | 13 | type\_subtype\_action | | 14 | channel\_id | | 15 | language\_code | | 16 | tenant\_id | | 17 | do\_id | | 18 | do\_id | | 19 | device\_profile\_id | | 20 | status (online/offline) | | 21 | search\_keyword | | 22 | app\_update | | 23 | system\_info | | 24 | change\_content\_location | | 25 | user\_create | | 26 | user\_id | | 27 | user\_id | | 28 | location\_keyword | | 29 | location\_keyword | | 30 | app\_start | | 31 | app\_crash | | 32 | req\_id (e.g. '/dialog/content/export') | | 33 | crash\_reporter | | 34 | unknown | | --- | --- | --- |

| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| --- |
| 1   |
| 2   |
| 3   |
| 4   |
| 5   |
| 6   |
| 7   |
| 8   |
| 9   |
| 10  |
| 11  |
| 12  |
| 13  |
| 14  |
| 15  |
| 16  |
| 17  |
| 18  |
| 19  |
| 20  |
| 21  |
| 22  |
| 23  |
| 24  |
| 25  |
| 26  |
| 27  |
| 28  |
| 29  |
| 30  |
| 31  |
| 32  |
| 33  |
| 34  |

***

\[\[category.storage-team]] \[\[category.confluence]]

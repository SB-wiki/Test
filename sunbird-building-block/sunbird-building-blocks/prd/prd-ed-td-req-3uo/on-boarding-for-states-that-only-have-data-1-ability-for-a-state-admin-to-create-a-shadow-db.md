# On-boarding-for-states-that-only-have-data-1----Ability-for-a-state-admin-to-create-a-shadow-DB

Introduction

State admin will be provided with the ability to upload a valid list of state users on the portal - The portal will support the ability to accept a .CSV file with a list of users as input.

This list will be used as a reference to validate users who carry out a self sign up. Any user accounts thus validated will be moved to the state tenant from the custodian org - as a valid state user.

Jira Ticket: [SC-1241 System JIRA](https://browse/SC-1241)

JTBD

* \*\*Jobs To Be Done: \*\* A state that has clean, up-to-date user data available can create a listing of valid users - this list is used as a reference by the system to carry out checks each time a user signs up OR signs in

(note that this does not enable pre-creation of user accounts using the list - as was the case with bulk uploads)

The upload of user details into the shadow DB is permitted only via the portal

* **User Personas:**  State admins tasked with on boarding valid state users on to the system
* **System or Environment:**  Elaborate the system or environment in which the product will be used

Requirement Specifications

* Use case overview

On boarding support for states that claim to have clean, recent data - but do not have in-use systems that teachers log in to on a regular basis. This workflow helps state declare a list of valid state users that can be used as a reference against users who self sign-up.

NOTE:

> > Matching of entries in the shadow DB to user accounts in the custodian org will be done based on the user identifier (email ID/ phone number)

> > Once a match is found and an account is migrated from the custodian account to the state tenant, the account is marked as "Claimed" in the Shadow DB - the identifiers for this account are now 'locked' - meaning they cannot be over-written by a shadow DB upload. The phone number/ email ID for a claimed account can only be edited by the user via the UI

> > Matching of entries within the shadow DB is done based on the User external ID alone. If the state admin uploads a new file to the shadow DB, the file is compared with the existing entries in the shadow DB using the external user ID -  if the record is found to exist in the shadow DB, it is overwritten with the new entry - only if it is still Unclaimed. If the record has already been claimed, only state owned parameters (School, roles) can be updated in the shadow DB entry. The user identifiers (phone/ email) are owned by the user, and cannot be updated via the shadow DB

* Overall process workflow

1> The state admin can choose the " **Manage Users** " option from the drop down menu in their Profile page &#x20;

2>  The 'Manage Users' page lets the admin Upload a file (users list - for the state). \[ Browse, Select file → Upload / Cancel ]

The upload will not be carried out partially - either entires in the file are ingested, or the whole file fails (if any entries in the file fail upload) - the entire file will be accepted post pre-upload validation. If there are errors in upload, the whole file will be rejected. The first cut will not support partial success/ failures of files. The pre-upload validation process is expected to provide users with feedback about what is wrong with the file (Eg. Duplicate entry in row 32, incorrect entry in row 54 etc.) - so that requisite corrections can be made before the upload in re-initiated.

If the upload is successful, the user is prompted with an "Upload success" message. If not, the failure message "Upload Failed - please retry" is displayed.&#x20;

3> The bulk listing of users will reside in a shadow DB that will support the following fields per user record :  _Mandatory fields provided as state input for the listing upload file (user details) :_

* Name \* (name of the user as per state records)
* Email ID :: Identifier \* (phone number OR email ID - one of the two is mandatory)&#x20;
* Phone number :: Identifier \* (phone number OR email ID - one of the two is mandatory)
* State \*  (State the user belongs to. See full list here)   - Update :: Dropping 'State' from the upload file format. A state admin can only upload users list for their own state (i.e. - channel of state admin = 'State' of all entries in the file being uploaded). The system will automatically assign all records in the file to the same channel (state) as that of the admin carrying out the upload.
* Ext Org ID \*   (School ID as provided in Diksha)&#x20;
* &#x20;Ext User ID \*   (State ID of the user)&#x20;
* Input Status (ACTIVE, INACTIVE, ) \* - input record status as provided by state admin
* Roles (System roles to be assigned to the user. See full list here). :: Dropping 'Roles' post discussion with Pramod.

_>> The fields listed above should also be displayed on the "Manage Users" page under the heading_ < File format for users list creation >

_All records inserted by the state admin in the upload file will be marked as Active/ Inactive - depending on whether the user account is active (new account, edits to existing accounts) or inactive (accounts to be deleted)_

_Additional flags to be maintained by the system against the records:_

* State (Channel) - as derived from the channel of the admin who carries out the upload
* User Action (UNCLAIMED, VALIDATED, REJECTED, FAILED ) \* - status based on user action.

_All records in the Shadow DB by default will be set to User Action “UNCLAIMED”. When a user claims a record successfully - ie. account is migrated to the state tenant post ext. user ID verification - the status will be updated to ‘VALIDATED’. If the record matches a user in the custodian org, and the user rejects the request to claim the record, the record will be marked as ‘REJECTED’ - such records can be sent back to the state as incorrect records. A record that a user attempts to claim, but doesn’t pass the external ID check during the validation process will be marked as ‘FAILED’_

File format for upload: .CSV (file upload to shadow DB is carried out as a sync activity)

Maximum number of entries per file : 15000&#x20;

See wireframe:

![](<../../../../PRD/prd-ed-td-req-3uo/images/storage/Screenshot 2019-08-27 at 10.12.18 AM.png>)

_Validation checks to be carried out on excel/ csv file before bulk listing upload:_

The bulk list that the state admin uploads will undergo basic checks before the upload is carried out

> Duplicity of Teacher ID (ext. ID) within the same excel/ csv file

> Format checks for email, phone number (10 digits) - note that there is no duplicate check required for email ID or Phone

> Presence of all mandatory fields

> Values listed in ‘State’ are as per System values, and don’t have different variants

> No special chars in field ‘Name’ except for the period (.)

> Ext. org ID is as per system mapping (TBD)

The pre-upload validation exercise should also provide the user with feedback about what is wrong with the file - eg. Duplicate entry at row 32, invalid entry at row 45 etc. This will help users correct the file so that it does not fail when the upload is attempted.

4> Once the user selects a file for upload, the pre-upload validations are carried out (with error prompting to the user - if any. Once the checks are cleared, the file is uploaded onto the system, and the user is shown a "File successfully uploaded" message.&#x20;

5>  The entires in the file are pushed to the shadow DB for comparison against existing/ new users (this can happen in an async fashion). Comparison against entries in the shadow DB are carried out based on the User Ext. ID - a duplicate entry that is already present in the shadow DB is overwritten with the new entry, while a new entry in the file is a fresh insert into the Shadow DB.&#x20;

6>  The Shadow DB user listing can be periodically updated by the state admin by uploading a new file:

* New records in the file (based on {ext. user IDs + State} that don’t exist in the shadow DB) get appended to the DB
* Updates to existing records (based on {ext. user IDs + State} that already exist in the shadow DB) will cause a record to overwrite.

7> Updates to 'claimed' records in the Shadow DB are propagated to the Diksha DB (async) - however, the fields for email ID and Phone number in Diksha cannot be overwritten by the Shadow DB entry. This information is set by the user. Other fields such as Name, Org (school) membership, etc. can be updated in the Diksha DB by an entry in the shadow DB. i.e. - State admin can use the shadow DB as a means of updating Org membership, Name, etc.

8> Telemetry To be generated

&#x20;    \- While uploading the CSV file by ADMIN:

&#x20;   &#x20;

{"eid":"AUDIT","ets":1569241529882,"ver":"3.0","mid":"1569241529882.49e1b523-8052-4682-bc46-68e96b7fa162","actor":{"id":"d3574a7e-ee52-482e-bd2e-e0be7e7992c9","type":"User"},"context":{"channel":"01261240974382694447","pdata":{"id":"local.sunbird.learning.service","pid":"learning-service","ver":"2.4.0"},"env":"User","cdata":\[{"id":"0128552273281761280","type":"ProcessId"},{"id":"15000","type":"TaskCount"}],"rollup":{\}},"object":{"id":"0128552273281761280","type":"MigrationUser"},"edata":{"state":"ShadowUserUpload","props":\["id","data","objectType","organisationId","retryCount","status","uploadedBy","uploadedDate","taskCount","createdBy"]\}}                       &#x20;

```
   - While Migrating user:
```

&#x20;

{"eid":"AUDIT","ets":1569324325508,"ver":"3.0","mid":"1569324325508.38c12c41-04a4-4e17-892f-79790a4751f4","actor":{"id":"0128559062617210883","type":"System"},"context":{"channel":"01261240974382694447","pdata":{"id":"local.sunbird.learning.service","pid":"learning-service","ver":"2.4.0"},"env":"ShadowUserUpload","cdata":\[{"id":"0128559066004684802","type":"ProcessId"}],"rollup":{"l1":"0128504150530457600"\}},"object":{"id":"43a3fce3-8da2-4f3f-b429-95e41bb8d7c7","type":"User"},"edata":{"state":"MigrationUser","props":\["claimedOn","claimStatus","createdOn","email","name","orgExtId","phone","processId","updatedOn","userExtId","userId","userStatus","userIds","channel","addedBy"]\}}

Unclaimed records will be overwritten in full if a new upload is made.&#x20;

* Localisation requirements &#x20;

(Support for names to be uploaded in regional languages? - to be discussed)

* Telemetry requirements

Log uploads made, successes/ failures, details of each file uploaded - time of upload, uploaded by, number of entries, State, Status (success/ failure)

* Note: V1 Approach

Revival of Bulk user upload workflows:

We could look at reviving the retired 'bulk upload of users' functionality to jump start this effort - the system will however not create the user accounts/ send notifications etc. as with the bulk upload functionality. Instead, the users listing data will be scrubbed for basic checks (ID duplicity, incorrect formats etc.) and will be ingested onto the Shadow DB as the reference list of valid state users.

**NOTE : Temporary migration of user accounts (until release 2.5)**

System level support for detection of shadow DB matches and migration of user accounts to the state tenant is expected to be built as part of release 2.5. Until this is available, the team will provision for scripts that are run periodically (once a day) to compare shadow DB entries against phone/ email of users who have self signed up.

If an ID match is detected, the user account is migrated to the state tenant via the backend script. The entry for the account in the Shadow DB is consequently updated to “VALIDATED”

Matching needs to be carried out only against users who are set to "ACTIVE" status in the Shadow DB. Inactive records need not be considered for matching. However, if a user record is overwritten by the admin from being Active to Inactive, the said account should be suspended by the system.

cc:&#x20;

There will also be a script written to capture user conversion stats from custodian to state - by tenant. This will be used to provide interim reports to the state until the portal enables such reporting functionality.)

For Future ReleaseSee ticket for&#x20;

Shadow DB part 2 :: Auto match with ID in custodian + teacher ID validation

[SC-1243 System JIRA](https://browse/SC-1243)

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]

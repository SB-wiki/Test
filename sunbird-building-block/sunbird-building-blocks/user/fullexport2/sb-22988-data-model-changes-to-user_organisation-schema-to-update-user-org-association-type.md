As part of user-org refactoring to suit manage learn use cases, from 3.7 release system should be able to capture user-org association type and user validation status in user_organisation table.

Association Types

Bit position 0 => 1 - implies validated, 0 - Non-Validated

Bit position 1 => 1 - implies user supplied, 0 - org supplied

00 (0 in decimal) - org supplied + non validated (This is not possible at the moment as we assume all the org supplied values are validated)

01 (1 in decimal) - org supplied + validated (supplied during state SSO in the current scenario)

10 (2 in decimal) - user supplied + non Validated (from profile update)

11 (3 in decimal) - user supplied + validated (we will not have this association type now as there is no way to validate an association)


## Problem statement
Currently user_organisation table is having the association with user and organisation. But the kind of association or whether it is validated or not, is not stored. 


## Solution
In release 3.7, as part of user-org refactoring, below change is proposed to update the association type in the user_organisation table.

Add associationtype column and make it a part of primary key. Store the current asociation types as org/state supplied and validated (1 in decimal),  user supplied and non-validated(2 in decimal). In future there can be 2 more association types. org supplied + non validated(0 in decimal) and user supplied + validated (3 in decimal).

As the state user also can edit the school from profile, there is going to be multiple org association for them. One will be state/org supplied and another will be updated by user from profile.

Table structure with new approach:


```
CREATE TABLE sunbird.user_organisation (
    userid text,
    organisationid text,
    associationtype int, //new field
    addedby text,
    addedbyname text,
    approvaldate text,
    approvedby text,
    hashtagid text,
    id text,
    isapproved boolean,
    isdeleted boolean,
    isrejected boolean,
    orgjoindate text,
    orgleftdate text,
    position text,
    roles list<text>,
    updatedby text,
    updateddate text,
    PRIMARY KEY (userid, organisationid, associationtype)
)
```


Impacted Areas:

APIs


1. /v1/user/update - associationtype to be updated.


1. /v3/user/read/ - associationtype to be read.


1. /v3/user/create - associationtype to be updated if user-org association is getting added.


1. /v1/user/signup - associationtype to be updated if user-org association is getting added


1. /v1/user/search - associationtype to be read.


1. /private/user/v1/lookup- associationtype to be read if user-org association is fetched



Analytics  - logic to pull associationtype in user cache updater


1. User Cache Updater





*****

[[category.storage-team]] 
[[category.confluence]] 

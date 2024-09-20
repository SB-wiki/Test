# User Choice Based Migration

###

PRD: [Doc](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/1060536533/On+boarding+for+states+that+only+have+data-2+Auto+match+with+ID+in+custodian+teacher+ID+validation)

### Ticket Ref: [**SC-1243**](https://project-sunbird.atlassian.net/browse/SC-1243)

### Objective:

* &#x20;  Migrate user from **CUSTODIAN** to **NON-CUSTODIAN** channel

In release 2.4.0, a nightly scheduled job runs to automatically migrate the user from custodian channel to non-custodian channel(admin channel). This is purely based on email, phone matching. There is no user involvement. In release 2.5.0, this automatic migration would cease and the following will happen.

* When email, phone matches, the user id is just marked eligible.
* If eligible, then a wizard will be shown in the portal to take in user external id and the ack to migrate.&#x20;
* The user is allowed 2 attempts to provide the external id, failing which the account migration attempt is abandoned.

### Schema and API Change summary

1. _shadow\_user_ table to have additional column 'attemptCount'.
2. A new API - GET /user/v1/feed/{userId} \*\* \*\* - for the portal to know about the details for migrations. Click \[\[here|User-Feed]] for info.
3. A new API - POST /api/user/v1/migrate - for migrating user.

### Resolved questions

1.  The messaging to provide in popup - who takes care to construct it?

    1. PM asks for 'treasury id' to be a configurable string. How best to achieve it?

    // UI will do these translations. The backend will only give the channel names.
2.  Nudging users - how to let portal know that there is a notification (workflow) pending for the logged-in user?

    // Ignore the problem for now, do a point solution asked for.
3.  The current requirement is to provide a transient notification. Contemporary apps do not keep a notification history or at least not expose this to users. If we start storing for whatever worth, the count of records can grow high - factor of users \* notifications.

    // The user feeds will be deleted after consumption (at least for now). So this is not a problem.

### Uploading Phase

* Admin will upload the CSV file and Scheduler Job will run which will mark all the user claimStatus as ELIGIBLE and,
* the feed will be given to the user when they will log in after becoming ELIGIBLE.
* Based on the Feed POP-UP will appear in which the user will have the flexibility to select the state and enter the user external id.

API Implementation

```
1:Need to introduce 1 new attribute attemptCount in shadow_user table.
2:Scheduler jobs will run and will expand the users in CSV to shadow user table, with default claim status, will be set to UNCLAIMED(0), only if provided orgExternalId is valid else will set the claim status to ORGEXTIDMISMATCH(5).
3:If an entry already found with provided extUserId and channel will update the record.
  - Will update and claim the user, with updating name and status only in the user table, and register user to user_org, And also sync the data with ES
  - Also if provided extOrgId is incorrect then all the relation of user with sub-org will be removed and the user will only be attached to rootOrg only.
4:Also, add attemptCount value to 2( configurable) in shadow_user table for each CSV user.
5:If entry is unique the user will get expanded in shadow_user table then will fetch all the unclaimed user and,
6:If the user found more than 1 then the claim status will be set to MULTIMATCH(4) also a list of userIds it's matching, with in the shadow table
7:If user ext org id is wrong then claimStatus will be set to ORGEXTIDMISMATCH and the user won't be able to migrate through API.
8:If the user found is equal to 1 then will update the user claimStatus to eligible. User can migrate through API
```

**NOTE** : If the user is status is inactive(provided by the admin) will still show a popup and after performing migration user will be blocked.

### Migration Phase

1.

```
GET /user/v1/feed/{userId} : This APIwill be invoked which will provide a list of user feeds, which will also have user migration details like the channel. 

     more info can be found [[here|User-Feed]]
```

1.

```
if user REJECT the migration then Api Invoke → POST /api/user/v1/migrate request body
```

The feedId is mandatory. There is no validation done on this. With an incorrect feedId, the user will encounter this migration popup action again, that we don't want. So please ensure you pass the correct feedId.

```java
 {"request": {
    	"userId":"d9928675-061e-46ca-b580-c851e35ac5a5",
        "action": "reject",
        "feedId":"{{feed_id}}" 
}}
```

and response body&#x20;

```java
{  HTTP CODE : 200
    "id": "api.user.migrate",
    "ver": "v1",
    "ts": "2019-11-18 18:33:01:296+0530",
    "params": {
        "resmsgid": null,
        "msgid": null,
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "SUCCESS": true,
        "userId": "d9928675-061e-46ca-b580-c851e35ac5a5"
    }
}
```

1.

```
if the user ACCEPT the migration then Api Invoke → POST /api/user/v1/migrate request body.  
```

```java
{
    "request": {
    	"userId":"{{user_id}}",
        "action": "accept",
        "userExtId":"bt240",
        "channel":"{{channel}}",
        "feedId":"{{feed_id}}" 
    }}
```

and response body

```
{  HTTP CODE : 200
    "id": "api.user.migrate",
    "ver": "v1",
    "ts": "2019-11-18 18:02:21:599+0530",
    "params": {
        "resmsgid": null,
        "msgid": null,
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "invalidUserExternalId",
    "result": {
        "maxAttempt": 2,
        "remainingAttempt": 2,
        "error": true,
        "message": "provided ext user id bt240 is incorrect"
    }
}
```

```java
{  HTTP CODE : 200
    "id": "api.user.migrate",
    "ver": "v1",
    "ts": "2019-11-18 18:02:28:841+0530",
    "params": {
        "resmsgid": null,
        "msgid": null,
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS",
        "errors": []
    }
}
```

```
{  HTTP CODE : 400
    "id": "api.user.migrate",
    "ver": "v1",
    "ts": "2019-11-18 18:01:13:308+0530",
    "params": {
        "resmsgid": null,
        "msgid": null,
        "err": "USER_MIGRATION_FAILED",
        "status": "USER_MIGRATION_FAILED",
        "errmsg": "user is failed to migrate"
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```

```
{  HTTP CODE : 400
    "id": "api.user.migrate",
    "ver": "v1",
    "ts": "2019-11-18 12:24:43:370+0530",
    "params": {
        "resmsgid": null,
        "msgid": "fb28c3ad-78a4-4543-8bb4-906c4876a54b",
        "err": "INVALID_PARAMETER_VALUE",
        "status": "INVALID_PARAMETER_VALUE",
        "errmsg": "Invalid value {{userId}} for parameter userId. Please provide a valid value."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```

\*\*FAQ \*\* Q 1 When Duplicate Email/phone Found in shadow\_user table?

| S.no | channel | email                                 | input status | name  | ext user id    | userId |
| ---- | ------- | ------------------------------------- | ------------ | ----- | -------------- | ------ |
| 1    | TN      | abc@gmail.com                         | active       | name1 | ext\_user\_id1 | abc    |
| 2    | TN      | [abc@gmail.com](mailto:abc@gmail.com) | active       | name2 | ext\_user\_id2 | abc    |

Ans: Both user will be **ELIGIBLE** to migrate but only 1 row will be VALIDATED whose ext user-id matched with the provided one. The Remaining will be set to REJECTED status.

Q 2 When the same Email/Phone provided in two different CSV with the different-2 channels?

| S.no | channel | email                                 | input status | name  | ext user id    | userId |
| ---- | ------- | ------------------------------------- | ------------ | ----- | -------------- | ------ |
| 1    | TN      | [abc@gmail.com](mailto:abc@gmail.com) | active       | name1 | ext\_user\_id1 | abc    |
| 2    | RJ      | [abc@gmail.com](mailto:abc@gmail.com) | active       | name2 | ext\_user\_id2 | abc    |

Ans: Both user claimStatus will be updated to MULTIMATCH, will not show pop-up action. The state admin will get a report that these users are not getting migrated and so can doubt the sanctity of the data. The user need not drive that fact.

Q 3 When the email belongs to the same user(correct) and the phone is provided of some other user?

| S.no | channel | email                                 | **phone**  | ext user id    | input status | userIds       | claimStatus |
| ---- | ------- | ------------------------------------- | ---------- | -------------- | ------------ | ------------- | ----------- |
| 1    | TN      |                                       | 9876543210 | ext\_user\_id1 | active       | abc           | ELIGIBLE    |
| 2    | TN      | [abc@gmail.com](mailto:abc@gmail.com) | 9876543210 | ext\_user\_id2 | active       | \[\[\[abc,def | abc,def]]]  |

Ans: 1st user will be eligible to migrate, and 2nd user will have claimStatus to MULTIMATCH so 2nd user won't get the popup for migrating. so admin needs to provide the correct details of 2nd user again in CSV then after the scheduler job run, he/she will be able to migrate.

Q 4 what will happen when the same email is used more than 1 channel?

| S.NO | channel | email                                 | name  | ext user id    | input status | userid | ext org id    | claimStatus |
| ---- | ------- | ------------------------------------- | ----- | -------------- | ------------ | ------ | ------------- | ----------- |
| 1    | TN      | [abc@gmail.com](mailto:abc@gmail.com) | name1 | ext\_user\_id1 | active       | abc    | ext\_org\_id1 | ELIGIBLE    |
| 2    | AP      | abc@gmail.com                         | name1 | ext\_user\_id2 | active       | abc    | ext\_org\_id2 | ELIGIBLE    |

Ans: SAME AS Q2

Q5: What if the user is inactive inshadow\_user table, so if the user performs migration then will he/she be blocked?

| channel | name  | input status | ext org id | ext user id    | userId | status | claimStatus |
| ------- | ----- | ------------ | ---------- | -------------- | ------ | ------ | ----------- |
| TN      | name1 | inactive     |            | ext\_user\_id1 | abc    | 0      | ELIGIBLE    |

Ans YES user will be  blocked, after he/she gets migrated

Q6: What if the incorrect ext org id is provided so, in this case, are we expecting user should be ELIGIBLE or USER shouldn't be ELIGIBLE?

Ans: if provided ext org id is incorrect then the user claimStatus will be marked as EXTORGIDMISMATCH, i.e user is not at all ELIGIBLE to migrate user can only be migrated if admin provides correct details of the user in CSV and upload it again.

Q7: What if the user is validated and admin provided the incorrect **ext org id** for the user again in another CSV? so do this requires a change in the claimStatus to ORGEXTIDMISMATCH from VALIDATED?

Ans: NO once the user is VALIDATED(CLAIMED) there is no going back. if provided EXTORGID is incorrect after the user is  VALIDATED then the user claimStatus still be VALIDATED, but he will only be connected to root org.

Q8: What if provided userExtId in CSV already exists for another state user within the same channel?

Ans: Since we are not validating userExtId, so if CSV user migrates with the userExtId of other existing user then existing user accounts will be owned by the CSV user.&#x20;

Ref \[\[User Feed (Draft)|User-Feed]]

&#x20;       &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

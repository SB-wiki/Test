# User-and-Groups-in-Schooling@Home

* [Intent](user-and-groups-in-schooling-home.md#intent)
* [Definitions](user-and-groups-in-schooling-home.md#definitions)
* [About](user-and-groups-in-schooling-home.md#about)
* [Users](user-and-groups-in-schooling-home.md#users)
  * [Managed user](user-and-groups-in-schooling-home.md#managed-user)
  * [New functionalities enabled](user-and-groups-in-schooling-home.md#new-functionalities-enabled)
  * [Database changes](user-and-groups-in-schooling-home.md#database-changes)
  * [APIs](user-and-groups-in-schooling-home.md#apis)
  * [Telemetry](user-and-groups-in-schooling-home.md#telemetry)
* [Groups](user-and-groups-in-schooling-home.md#groups)
  * [What is a group?](user-and-groups-in-schooling-home.md#what-is-a-group?)
  * [Activity](user-and-groups-in-schooling-home.md#activity)
  * [Plugin](user-and-groups-in-schooling-home.md#plugin)
  * [Database](user-and-groups-in-schooling-home.md#database)
  * [API](user-and-groups-in-schooling-home.md#api)
  * [Suspend and Delete Group](user-and-groups-in-schooling-home.md#suspend-and-delete-group)
  * [Group Guidelines Acceptance (terms and conditions)](user-and-groups-in-schooling-home.md#group-guidelines-acceptance-\(terms-and-conditions\))
  * [Telemetry](user-and-groups-in-schooling-home.md#telemetry)
* [Group API Error Codes](user-and-groups-in-schooling-home.md#group-api-error-codes)
* [Group Notifications:](user-and-groups-in-schooling-home.md#group-notifications:)
* [Release level snapshot](user-and-groups-in-schooling-home.md#release-level-snapshot)
* [Authentication](user-and-groups-in-schooling-home.md#authentication)
* [FAQs / Open questions](user-and-groups-in-schooling-home.md#faqs-/-open-questions)
* [References](user-and-groups-in-schooling-home.md#references)
*
  * [June 4, 2020](user-and-groups-in-schooling-home.md#june-4,-2020)
  * [May 11, 2020](user-and-groups-in-schooling-home.md#may-11,-2020)
  * [May 4, 2020](user-and-groups-in-schooling-home.md#may-4,-2020-)
  * [Apr 29, 2020](user-and-groups-in-schooling-home.md#apr-29,-2020)

### Intent

The following are some use-cases imagine and their possibilities listed out.

1. A single device could be used by multiple children at home or at a tuition centre.
2. Any user can create groups, which is a set of users picked up using the user ids (friendly name auto-generated).
3. Tuition Class scenarios
   1. In the tuition teacher device, it must be possible to simply add a user.
   2. The user id must always exist, i.e., pre-created.
   3. When the user starts consuming courses, the consumption is credited against that particular user.

### Definitions

**Activity** - a specific interest associated with the group. Example: Content, Discussion, Announcement.

**Admin** - a user privilege, if given can modify the group. Example: admin can add/change/remove an activity, add/change/remove a member.

**Group** - a collection of users and activities. Example: class10A, classVEnglish are groups

**Managed user** - a user account that exists with lighter or no credentials such as PIN. This user doesn’t have an email/phone associated. Example: a child user created under a guardian/parent.

**Logged-in user** - a user account that exists with stronger credentials and possess an email/phone identifier.

**Plugin** - a runtime instance that realises an activity. Example: content.report is a plugin that achieves reporting functionality.

**Plugins registry** - Contains an abstract master list of plugins - name, version, author, anyOtherData.

### About

This document can be read as having two distinct parts - Users and groups. Users were released in 3.1 first and groups are intended to go out in 3.2 first.

### Users

A user is ‘uniquely’ identified by the following attributes

* **UUID** - for telemetry and internal APIs. _Example: 9e7238ae-c308-4bea-8bbe-faf77b8118ae_
* **email/phone** - for logging in. _Example:_ [_my.email@domain.com_ ](mailto:my.email@domain.com)_or 0123456789_
* **userid** - system auto-generated, but currently un-used for logging in. A combination of name and random digits. _Example: myname2345_

Of this, userid is an equivalent of KeyCloak username and is inevitable. The introduction of email/phone surpassed its need and therefore we started using email/phone as our primary authentication attributes. Without email/phone, we cannot ‘notify’ the user, say about OTP, certificates deposited.

We must understand the role of a user and the ‘session’ identified by a JWT (json web token) in our current scheme of things.

Course enrolments, progress, assessments must be identified with a user. The JWT helps in ‘authenticating’ these updates against the ‘particular’ user. The JWT is also used as an ‘authorised’ key to access some internal services, like APIs - to generate OTP, to search users etc. In these API operations, the JWT is used only as an ‘authorised’ key and its association with a ‘particular’ user is irrelevant.

#### Managed user

![](<../../../../User/Fullexport2/images/storage/UserProfiles@HomeSchooling-Copy of v2.png>)

1. A managed user is conceptually same as user, except that there is no email or phone identifier.
2. A managed user can have certain new attributes like managedBy, PIN.
3. A managed user doesn't inherit attribute values from the parent account automatically. Location, for example, is defaulted to as the managedBy, but they are asked to confirm.

Experience ![](<../../../../User/Fullexport2/images/storage/UserProfiles@HomeSchooling-JWT creation.png>)

#### New functionalities enabled

Switching users A user can seamlessly switch to another user, only if the target user doesn’t have a password or accessCode (PIN) set.

Offline course consumption **Portal** - Offline desktop is a separate product and can potentially afford to save different uuids of users and their attributions locally.

**Mobile** - When multiple users use the same ‘offline’ device, there is a need to save all of their updates locally - until a chance to sync happens.

When consumption teams sync, they need to fetch tokens for the corresponding users and then sync it up. TBD - a little more understanding of how the sync happens today is required.

Tokens for managed usersTBD - Write this better - Portal and Mobile will have to rethink on the following areas:

* Telemetry
* JWT session handling

Content-service, KP, DP teams have to have cognisance of the following:

* Reliance on JWT to check user’s permission to

#### Database changes

UserCassandra

* Add text _managedBy_ withsecondary indexing ON
* Add text _accessCode_ - this is PIN and is added for future

ElasticSearch

* managedBy attribute is added
* accessCode is NOT added

#### APIs

There is no significant changes to API request/response structures and therefore not presented here.

**CREATE -** /v4/user/create

* Support new attribute _managedBy,_ of type uuid _._
* _managedBy_ validation, if passed is only a UUID, not any string.
* whenever _managedBy_ is non-null, org must be defaulted to custodian only (no other org allowed).

**UPDATE -** /v1/user/update

* if an email or phone is added to a user that has a non-null ‘managedBy’, do the following. We shall consider these no more as managed users.
  * generate a reset password link
  * Set managedBy = null
* ‘managedBy’ is disallowed to be updated/modified ever from the API

#### Telemetry

User addition telemetry goes as previous for any other user - No new flag/tags passed.

### Groups

![](../../../../User/Fullexport2/images/storage/UserProfiles@HomeSchooling-Groups.png)

#### What is a group?

1. A group is a collection of users and managed users. It refers to a uuid of those and therefore doesn’t care about the type.
2. Any type of user could create groups and any number of groups can be created.
3. Groups can be associated with activities.

#### Activity

Activity is a specific interest associated with the group. Example: Content, Discussion, Announcement. Each activity is identified by id within the group. Activity could have data of two kinds - cached and runtimeData.

1. cached data will be available to the consumption, along with group activities list.
2. runtime data will be given a data placeholder (Activity\_Data/Plugin\_Data - separate APIs to be provided).&#x20;

#### Plugin

Activity require support from an ‘instance’ to realise itself and we call that as a plugin. Activity supplies data about what type of plugin is needed and provide an abstraction between the group and the plugin. The plugin controls all the logic.

#### Database

ER diagram![](<../../../../User/Fullexport2/images/storage/UserProfiles@HomeSchooling-ER diagram.png>)

Group - Cassandra

```js
CREATE TABLE sunbird_groups.group (
    id text PRIMARY KEY,
    activities list<frozen<map<text, text>>>,
    createdby text,
    createdon timestamp,
    description text,
    membershiptype text,
    name text,
    status text,
    updatedby text,
    updatedon timestamp
);

CREATE INDEX idx_group_status ON sunbird_groups.group (status);
```

Groups can be deleted only by the creator, not by the admin.

TBD:- TODO: aggregations

Redis Cache There is a separation proposed to independently scale members and activities. We could expect activities to be having content metadata (size=big) and other metadata (size=small). The member data is relatively a list of alike fields and therefore will directly be related to the count of members.

| **Identifier**   | **Data refresh when?**                                | **TTL** | **Comments**                                                                                                                                                                                                                                                                                                                                      |
| ---------------- | ----------------------------------------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| groupId          | Group name, description changes Add/Remove activities | 1d      | Group name, description and activities. Likely less changing, but often in the initial days. Activity data within a group - like leaf nodes etc - would it get updated within the TTL? - this was discussed with DC and found to be okay to live with. When group information gets updated or activity is added/removed, this cache gets deleted. |
| groupId\_members | Members added/role changes/removed                    | 1d      | Members of this specific group. Likely less or no changing once group is formed. Members might get added only infrequently. But when a member gets added/updated/removed from group this cache gets deleted. The member name changes within 1d is less likely to reflect. This TTL can be tweaked as its an env var.                              |
| userId           | When the user reads his groups                        | 1h      | Groups the user belongs. This is populated only after a read of this user by calling /group/v1/list. When a member gets added/updated/removed from group this cache gets deleted, along with groupId\_members.The activity info changes within 1h is less likely to reflect. This TTL can be tweaked as its an env var.                           |

Group\_MemberCassandra

```js
CREATE TABLE sunbird_groups.group_member (
    groupid text,
    userid text,
    createdby text,
    createdon timestamp,
    removedby text,
    removedon timestamp,
    role text,
    status text,
    updatedby text,
    updatedon timestamp,
    visited boolean,
    PRIMARY KEY (groupid, userid)
);
CREATE INDEX idx_group_member_status ON sunbird_groups.group_member (status);
```

USER\_GROUPcassandra

```
CREATE TABLE sunbird_groups.user_group (
    userid text PRIMARY KEY,
    groupid set<text>
);
```

Plugin RegistryCassandra

```js
{
    "id": plugin_instance_id, // PARTITION key
    "ver": "1.0",
    "isActive": boolean,
    "shortId": "org.ekstep.launcher",
    "author": "string", // Default to "Sunbird"
    "description": "",
    "publishedDate": "",
    "data": { 
    } 
}
PRIMARY_KEY(id, author, isActive)
```

#### API

GroupsCRUDS api’s need to be developed

All read, update, delete will require the group identifier.

Search can take up members.

Sample Read Group API response with members and activities

```
{
    "id": "api.group.read",
    "ver": "v1",
    "ts": "2020-07-14 16:40:55:077+0000",
    "params": null,
    "result": {
        "membershipType": "invite_only",
        "updatedBy": "33141e91-bf0e-4242-83db-ec3c6ff34367",
        "createdBy": "33141e91-bf0e-4242-83db-ec3c6ff34367",
        "activities": [],
        "members": [
            {
                "userId": "33141e91-bf0e-4242-83db-ec3c6ff34367",
                "groupId": "b4d28662-7a0d-447d-9620-cd880c37df4c",
                "role": "admin",
                "status": "active",
                "createdOn": "2020-07-14 12:18:05:650+0000",
                "createdBy": "33141e91-bf0e-4242-83db-ec3c6ff34367",
                "updatedOn": null,
                "updatedBy": null,
                "removedOn": null,
                "removedBy": null,
                "name": "Name of User"
            }
        ],
        "activities": [
            {
                "id": "do_2130654356933754881407",
                "type": "Course",
                "activityInfo": {
                    "subject": [
                        "Science"
                    ],
                    "channel": "0124784842112040965",
                    "downloadUrl": "https://ntpstagingall.blob.core.windows.net/ntp-content-staging/ecar_files/do_2130654356933754881407/report-course_1594902148469_do_2130654356933754881407_1.0_spine.ecar",
                    "organisation": [
                        "Odisha"
                    ],
                    "language": [
                        "English"
                    ],
                    "mimeType": "application/vnd.ekstep.content-collection",
                    "variants": {
                        "online": {
                            "ecarUrl": "https://ntpstagingall.blob.core.windows.net/ntp-content-staging/ecar_files/do_2130654356933754881407/report-course_1594902148617_do_2130654356933754881407_1.0_online.ecar",
                            "size": 10020.0
                        },
                        "spine": {
                            "ecarUrl": "https://ntpstagingall.blob.core.windows.net/ntp-content-staging/ecar_files/do_2130654356933754881407/report-course_1594902148469_do_2130654356933754881407_1.0_spine.ecar",
                            "size": 168870.0
                        }
                    },
                    "medium": [
                        "Hindi"
                    ],
                    "leafNodes": [
                        "do_2130640217720832001141",
                        "do_21303481786022297611129",
                        "do_2130652418787000321420",
                        "do_213063267561111552186"
                    ],
                    "objectType": "Content",
                    "batches": [
                        {
                            "createdFor": [
                                "0124784842112040965"
                            ],
                            "endDate": "2020-08-09",
                            "name": "Test group",
                            "batchId": "0130654458430996488",
                            "enrollmentType": "open",
                            "enrollmentEndDate": "2020-08-01",
                            "startDate": "2020-07-16",
                            "status": 1
                        }
                    ],
                    "gradeLevel": [
                        "Class 9"
                    ],
                    "appIcon": "https://ntpstagingall.blob.core.windows.net/ntp-content-staging/content/do_2130654356933754881407/artifact/1920_1080_1569831930335.thumb.jpeg",
                    "lastUpdatedOn": "2020-07-16T12:22:28.047+0000",
                    "contentType": "Course",
                    "identifier": "do_2130654356933754881407",
                    "pkgVersion": 1.0,
                    "framework": "rj_k-12_2",
                    "size": 168870.0,
                    "createdBy": "ca828836-ebec-4c7a-a6e7-393692ac0549",
                    "leafNodesCount": 4,
                    "name": "Report course",
                    "board": "State (Rajasthan)",
                    "status": "Live",
                    "resourceType": "Course"
                }
            }
        ],
        "name": "TestGroup1",
        "description": "Test group description1",
        "updatedOn": "2020-07-14 12:19:22:998+0000",
        "id": "b4d28662-7a0d-447d-9620-cd880c37df4c",
        "createdOn": "2020-07-14 12:18:05:642+0000",
        "status": "active"
    },
    "responseCode": 200
}
```

#### Suspend and Delete Group

The group can be suspended by admin which make the groups in the suspended state where the only operation is allowed is to be reactivated by admin. All other operations such as adding of member, adding activity or any type of update is disallowed.

The group can be suspended ,reactivate and can be deleted through update group api call.

Suspend the Group

```
curl --location --request PATCH 'http://localhost:9000/v1/group/update' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
   "request":{
         "groupId": "5a53683e-c012-422a-85b6-f0e170aca412",
         "status":"suspended"
   }
    
}'
```

```
{
   "request":{
        "groupId":"5a53683e-c012-422a-85b6-f0e170aca412",
        "status":"suspended"
   }
    
}
```

Reactivate Group

```
curl --location --request PATCH 'http://localhost:9000/v1/group/update' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
   "request":{
         "groupId": "5a53683e-c012-422a-85b6-f0e170aca412",
         "status":"active"
   }
    
}'
```

```json
{
   "request":{
        "groupId":"5a53683e-c012-422a-85b6-f0e170aca412",
        "status":"active"
   }
    
}
```

Delete Group

```
curl --location --request POST 'http://localhost:9000/v1/group/delete' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
   "request":{
         "groupId": "ebd793f7-4c75-4fa4-9ec1-9608d1c72ac2"
      
   }
    
}'
```

#### Group Guidelines Acceptance (terms and conditions)

As a part of release-3.4.0 , user have to accept the terms and condition before accessing the group.This will also be applicable to the groups created before the release-3.4.0 deployment.

Following are the scenario to be handle with the release of **terms and conditions** in the groups.

* Old groups created before 3.4.0 release.
* New groups created after 3.4.0 release and **my groups** are never visited once .
* New groups created after 3.4.0 release and user already visited **my groups** .
* If a user is not a part of any group before 3.4.0 release and then a new group created.

WorkflowThis is the following steps needs to be taken care to handle all cases.

“tncType” :”groupsTnc” ..

1. Set groupsTnc system setting.

Set groupstnc version

```
curl --location --request POST 'https://dev.sunbirded.org/api/data/v1/system/settings/set' \
--header 'x-authenticated-user-token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJsclI0MWpJNndlZmZoQldnaUpHSjJhNlowWDFHaE53a21IU3pzdzE0R0MwIn0.eyJqdGkiOiI1ZjJjZDZkZC05MjcyLTQ1ZWYtOGU2Ni02ODVkMzBiYTMzMzEiLCJleHAiOjE2MDI5MTE3NjAsIm5iZiI6MCwiaWF0IjoxNjAyODI1MzYwLCJpc3MiOiJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJhdWQiOiJwcm9qZWN0LXN1bmJpcmQtZGV2LWNsaWVudCIsInN1YiI6ImY6NWE4YTNmMmItMzQwOS00MmUwLTkwMDEtZjkxM2JjMGZkZTMxOjk1ZTQ5NDJkLWNiZTgtNDc3ZC1hZWJkLWFkOGU2ZGU0YmZjOCIsInR5cCI6IkJlYXJlciIsImF6cCI6InByb2plY3Qtc3VuYmlyZC1kZXYtY2xpZW50IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiY2FiMjdmYTMtYTVmOC00MDE3LWEzMGMtZTZkZTgyYjUyODgwIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sIm5hbWUiOiJSZXZpZXdlciBVc2VyIiwicHJlZmVycmVkX3VzZXJuYW1lIjoibnRwdGVzdDEwMyIsImdpdmVuX25hbWUiOiJSZXZpZXdlciIsImZhbWlseV9uYW1lIjoiVXNlciIsImVtYWlsIjoidXMqKioqQHlvcG1haWwuY29tIn0.f7injCMpysb8fjNAHeQ3LzXe-0_Rw0tecbmde38MKg5pa5ZfhH6JVIkuEEx_o-D_znseMZKQXYI6UkPrOod9noR4Hva5pFD7DGPbOfUUIeNs6mymOd5m-OyUJizYb2kulJdevpPqU6vT612cViuk_Nc8XENJimzDzxskmsruVB70iscF7rkneBpPcVRinOQeZrqDVgXxFR2xJkzD7S7RnFRpafxAf3xDuDhAtTlRUFzXDaSHteIbdlPibGj1BowHFb4CMILaq-IB3pYbQ5AeW64bU5z7WdDEjGY479NNQHPqcPSwOr49mMrWI27cLnbUZymIn8zbPVzs6UWYKBkkcg' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8' \
--data-raw '{
  "request": {
    "id": "groupsTnc",
    "field": "groupsTnc",
    "value": "{\"latestVersion\":\"3.4.0\",\"3.4.0\":{\"url\":\"https://dev-sunbird-temp.azureedge.net/portal/terms-and-conditions-v1.html\"},\"3.5.0\":{\"url\":\"https://preprodall.blob.core.windows.net/termsandcond/terms-and-conditions-v2.html\"},\"3.5.0\":{\"url\":\"https://preprodall.blob.core.windows.net/termsandcond/terms-and-conditions-v4.html\"}}"
  }
}'
```

2.The client will call systems setting api to get the groups correct version which is currently deployed in the system

System setting Api to get the Group Version

```
curl --location --request GET 'https://dev.sunbirded.org/api/data/v1/system/settings/list' \
--header 'x-authenticated-user-token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJiTmtDZkdqcVIxeEIyZ184Y29Nekh6czdjSVpPQmpDcVdwb3QtbVB6RkJzIn0.eyJqdGkiOiJjZDNmNGUzYi1mYzRjLTQxZDctYjJhMC04YTUwNDA5Y2UwNjQiLCJleHAiOjE1OTQ3MDg4ODUsIm5iZiI6MCwiaWF0IjoxNTk0NzA4Mjg1LCJpc3MiOiJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiZjo1YThhM2YyYi0zNDA5LTQyZTAtOTAwMS1mOTEzYmMwZmRlMzE6ZWM4NjEwMjQtYzU1Zi00Y2EwLTgwZmEtMTdlMTU3NTcxOGQ5IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYWRtaW4tY2xpIiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiNzkwYzhmOWYtY2JmOC00YTA0LTk5MzQtMDYxZDEzNTY2NWE5IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2Rldi5jZW50cmFsaW5kaWEuY2xvdWRhcHAuYXp1cmUuY29tLyIsImh0dHA6Ly9kZXYuY2VudHJhbGluZGlhLmNsb3VkYXBwLmF6dXJlLmNvbS8iXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6ImVtYWlsIHByb2ZpbGUiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJjaGVja2RldnVzZXIxMDMgY2hlY2tkZXZ1c2VyMTAzIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiY2hlY2tkZXZ1c2VyMTAzIiwiZ2l2ZW5fbmFtZSI6ImNoZWNrZGV2dXNlcjEwMyIsImZhbWlseV9uYW1lIjoiY2hlY2tkZXZ1c2VyMTAzIiwiZW1haWwiOiJyZSoqKioqKioqKkB0YXJlbnRvLmNvbSJ9.vaiNRsvVhT8h5C1a0x9KI7WoUSFFncRGxXHLv5N2EeMSBiSjhvFiUIYkRxB_DljarjCQsbIsQXesmHBCSZlLO7eIvTsY1Rt2aZylr0vlvEQQefDM3G93R2UK5Hd9w4yLXBNm8UE40-pQu4VqbWqMEoTwV0C_HzSNzJjYlY0wRGwG0sr5joRlz8a1ecQpHFlG9bBH7X-X4JGGAKvSfCX1UCGdzZ5yVue0_cnEI9CO0KT2779BZm7ZVDmMar3Trjb1D4hlkY96Qe6lqTWYDdmRVsF6tD4LCZqxZsixaxofAr-3PYV1nnL5c9hSALHCqc308k_jMUYYBGEvEtbscRvxDQ' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8'
```

```json
{
    "id": "api.system.settings.list",
    "ver": "v1",
    "ts": "2020-10-12 18:19:29:583+0530",
    "params": {
        "resmsgid": null,
        "msgid": "65f14271-e811-46d6-a0f3-245b47b88ba9",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": [
           
            {
                "id": "custodianOrgId",
                "field": "custodianOrgId",
                "value": "0130144425679585281"
            },
            {
                "id": "emailUnique",
                "field": "emailUnique",
                "value": "true"
            },
            {
                "id": "groupsTnc",                   //Groups config
                "field": "groupsTnc",
                "value": "{\"latestVersion\":\"3.5.0\",\"3.4.0\":{\"url\":\"https://dev-sunbird-temp.azureedge.net/portal/terms-and-conditions-v1.html\"},\"3.5.0\":{\"url\":\"https://preprodall.blob.core.windows.net/termsandcond/terms-and-conditions-v2.html\"},\"3.5.0\":{\"url\":\"https://preprodall.blob.core.windows.net/termsandcond/terms-and-conditions-v4.html\"}}"
            },
            {
                "id": "tncConfig",
                "field": "tncConfig",
                "value": "{\"latestVersion\":\"v1\",\"v1\":{\"url\":\"https://dev-sunbird-temp.azureedge.net/portal/terms-and-conditions-v1.html\"},\"v2\":{\"url\":\"https://preprodall.blob.core.windows.net/termsandcond/terms-and-conditions-v2.html\"},\"v4\":{\"url\":\"https://preprodall.blob.core.windows.net/termsandcond/terms-and-conditions-v4.html\"}}"
            }
        ]
    }
}
```

3. Client will do a user read call to get the current groups tnc version accepted by user.

User Read to get the groups tnc version accepted.

```
curl --location --request GET 'localhost:9000/v1/user/read/1582f01c-4305-472d-8b68-6c444e741349' \
--header 'Accept:  application/json'
```

```json
{
    "id": "api.user.read",
    "ver": "v1",
    "ts": "2020-10-12 12:56:49:059+0530",
    "params": {
        "resmsgid": null,
        "msgid": "5b16b040-6c0a-46fb-9597-ac60c765687b",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "webPages": [],
            "tcStatus": null,
            "maskedPhone": "******9789",
            "rootOrgName": "localrootorg",
            "subject": [],
            "channel": "channel1004",
            "language": [],
            "updatedDate": null,
            "managedBy": null,
            "flagsValue": 5,
            "id": "1582f01c-4305-472d-8b68-6c444e741349",
            "recoveryEmail": "",
            "identifier": "1582f01c-4305-472d-8b68-6c444e741349",
            "thumbnail": null,
            "updatedBy": null,
            "accesscode": null,
            "locationIds": [],
            "registryId": null,
            "rootOrgId": "0130144425679585281",
            "prevUsedEmail": "",
            "firstName": "पअउस्ट्मन्",
            "tncAcceptedOn": "2020-10-09T08:40:16.066Z",
            "allTncAccepted": {                                                                         //tncType: groups
                "groupsTnc": {
                    "tncAcceptedOn": "2020-10-12 12:56:40:563+0530",
                    "version": "3.5.0"
                }
            },
           ..........
        }
    }
}
```

4. Client will generate popup when user groups tnc and system setting tnc version doesn’t match . This could be possible only when groups **tnc** version changed or for the first time deployment of release-3.4.0 for existing old groups. Once the user accept the guidelines, client will generate the telemetry for user acceptance of all existing old groups at once. Client also needs to update the groups tnc field in the learner service through the below api call.

Request to update Group TNC

```json
curl --location --request POST 'localhost:9000/v1/user/tnc/accept' \
--header 'Connection: keep-alive' \
--header 'Pragma: no-cache' \
--header 'Cache-Control: no-cache' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'Origin: https://diksha.gov.in' \
--data-raw '{
    "request":{
        "tncType":"groupsTnc"
        "version":"3.5.0"
                
        }
}'
```

5. To get the newly created group, a group list will contain visited flag as True or False to represent whether user has already visited the group (new group). Based on this newly created flag client should be able to generated pop up for tnc guideliness if visited is false.

List group based on userId

```
curl --location --request POST 'localhost:9000/v1/group/list' \
--header 'Content-Type: application/json' \
--data-raw '{
    "request": {
        "filters": {
            "userId":"1234567"
        }
        
    }
}'
```

```json
{
    "id": "api.group.list",
    "ver": "v1",
    "ts": "2020-10-12 16:18:35:403+0530",
    "params": null,
    "result": {
        "group": [
            {
                "id": "07559e89-72d5-486c-89ee-aef3d2883dcc",
                "name": "ABC",
                "status": "active",
                "membershipType": "invite_only",
                "activities": [],
                "createdOn": "2020-10-12 16:17:32:691+0530",
                "createdBy": "1234567",
                "memberRole": "admin",
                "visited": true
            },
            {
                "id": "514cb94e-efe8-4a44-85e0-b9549d95cc26",
                "name": "FDA",
                "status": "active",
                "membershipType": "invite_only",
                "activities": [],
                "createdOn": "2020-10-07 17:39:06:711+0530",
                "createdBy": "123456",
                "memberRole": "member",
                "visited": false
            }
        ]
    },
    "responseCode": 200
}
```

6. Update visited for all the groups

update visited flag true for all list

```
curl --location --request PATCH 'https://dev.sunbirded.org/api/group/membership/v1/update' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8' \
--header 'x-authenticated-user-token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJsclI0MWpJNndlZmZoQldnaUpHSjJhNlowWDFHaE53a21IU3pzdzE0R0MwIn0.eyJqdGkiOiIwNjZjMTU2MS1jNjM1LTQ5MTUtYmQ3My0xODYzMTE0N2E0MjQiLCJleHAiOjE2MDM0NDg1MzIsIm5iZiI6MCwiaWF0IjoxNjAzMzYyMTMyLCJpc3MiOiJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJhdWQiOiJwcm9qZWN0LXN1bmJpcmQtZGV2LWNsaWVudCIsInN1YiI6ImY6NWE4YTNmMmItMzQwOS00MmUwLTkwMDEtZjkxM2JjMGZkZTMxOmFjNjM5MTY2LTcyN2ItNGUzNi05M2YzLTg3YjI0ODMzNmI1MiIsInR5cCI6IkJlYXJlciIsImF6cCI6InByb2plY3Qtc3VuYmlyZC1kZXYtY2xpZW50IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiZmQyZWY3ZjctOWU4Ny00ODcxLWE3NmMtNTU2OTYxMDc0MWYwIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sIm5hbWUiOiJwbG9hIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiZGRkZGRkZCIsImdpdmVuX25hbWUiOiJwbG9hIiwiZW1haWwiOiJhYmNkQGdkbWFkZGlsMS5jb20ifQ.G9CEqR12_wlaHSl_IrfwUveqGCgYdBwbzC0CUu9zf6R44nNTA8-QUmFJPeDdkBJfcbrxPwLTXd8rD9J5HYfCaZ-hRMNM1JsLgViYHVezZGf-7WH_qTgqk3zc8TS1ld7KAFpOTY_QkgT6RTTlaoIu_k2b69aOAF-HkZ6PmB0f9_apTgBa2ILSuNdZFrRZTMvCUC4kFf_jbIFTc2-M4-ja28nUenhyZ1M2EQgJWmOfPjXr3sxZjBLKAGyNOVnOsAKOExqmK1VeUgHIgQYECKtmB3OR9k4-piNHkasCQRJPHlttf1T1Z7t7BlDGaz7sb8EiA4KG-vq2VskFVapJ_PuwBA' \
--header 'Content-Type: application/json' \
--data-raw '{
    "request": {       
        "userId":"ac639166-727b-4e36-93f3-87b248336b52",
        "groups":[{
                  "groupId":"6f45ffec-ee76-484d-b092-a18e38a19e82",
                  "visited":false
        }]        
        
    }
}'
```

7. After accepting the tnc guidelines cilent should call update query to update the visited flag as true for the user

Update Visited Flag for a User

```
curl --location --request PATCH 'http://localhost:9000/v1/group/update' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
   "request":{
         "groupId": "514cb94e-efe8-4a44-85e0-b9549d95cc26",
         "members":{
               "edit":[{
                       "userId":"12345",
                       "visited":true
               }]
         }
   }
    
}'
```

#### Telemetry

For group service Audit event will be generated for Create and Update Group. Log event gets sent for all api access.

[https://docs.google.com/spreadsheets/d/1dZdLSe6NSo88bqQ8P3HymhWLIL49H1SPYnot\_9Zk5Sw/edit#gid=166016488](https://docs.google.com/spreadsheets/d/1dZdLSe6NSo88bqQ8P3HymhWLIL49H1SPYnot\_9Zk5Sw/edit#gid=166016488)

Audit Event Audit event generated whenever there is update to the group and update

Create Group Audit Event

```json
{
  "eid": "AUDIT",
  "ets": 1647842306408,
  "ver": "3.0",
  "mid": "32132323",
  "actor": {
    "id": "405acb37-df75-421b-85c6-e25249584506",
    "type": "User"
  },
  "context": {
    "channel": "2134341414",
    "pdata": {
      "id": "dev.sunbird.groups.service",
      "pid": "groups-service",
      "ver": "4.4.0"
    },
    "env": "groups",
    "cdata": [
      {
        "id": "405acb37-df75-421b-85c6-e25249584506",
        "type": "User"
      },
      {
        "id": "5dafb50e-626b-43f7-a51d-074873ca301d",
        "type": "Groupid"
      },
      {
        "id": "32132323",
        "type": "Request"
      }
    ],
    "rollup": {
      "l1": "2134341414"
    }
  },
  "edata": {
    "state": "active",
    "type": "group-created",
    "props": [
      "name",
      "description"
    ]
  }
}
```

Update Group Audit Event

```json
{
  "eid": "AUDIT",
  "ets": 1647842548402,
  "ver": "3.0",
  "mid": "32132323",
  "actor": {
    "id": "405acb37-df75-421b-85c6-e25249584506",
    "type": "User"
  },
  "context": {
    "channel": "2134341414",
    "pdata": {
      "id": "dev.sunbird.groups.service",
      "pid": "groups-service",
      "ver": "4.4.0"
    },
    "env": "groups",
    "cdata": [
      {
        "id": "405acb37-df75-421b-85c6-e25249584506",
        "type": "User"
      },
      {
        "id": "5dafb50e-626b-43f7-a51d-074873ca301d",
        "type": "Groupid"
      },
      {
        "id": "32132323",
        "type": "Request"
      }
    ],
    "rollup": {
      "l1": "2134341414"
    }
  },
  "edata": {
    "state": "active",
    "type": "update-group",
    "prevstate": "active",
    "props": [
      "groupId",
      "name"
    ]
  }
}
```

Add Member

```json
{
  "eid": "AUDIT",
  "ets": 1647842741310,
  "ver": "3.0",
  "mid": "32132323",
  "actor": {
    "id": "405acb37-df75-421b-85c6-e25249584506",
    "type": "User"
  },
  "context": {
    "channel": "2134341414",
    "pdata": {
      "id": "dev.sunbird.groups.service",
      "pid": "groups-service",
      "ver": "4.4.0"
    },
    "env": "groups",
    "cdata": [
      {
        "id": "405acb37-df75-421b-85c6-e25249584506",
        "type": "User"
      },
      {
        "id": "5dafb50e-626b-43f7-a51d-074873ca301d",
        "type": "Groupid"
      },
      {
        "id": "32132323",
        "type": "Request"
      }
    ],
    "rollup": {
      "l1": "2134341414"
    }
  },
  "edata": {
    "state": "active",
    "type": "add-member",
    "prevstate": "active",
    "props": [
      "groupId",
      "members.add"
    ]
  }
}
```

Edit Member

```
{
  "eid": "AUDIT",
  "ets": 1647842821363,
  "ver": "3.0",
  "mid": "32132323",
  "actor": {
    "id": "405acb37-df75-421b-85c6-e25249584506",
    "type": "User"
  },
  "context": {
    "channel": "2134341414",
    "pdata": {
      "id": "dev.sunbird.groups.service",
      "pid": "groups-service",
      "ver": "4.4.0"
    },
    "env": "groups",
    "cdata": [
      {
        "id": "405acb37-df75-421b-85c6-e25249584506",
        "type": "User"
      },
      {
        "id": "5dafb50e-626b-43f7-a51d-074873ca301d",
        "type": "Groupid"
      },
      {
        "id": "32132323",
        "type": "Request"
      }
    ],
    "rollup": {
      "l1": "2134341414"
    }
  },
  "edata": {
    "state": "active",
    "type": "add-member",
    "prevstate": "active",
    "props": [
      "groupId",
      "members.edit"
    ]
  }
}
```

Remove Member

```
{
  "eid": "AUDIT",
  "ets": 1647842898895,
  "ver": "3.0",
  "mid": "32132323",
  "actor": {
    "id": "405acb37-df75-421b-85c6-e25249584506",
    "type": "User"
  },
  "context": {
    "channel": "2134341414",
    "pdata": {
      "id": "dev.sunbird.groups.service",
      "pid": "groups-service",
      "ver": "4.4.0"
    },
    "env": "groups",
    "cdata": [
      {
        "id": "405acb37-df75-421b-85c6-e25249584506",
        "type": "User"
      },
      {
        "id": "5dafb50e-626b-43f7-a51d-074873ca301d",
        "type": "Groupid"
      },
      {
        "id": "32132323",
        "type": "Request"
      }
    ],
    "rollup": {
      "l1": "2134341414"
    }
  },
  "edata": {
    "state": "active",
    "type": "add-member",
    "prevstate": "active",
    "props": [
      "groupId",
      "members.remove"
    ]
  }
}
```

Add activity

```
{
	"eid": "AUDIT",
	"ets": 1595576782609,
	"ver": "3.0",
	"mid": "cf4b8288-c6d1-4dc2-9e15-696540c3748e",
	"actor": {
		"id": "userid1",
		"type": "User"
	},
	"context": {
		"channel": "0130144425679585281",
		"pdata": {
			"id": "dev.sunbird.groups.service",
			"pid": "groups-service",
			"ver": "3.1.0"
		},
		"env": "Group",
		"cdata": [{
			"id": "cf4b8288-c6d1-4dc2-9e15-696540c3748e",
			"type": "Request"
		}],
		"rollup": {}
	},
	"object": {
		"id": "90ef4349-b0bd-4d04-ad0c-5d351e102fd0",
		"type": "Group"
	},
	"edata": {
		"state": "Update",
		"props": ["groupId", "description", "activities.add"]
	}
}
```

Edit activity

```
{
	"eid": "AUDIT",
	"ets": 1595576831107,
	"ver": "3.0",
	"mid": "c5fc2085-475e-4b9e-a701-d892b99fe11c",
	"actor": {
		"id": "userid1",
		"type": "User"
	},
	"context": {
		"channel": "0130144425679585281",
		"pdata": {
			"id": "dev.sunbird.groups.service",
			"pid": "groups-service",
			"ver": "3.1.0"
		},
		"env": "Group",
		"cdata": [{
			"id": "c5fc2085-475e-4b9e-a701-d892b99fe11c",
			"type": "Request"
		}],
		"rollup": {}
	},
	"object": {
		"id": "90ef4349-b0bd-4d04-ad0c-5d351e102fd0",
		"type": "Group"
	},
	"edata": {
		"state": "Update",
		"props": ["groupId", "description", "activities.edit"]
	}
}
```

Remove Activity

```
{
	"eid": "AUDIT",
	"ets": 1595576599136,
	"ver": "3.0",
	"mid": "7bd2354f-df64-4706-bc6b-2e89fbfd20b1",
	"actor": {
		"id": "userid1",
		"type": "User"
	},
	"context": {
		"channel": "0130144425679585281",
		"pdata": {
			"id": "dev.sunbird.groups.service",
			"pid": "groups-service",
			"ver": "3.1.0"
		},
		"env": "Group",
		"cdata": [{
			"id": "7bd2354f-df64-4706-bc6b-2e89fbfd20b1",
			"type": "Request"
		}],
		"rollup": {}
	},
	"object": {
		"id": "90ef4349-b0bd-4d04-ad0c-5d351e102fd0",
		"type": "Group"
	},
	"edata": {
		"state": "Update",
		"props": ["groupId", "description", "members.remove"]
	}
}
```

Delete Group

```
{
	"eid": "AUDIT",
	"ets": 1595578510757,
	"ver": "3.0",
	"mid": "54452682-03e7-490e-89b6-676aacb593bd",
	"actor": {
		"id": "userid1",
		"type": "User"
	},
	"context": {
		"channel": "0130144425679585281",
		"pdata": {
			"id": "dev.sunbird.groups.service",
			"pid": "groups-service",
			"ver": "3.1.0"
		},
		"env": "Group",
		"cdata": [{
			"id": "54452682-03e7-490e-89b6-676aacb593bd",
			"type": "Request"
		}],
		"rollup": {}
	},
	"object": {
		"id": "90ef4349-b0bd-4d04-ad0c-5d351e102fd0",
		"type": "Group"
	},
	"edata": {
		"state": "Delete",
		"props": ["groupId", "status"]
	}
}
```

Suspend the Group

```
{
	"eid": "AUDIT",
	"ets": 1601889596372,
	"ver": "3.0",
	"mid": "208769bb-dd17-40ca-88a5-c0be900b1a5a",
	"actor": {
		"id": "clientId",
		"type": "User"
	},
	"context": {
		"channel": "0130144425679585281",
		"pdata": {
			"id": "dev.sunbird.groups.service",
			"pid": "groups-service",
			"ver": "3.4.0"
		},
		"env": "Group",
		"cdata": [{
			"id": "208769bb-dd17-40ca-88a5-c0be900b1a5a",
			"type": "Request"
		}],
		"rollup": {}
	},
	"object": {
		"id": "5a53683e-c012-422a-85b6-f0e170aca412",
		"type": "Group"
	},
	"edata": {
		"state": "Suspended",
		"prevstate": "Active",
		"props": ["groupId", "status"]
	}
}
```

Rectivate Group

```json
{
	"eid": "AUDIT",
	"ets": 1601889556611,
	"ver": "3.0",
	"mid": "32fe36a0-a2cc-41d6-8220-1f2d03e42b14",
	"actor": {
		"id": "clientId",
		"type": "User"
	},
	"context": {
		"channel": "0130144425679585281",
		"pdata": {
			"id": "dev.sunbird.groups.service",
			"pid": "groups-service",
			"ver": "3.4.0"
		},
		"env": "Group",
		"cdata": [{
			"id": "32fe36a0-a2cc-41d6-8220-1f2d03e42b14",
			"type": "Request"
		}],
		"rollup": {}
	},
	"object": {
		"id": "5a53683e-c012-422a-85b6-f0e170aca412",
		"type": "Group"
	},
	"edata": {
		"state": "Active",
		"prevstate": "Suspended",
		"props": ["groupId", "status"]
	}
}
```

Log EventLog event will generated to provide info for all the api access .

Create Group

```json
{
	"eid": "LOG",
	"ets": 1595286563383,
	"ver": "3.0",
	"mid": "22979b8a-512e-4d46-ae1b-c7c69efb4633",
	"actor": {
		"id": "userId",
		"type": "User"
	},
	"context": {
		"channel": "0130144425679585281",
		"pdata": {
			"id": "dev.sunbird.groups.service",
			"pid": "groups-service",
			"ver": "3.1.0"
		},
		"env": "Group",
		"cdata": [{
			"id": "22979b8a-512e-4d46-ae1b-c7c69efb4633",
			"type": "Request"
		}],
		"rollup": {}
	},
	"edata": {
		"level": "info",
		"type": "Api_access",
		"message": "",
		"params": [{
			"url": "/v1/group/create"
		}, {
			"method": "POST"
		}, {
			"status": 200
		}, {
			"duration": 598
		}]
	}
}
```

Update Group

```json
 {
 	"eid": "LOG",
 	"ets": 1595286746947,
 	"ver": "3.0",
 	"mid": "a9944a5f-b49d-4c2c-87c9-e281a78bfb03",
 	"actor": {
 		"id": "userId",
 		"type": "User"
 	},
 	"context": {
 		"channel": "0130144425679585281",
 		"pdata": {
 			"id": "dev.sunbird.groups.service",
 			"pid": "groups-service",
 			"ver": "3.1.0"
 		},
 		"env": "Group",
 		"cdata": [{
 			"id": "a9944a5f-b49d-4c2c-87c9-e281a78bfb03",
 			"type": "Request"
 		}],
 		"rollup": {}
 	},
 	"edata": {
 		"level": "info",
 		"type": "Api_access",
 		"message": "",
 		"params": [{
 			"url": "/v1/group/update"
 		}, {
 			"method": "PATCH"
 		}, {
 			"status": 200
 		}, {
 			"duration": 186
 		}]
 	}
 }
```

Read Group

```
 {
 	"eid": "LOG",
 	"ets": 1595579383241,
 	"ver": "3.0",
 	"mid": "63b4f49c-74c4-44a2-accd-9b2b83577763",
 	"actor": {
 		"id": "userid1",
 		"type": "User"
 	},
 	"context": {
 		"channel": "0130144425679585281",
 		"pdata": {
 			"id": "dev.sunbird.groups.service",
 			"pid": "groups-service",
 			"ver": "3.1.0"
 		},
 		"env": "Group",
 		"cdata": [{
 			"id": "63b4f49c-74c4-44a2-accd-9b2b83577763",
 			"type": "Request"
 		}],
 		"rollup": {}
 	},
 	"edata": {
 		"level": "info",
 		"type": "Api_access",
 		"message": "",
 		"params": [{
 			"url": "/v1/group/read/70de85d3-32d5-4526-8d74-f41e789f8897?fields=members,activities"
 		}, {
 			"method": "GET"
 		}, {
 			"status": 200
 		}, {
 			"duration": 467
 		}]
 	}
 }
```

Search Group

```
 {
 	"eid": "LOG",
 	"ets": 1595579446317,
 	"ver": "3.0",
 	"mid": "e2b90ec6-5405-480e-8e76-97e83890421e",
 	"actor": {
 		"id": "userid1",
 		"type": "User"
 	},
 	"context": {
 		"channel": "0130144425679585281",
 		"pdata": {
 			"id": "dev.sunbird.groups.service",
 			"pid": "groups-service",
 			"ver": "3.1.0"
 		},
 		"env": "Group",
 		"cdata": [{
 			"id": "e2b90ec6-5405-480e-8e76-97e83890421e",
 			"type": "Request"
 		}],
 		"rollup": {}
 	},
 	"edata": {
 		"level": "info",
 		"type": "Api_access",
 		"message": "",
 		"params": [{
 			"url": "/v1/group/list"
 		}, {
 			"method": "POST"
 		}, {
 			"status": 200
 		}, {
 			"duration": 400
 		}]
 	}
 }
```

### Group API Error Codes

Following are the error code are defined for the all the group operations.

[SB-23040 System JIRA](https://browse/SB-23040)

The error codes should contain service information, unique operation and the error number information to identify the issue.

| **API**                                                | **Unique Operation Name** | **Operation Name** | **Error Number** | **New** **Error Description (After Review)**                                                                                          | **Error Code**    | **API Error -(Backend Throws)**                                                                                                                                                        | **UI Error (Should be shown to user)** |
| ------------------------------------------------------ | ------------------------- | ------------------ | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| ALL(For any operation if token in expire or incorrect) | ALL                       | ALL                | NA               | You are an unauthorized.Contact your system administrator                                                                             | GS\_UNAUTHORIZED  | 401 - You are not Authorized ( token incorrect) .                                                                                                                                      |                                        |
| group/v1/create                                        | CRT                       | GS\_CRT            | 01               | Failed to create group, unauthorised user. Contact your system administrator.                                                         | GS\_CRT01         | 401 - You are not Authorized                                                                                                                                                           |                                        |
| group/v1/create                                        | CRT                       | GS\_CRT            | 02               | Failed to create group, fields are missing in the request. Enter the required values and resend the request.                          | GS\_CRT02         | 400 - Request data for this operation is invalid (request field is missing in request body) & MANDATORY PARAM IS MISSING                                                               |                                        |
| group/v1/create                                        | CRT                       | GS\_CRT            | 03               | Failed to create group, due to database error or there are too many concurrent calls to the server. Try again later.                  | GS\_CRT03         | 500 - Internal Server Error ( DB Operation Failed or any other error)                                                                                                                  |                                        |
| group/v1/create                                        | CRT                       | GS\_CRT            | 04               | Failed to create group, exceeded number of permissible groups.                                                                        | GS\_CRT04         | 400 - Exceeded the group max size limit                                                                                                                                                |                                        |
| group/v1/create                                        | CRT                       | GS\_CRT            | 05               | Failed to add member, group, exceeded number of permissible members.                                                                  | GS\_CRT05         | 400 - Exceeded the member max size limit                                                                                                                                               |                                        |
| group/v1/create                                        | CRT                       | GS\_CRT            | 06               | Failed to add activity in a group, exceeded the number of permissible activity in the group.                                          | GS\_CRT06         | 400 - Exceeded the activity max size limit                                                                                                                                             |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
| group/v1/update                                        | UDT                       | GS\_UDT            | 01               | Failed to update group, unauthorised user. Contact your system administrator.                                                         | GS\_UDT01         | 401- You are not Authorized                                                                                                                                                            |                                        |
| group/v1/update                                        | UDT                       | GS\_UDT            | 02               | Failed to update group, mandatory fields are missing in the request. Enter the required values and resend the request.                | GS\_UDT02         | 400 - Request data for this operation is invalid (request field is missing in request body) & 400 - MANDATORY PARAM IS MISSING (other mandatory param is missing in the request body)  |                                        |
| group/v1/update                                        | UDT                       | GS\_UDT            | 03               | Failed to update group, due to database error or there are too many concurrent calls to the server. Try again later.                  | GS\_UDT03         | 500 - Internal Server Error (DB Operation failed or any other error)                                                                                                                   |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
| group/v1/update                                        | UDT                       | GS\_UDT            | 05               | Failed to update the group, exceeded permissible members count.                                                                       | GS\_UDT05         | 400 - Exceeded the member max size limit                                                                                                                                               |                                        |
| group/v1/update                                        | UDT                       | GS\_UDT            | 06               | Failed to update group activity, exceeded permissible activities in a group.                                                          | GS\_UDT06         | 400 - Exceeded the activity max size limit                                                                                                                                             |                                        |
| group/v1/update                                        | UDT                       | GS\_UDT            | 07               | Failed to update, group does not exist. Contact your system administrator.                                                            | GS\_UDT07         | 400 - group not found                                                                                                                                                                  |                                        |
| group/v1/update                                        | UDT                       | GS\_UDT            | 08               | Failed to update, group inactive. Resend required values in request.                                                                  | GS\_UDT08         | 400 - group not active with the group id {0}                                                                                                                                           |                                        |
| group/v1/update                                        | UDT                       | GS\_UDT            | 09               | Failed to update group, administrator rights required. Contact your system administrator.                                             | GS\_UDT09         | 401 - You are not Authorized (For non admin operation)                                                                                                                                 |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
| group/v1/read                                          | RED                       | GS\_RED            | 01               | Failed to read group, unauthorised user. Contact your system administrator.                                                           | GS\_RED01         | 401 - You are not Authorized Unauthorized Operation                                                                                                                                    |                                        |
| group/v1/read                                          | RED                       | GS\_RED            | 02               | Failed to read group details, mandatory fields are missing in the request. Enter the required values and resend the request.          | GS\_RED02         | 400 - Request data for this operation is invalid (request field is missing in request body) or 400 - MANDATORY PARAM IS MISSING (other mandatory param is missing in the request body) |                                        |
| group/v1/read                                          | RED                       | GS\_RED            | 03               | Failed to read group details due to database error or there are too many concurrent calls to the server. Try again later.             | GS\_RED03         | 500 - Internal Server Error ( Group read db call failed)                                                                                                                               |                                        |
| group/v1/read                                          | RED                       | GS\_RED            | 07               | Failed to read details, group not found. Contact your system administrator.                                                           | GS\_RED07         | 400 - group does not exist with the group id {}                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
| group/v1/list                                          | LST                       | GS\_LST            | 01               | Failed to fetch group list, unauthorised user. Contact your system administrator.                                                     | GS\_LST01         | 401 - You are not Authorized                                                                                                                                                           |                                        |
| group/v1/list                                          | LST                       | GS\_LST            | 02               | Failed to fetch group list, mandatory fields are missing in the request. Enter the required values and resend the request.            | GS\_LST02         | 400 - Request data for this operation is invalid (request field is missing in request body) or400 - MANDATORY PARAM IS MISSING (other mandatory param is missing in the request body)  |                                        |
| group/v1/list                                          | LST                       | GS\_LST            | 03               | Failed to fetch group list, due to database error or there are too many concurrent calls to the server. Try again later.              | GS\_LST03         | 500 - Internal Server Error                                                                                                                                                            |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
| group/v1/delete                                        | DLT                       | GS\_DLT            | 01               | Failed to delete group, unauthorised user. Contact your system administrator.                                                         | GS\_DLT01         | 401 - You are not Authorized                                                                                                                                                           |                                        |
| group/v1/delete                                        | DLT                       | GS\_DLT            | 02               | Failed to delete group, mandatory fields are missing in the request. Enter the required values and resend the request.                | GS\_DLT02         | 400 - Request data for this operation is invalid (request field is missing in request body) or400 - MANDATORY PARAM IS MISSING (other mandatory param is missing in the request body)  |                                        |
| group/v1/delete                                        | DLT                       | GS\_DLT            | 03               | Failed to delete group, due to database error or there are too many concurrent calls to the server. Try again later.                  | GS\_DLT03         | 500 - Internal Server Error (if Delete group operation failed with exception)                                                                                                          |                                        |
| group/v1/delete                                        | DLT                       | GS\_DLT            | 07               | Failed to delete, group not found. Contact your system administrator.                                                                 | GS\_DLT07         | 400 - Group not Found                                                                                                                                                                  |                                        |
| group/v1/delete                                        | DLT                       | GS\_DLT            | 10               | Failed to delete, group creators can delete the group. Contact your system administrator.                                             | GS\_DLT10         | 401 - You are not Authorized (if non creator try to delete the group)                                                                                                                  |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
|                                                        |                           |                    |                  |                                                                                                                                       |                   |                                                                                                                                                                                        |                                        |
| group/v1/membership/update                             | MBRSHP\_UDT               | GS\_MBRSHP\_UDT    | 01               | Failed to update group member details, unauthorised user. Contact your system administrator.                                          | GS\_MBRSHP\_UDT01 | 401 - You are not Authorized                                                                                                                                                           |                                        |
| group/v1/membership/update                             | MBRSHP\_UDT               | GS\_MBRSHP\_UDT    | 02               | Failed to update group member details, mandatory fields are missing in the request. Enter the required values and resend the request. | GS\_MBRSHP\_UDT02 | 400 - Request data for this operation is invalid (request field is missing in request body) or 400 - MANDATORY PARAM IS MISSING (other mandatory param is missing in the request body) |                                        |
| group/v1/membership/update                             | MBRSHP\_UDT               | GS\_MBRSHP\_UDT    | 03               | Failed to create group, due to database error or there are too many concurrent calls to the server. Try again later.                  | GS\_MBRSHP\_UDT03 | 500 - Internal Server Error( if edit member table operation failed)                                                                                                                    |                                        |

### Group Notifications:

As of 3.9.0 release there were no provision of showing notification to the users when they are added to the groups or any other activities. From release 4.0.0, it is decided to provide a provision to notify the user when they login to their account about such events. It is planned to use the notification service will store to user notifications.

\[\[SB-24361 : Group Notification Design|SB-24361---Group-Notification-Design]]

```
```

### Release level snapshot

| **Release** | **What**                                                                                                                     |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------- |
| 3.0         | Ability to CRU managed users Ability to list managed users Ability to generate new type of identity tokens for managed users |
| 3.1         | Ability to CRU-S groups Ability to CRUD group members Ability to CRUD activities                                             |

### Authentication

| **Case id** | **x-authenticated-user-token** | **x-authenticated-for** | **user in request** | **Expectation** |
| ----------- | ------------------------------ | ----------------------- | ------------------- | --------------- |
| 1           | P1                             | null                    | P1                  | Pass            |
| 2           | P1                             | P1-C1                   | P1                  | Pass            |
| 3           | P1                             | P1-C1                   | C1                  | Pass            |
| 4           | P1                             | P1-C1                   | P2                  | 401             |
| 5           | P1                             | null                    | P2                  | Pass            |
| 6           | P1                             | null                    | C2                  | 401             |
| 7           | P1                             | P1-C1                   | C2                  | 401             |
| 8           | P1                             | null                    | C1                  | Pass            |

### FAQs / Open questions

1. Authentication combination in user read
   1. Ans: See table above.
2. Can an admin remove the group creator?
   1. Ans: No, admin shall not be able to modify privileges of the group creator.
3. User\_Type - other/Teacher/Student - Does it sound meaningful? What must be this for managed users?
   1. Ans: Other
4. Could a managed user ‘seamlessly' switch to the any user account?
   1. Ans: If the target user account has a password or a PIN set, then there will be a prompt for authentication.
5. Should we allow 1 user to consume courses from more than 1 device at the same time?
   1. Ans: We could stop ‘same time’ consumption from different devices. Given this is a learning journey, this is not of high importance to be done immediately.
6. Could the managed user be allowed to inherit location attribution from the parent account?
   1. Ans: Inherit for convenience, but ask confirmation before save.
7. What’s the root organisation for managed users?
   1. Managed users are created against ‘custodian’ organisation only. This is un-modifiable while being managed by another user. The org association can be reset post converting a managed user account to a first class user account.
8. Who can delete the managed user?
   1. Ans: The owner that created the managed user can delete it, as long as it is still managed.
9. Can we allow a managed user be allowed to login, say with a PIN?
   1. Ans: Yes, this is possible in future, not for June 15.

### References

1. Some thoughts on user and token management - [https://miro.com/app/board/o9J\_ktc0tQM=/](https://miro.com/app/board/o9J\_ktc0tQM=/)

###

Meeting notes

#### June 4, 2020

Need to introduced managedToken for mua users.

#### May 11, 2020

Avoid using profile and call it ‘managed user’; lets not indicate parent-child relationship, even for the schema - use ‘managedBy’ instead.

seamless switching to be disallowed if the target has a credential (password) or PIN set.

#### May 4, 2020

Import/Export can come later

isDefault - is it a preference thing? where is it stored?

isProfile - how/who sets?

JWT - KC auth token for profiles - content-update, update user

Group - grouping of profiles - add/join - remove/leave

Discussion groups/Learning Journey/Class - are functional modules

over Groups.

Group admin only can change the group - June 15.

Group owner and members

Reporting, Profile location - location based dashboards

read must happen uuid

notification - email, phone - how will it react with NULL

Root org id - framework is derived from it - UI depends

* what is the org of the profile?

Future

Extended pref and attributes - teacher profile having ext id

#### Apr 29, 2020

Tuition Class

* Tuition teacher device - simply add a profile - and credits are done to the profile.
* The profile may or may not exist.

Allow grouping of profiles - group also has BMGS - the owner can be 'any' user.

Invite a group to batch, class.

***

\[\[category.storage-team]] \[\[category.confluence]]

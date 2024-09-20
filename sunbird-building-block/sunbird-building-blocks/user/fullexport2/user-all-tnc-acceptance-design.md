# User-All-TnC-acceptance-Design

To support multiple type of terms and condition we have designed a global acceptance fields in the user table. A user might have to accept multiple terms and conditions to access the diksha platform. Hence, as it will be specific to each user, we have created a new field allTncAccepted fields to store those values.

```sql
CREATE TABLE sunbird.user (
    id text PRIMARY KEY,
    accesscode text,
    alltncaccepted map<text, text>,      //new field
    avatar text,
    channel text,
    countrycode text,
    createdby text,
    createddate text,
    currentlogintime text,
    datasharingtncacceptedon timestamp,
    dob text,
    email text,
    emailverified boolean,
    firstname text,
    flagsvalue int,
    framework map<text, frozen<list<text>>>,
    gender text,
    grade list<text>,
    groupstncacceptedon timestamp,
    isdeleted boolean,
    language list<text>,
    lastlogintime text,
    lastname text,
    location text,
    locationids list<text>,
    loginid text,
    managedby text,
    maskedemail text,
    maskedphone text,
    password text,
    phone text,
    phoneverified boolean,
    prevusedemail text,
    prevusedphone text,
    profilesummary text,
    profilevisibility map<text, text>,
    provider text,
    recoveryemail text,
    recoveryphone text,
    registryid text,
    roles list<text>,
    rootorgid text,
    status int,
    subject list<text>,
    tcstatus text,
    tcupdateddate text,
    temppassword text,
    thumbnail text,
    tncacceptedon timestamp,
    tncacceptedversion text,
    updatedby text,
    updateddate text,
    userid text,
    username text,
    usertype text,
    webpages list<frozen<map<text, text>>>
) 
```

alltncaccepted is a map which stores the type of tnc config and corresponding object as a json string.

To use the alltncaccepted configuration, the config should be updated to _system\_settings_ table through system setting api.

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

The following are the terms and condition for a user is stored in the allTncAccepted fields.

#### Terms and Condition

Group Terms and Condition _groupsTnc_ is used to store groups terms and condition where groups accepted version and date is stored.

User Read operation.

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
            .........
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

#### SB-21223 T\&C Pop-up for Org (State) Admin&#x20;

Org Admin user tnc field should be configured with system setting api.

Step 1: System Setting Api to configure the tnc version.

Please use “ _orgAdminTnc” value as system will identify as org Admin Tnc based on this keyword._

```
curl --location --request POST 'https://dev.sunbirded.org/api/data/v1/system/settings/set' \
--header 'x-authenticated-user-token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJsclI0MWpJNndlZmZoQldnaUpHSjJhNlowWDFHaE53a21IU3pzdzE0R0MwIn0.eyJqdGkiOiI1ZjJjZDZkZC05MjcyLTQ1ZWYtOGU2Ni02ODVkMzBiYTMzMzEiLCJleHAiOjE2MDI5MTE3NjAsIm5iZiI6MCwiaWF0IjoxNjAyODI1MzYwLCJpc3MiOiJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJhdWQiOiJwcm9qZWN0LXN1bmJpcmQtZGV2LWNsaWVudCIsInN1YiI6ImY6NWE4YTNmMmItMzQwOS00MmUwLTkwMDEtZjkxM2JjMGZkZTMxOjk1ZTQ5NDJkLWNiZTgtNDc3ZC1hZWJkLWFkOGU2ZGU0YmZjOCIsInR5cCI6IkJlYXJlciIsImF6cCI6InByb2plY3Qtc3VuYmlyZC1kZXYtY2xpZW50IiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiY2FiMjdmYTMtYTVmOC00MDE3LWEzMGMtZTZkZTgyYjUyODgwIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2Rldi5zdW5iaXJkZWQub3JnIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sIm5hbWUiOiJSZXZpZXdlciBVc2VyIiwicHJlZmVycmVkX3VzZXJuYW1lIjoibnRwdGVzdDEwMyIsImdpdmVuX25hbWUiOiJSZXZpZXdlciIsImZhbWlseV9uYW1lIjoiVXNlciIsImVtYWlsIjoidXMqKioqQHlvcG1haWwuY29tIn0.f7injCMpysb8fjNAHeQ3LzXe-0_Rw0tecbmde38MKg5pa5ZfhH6JVIkuEEx_o-D_znseMZKQXYI6UkPrOod9noR4Hva5pFD7DGPbOfUUIeNs6mymOd5m-OyUJizYb2kulJdevpPqU6vT612cViuk_Nc8XENJimzDzxskmsruVB70iscF7rkneBpPcVRinOQeZrqDVgXxFR2xJkzD7S7RnFRpafxAf3xDuDhAtTlRUFzXDaSHteIbdlPibGj1BowHFb4CMILaq-IB3pYbQ5AeW64bU5z7WdDEjGY479NNQHPqcPSwOr49mMrWI27cLnbUZymIn8zbPVzs6UWYKBkkcg' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIyZThlNmU5MjA4YjI0MjJmOWFlM2EzNjdiODVmNWQzNiJ9.gvpNN7zEl28ZVaxXWgFmCL6n65UJfXZikUWOKSE8vJ8' \
--data-raw '{
  "request": {
    "id": "orgAdminTnc",
    "field": "orgAdminTnc",
    "value": "{\"latestVersion\":\"3.5.0\",\"3.5.0\":{\"url\":\"<url for tnc>\"}}"
  }
}'
```

Step 2:

Whenever org admin accept the terms and condition it should be save using accept terms and condition api with the above tnc config value.

```
curl --location --request POST 'https://dev.sunbirded.org/api/user/v1/tnc/accept' \
--header 'Connection: keep-alive' \
--header 'Pragma: no-cache' \
--header 'Cache-Control: no-cache' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'Origin: https://diksha.gov.in' \
--data-raw '{
    "request":{
        "tncType":"orgAdminTnc",
        "version":"3.5.0"        
        }
}'
```

Read User Api to confirm org admin TnC acceptance

```
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
            .........
            "allTncAccepted": {                                                                         //tncType: groups
                "orgAdminTnc": {
                    "tncAcceptedOn": "2020-10-12 12:56:40:563+0530",
                    "version": "3.5.0"
                }
            },
           ..........
        }
    }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]

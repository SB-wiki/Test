# Design-for-One-time-password-(OTP)

**Problem statement:** \*\* \*\* As a sunbird system it should have capability to generate and validate generated OTP.  As per current requirement OTP can be generated for mobile number or email.

#### Proposed Solution 1:

&#x20;Sunbird will expose a new end-point to generate OTP. This end-point will have following checks.

&#x20;&#x20;

```js
Api details:
URI : v1/otp/generate
Method: POST
header: api key
request body:
 {
 "request":
     {
       "userId":"valid user id"
       "key":"email/phone/prevUsedEmail/prevUsedPhone value", // prevUsedEmail/prevUsedPhone value should be used if userId is not null for forgot password flow
        "type" : "supported type as of now{email or phone}" 
     }

}

Response:
    Case 1 : 200
     {
    "id": "api.otp.generate",
    "ver": "v1",
    "ts": "2018-11-28 11:12:31:853+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf",
        "err": "",
        "status": "success",
        "errmsg": ""
    },
    "responseCode": "OK",
    "result": {
         "response":"SUCCESS"
        }
}

 Case 2 : 400
     {
    "id": "api.otp.generate",
    "ver": "v1",
    "ts": "2018-11-28 11:12:31:853+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf",
        "err": "MAX_LIMIT_EXHAUSTED",
        "status": "MAX_LIMIT_EXHAUSTED",
        "errmsg": "Only 4 OTP can be generated with in 24 hours"
    },
    "responseCode": "CLIENT_ERROR",
    "result": {
        }
}

// 400 error code can have : Phone or email is already in used , INVALID_PHONE/EMAIL , PHONE/EMAIL IS BLOCKED.

Case 3 : 500
     {
    "id": "api.otp.generate",
    "ver": "v1",
    "ts": "2018-11-28 11:12:31:853+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf",
        "err": "SERVER_ERROR",
        "status": "SERVER_ERROR",
        "errmsg": "Process failed, please try again."
    },
    "responseCode": "SERVER_ERROR",
    "result": {
        }
}




```

\-- **This api will have following validations**

1. User ID validation(Optional)2. Request validation based on type {phone or email}.3. Requested phone/email should not present in user data base. if it's present in user DB then throw error.- {"Phone or email is already in used."}4. If requested phone/email is already in otp authenticate table and is not expired yet and attempt threshold is less than set value then send same OTP.5. if OTP request is for first time then generate an OTP, store into db and send to user with valid channel. valid channel can be (email/Phone)6. If user requested for OTP and OTP is expired and attempt count is less than threshold value-      - **Scenario 1:** Either used same OTP and update attempt count and generated time. ( **Need discussion** )      - \*\*Scenario 2: \*\* Either generate new OTP and reset all attribute.      - **Scenario 3:**  Generate new OTP and reset only attempt count and generated time. 7. If user requested for OTP and OTP is expired and attempt count greater than equal to threshold value  Or OTP is not expired but attempt count more than threshold then throw an error. and put this data into in-memory for particular time to , so that next time it will check in cache it self if phone/email found then through error8. Api gateway will have ip based throttling for this api, so that from same IP you can't continuously hit it.9. Sunbird will have phone based throttling. \[\[API throttling|API-throttling]] or \[\[OTP API Throttling|OTP-API-Throttling]]  **-- OTP generation will have following setting :** 1. Number of digits (minimum number and max number will be predefined, user can set any range from min to max  as a predefined env variable. this setting will be applicable per installation). If user is not setting any value then system will pick default one or if user will set incorrect range then also it will pick default value.2. User can configure to generate only digits or alphanumeric  as an other env, by default it will generate digits only.3. OTP generation/verification can be enable/disable based on env settings, if due to some reason SMS service is blocked or some other issues then we can used this env variable to disable this call from Api as well as portal/app both.

#### Proposed Solution 2:

&#x20;     Msg91 has option to send OTP and verify OTP , So we can used Msg91 service itself.

&#x20;     [https://docs.msg91.com/collection/msg91-api-integration/5/send-otp-message/TZ6HN0YI](https://docs.msg91.com/collection/msg91-api-integration/5/send-otp-message/TZ6HN0YI)

| Pros | Cons |
| ---- | ---- |
|      |      |

1. No need to manage OTP generation, resend and verification part
2. Quick Initial setup

|

1. Improve cost impact. (one OTP cost is 0.22 and one message cost is 0.18 )
2. to implement some custom business logic , will take more time.
3. Phone number will be exposed to third party

|

#### Table structure to store OTP:

| Key        | data type                    | purpose                                                                                              |
| ---------- | ---------------------------- | ---------------------------------------------------------------------------------------------------- |
| type+key   | text (composite primary key) |                                                                                                      |
| type       | text                         | possible values are email or phone. Based on type we can identify key having value as email or phone |
| key        | text (encrypted in DB)       | source against which OTP is generated (key will have value as either email or phone)                 |
| OTP        | text                         | generated OTP                                                                                        |
| createdOn  | timestamp                    | at which time it was generated                                                                       |
| updatedOn  | timestamp                    | when it was last used                                                                                |
| retryCount | int                          | how many time user already retried it                                                                |
| isLocked   | boolean                      | if retry count exceed limit then isLocked true                                                       |
| lockedOn   | timestamp                    | when it was locked.                                                                                  |

Table structure to store invalid/blocked phone number

Structure : 1

| key       | data type | purpose                                                                                                                                                                   |
| --------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| phone     | text      | phone number which is marked as invalid or blocked by sms gateway.                                                                                                        |
| createdOn | timestamp | when row inserted                                                                                                                                                         |
| blockedOn | timestamp | when this user was blocked, if any phone number is blocked due to max hit or some other reason then we can move that row in this table and from OTP table will delete it. |
|           |           |                                                                                                                                                                           |

Structure 2:

| key       | data type | purpose                                                                                                                                                                   |
| --------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| key       | text      | can be invalid/blocked phone number or email                                                                                                                              |
| type      | text      | As of now it can be email or phone                                                                                                                                        |
| createdOn | timestamp | when row inserted                                                                                                                                                         |
| blockedOn | timestamp | when this user was blocked, if any phone number is blocked due to max hit or some other reason then we can move that row in this table and from OTP table will delete it. |

#### Open questions:

* &#x20; Process to clear expired OTP or blocked OTP (when exactly we need to clear it.)  &#x20;

&#x20;            Proposed solution:

&#x20;                  1\.  Use TTL and cassandra will automatically removed that records from table. (Accepted solution: OTP cleanup will happen based on ttl)

&#x20;                  2\. When ever user try next time , and then based on business logic if he is applicable for new OTP then remove old one

&#x20;                  3\. Based on some nightly scheduler job.

* &#x20;  Sending SMS or Email are Async call , if format is valid it will return success , but later it will try to send it that might got failure.
* &#x20;   As SMS gate way will have api to check delivery reports : [https://docs.msg91.com/collection/msg91-api-integration/5/delivery-report/T19VM23R](https://docs.msg91.com/collection/msg91-api-integration/5/delivery-report/T19VM23R)
* &#x20;   Msg91 provides webhooks to get delivery reports , so instead of we making call to get reports , we can use webhook:  [https://help.msg91.com/article/56-how-can-i-get-the-delivery-reports-on-my-url-through-api-what-is-the-reason-for-not-getting-report-on-my-url](https://help.msg91.com/article/56-how-can-i-get-the-delivery-reports-on-my-url-through-api-what-is-the-reason-for-not-getting-report-on-my-url)&#x20;
  * possibility to attach a scheduler to get the status based on messageId and update the status in DB
* &#x20;   In case of email how can we confirm delivery reports? ( In this release we are not using any delivery reports)
* &#x20;  What will happen if delivery reports indicates failure ? (cases like blocked or invalid numbers)
* &#x20;  What should be frequency to get OTP delivery reports? ( In this release we are not using any delivery reports)

#### Accepted Solution is proposed solution 1&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

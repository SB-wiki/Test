# Automate-user-tenant-migration-SB-12693

### \*

* [Proposal](automate-user-tenant-migration-sb-12693.md#proposal)
  * [New workflow](automate-user-tenant-migration-sb-12693.md#new-workflow)
  * [Current Workflow (for reference)](automate-user-tenant-migration-sb-12693.md#current-workflow-\(for-reference\))
* [API ](automate-user-tenant-migration-sb-12693.md#api )
  * [Request](automate-user-tenant-migration-sb-12693.md#request)
  * [Response](automate-user-tenant-migration-sb-12693.md#response)
* [Mapping from SSO JWT to sunbird request body](automate-user-tenant-migration-sb-12693.md#mapping-from-sso-jwt-to-sunbird-request-body)
* [Review comments (30 May 2019, DC - Rayulu, Portal - Vinu , Raghavendra, Anoop, User - Manzarul, Rajesh)](automate-user-tenant-migration-sb-12693.md#review-comments-\(30-may-2019,-dc---rayulu,-portal---vinu-,-raghavendra,-anoop,-user---manzarul,-rajesh\)) Description States that choose to use SSO as the preferred means of account creation for their teachers are still seeing self sign-ups happening (perhaps, because of instructions missed or reaching late). When self-signed up users attempt login via SSO, the system would ask for phone number in 2.0.0 for verification. It does not permit them to login, if they use the same phone number they used for self sign up (as a duplicate account is detected).

There needs to be a solution that does not have a dependency on the state or the internal implementation team to permit self-signed up users to onboard their 'correct'/respective tenant organisations. The following are the primary considerations:

1. Users may carry out self sign-up using phone number or email ID.
2. The fact that a user is attempting to sign up via SSO (ie. has already logged in to the state system) established the fact that the user is a valid state user.
3. Detection of a duplicated account in the course of the SSO sign up should support both phone number and email ID (the current SSO implementation supports only phone numbers)
4. Any user activity (course consumption, content creation etc.) should be retained when a user account is migrated from custodian to the state tenant.
5. The migration should be in sync with the on boarding approach for the state - if the state has created sub-orgs for school, the migration should account for appropriate movement of the users. (Either the migration takes care of it, or the subsequent SSO call should)

### Proposal

* A new API /migrate will be introduced to migrate user from one root org to another.
* This API will not only migrate user from custodian org, but from any root org to another. We think, a teacher could possibly switch states (transfer).
* This API has to be private. Authentication token cannot be generated for a guest login (to-be-created user) upfront.

#### New workflow

Migration is applicable for new SSO user only.

**approach 1 (RECOMMENDED)** &#x20;

Scenario 1:

User is coming from SSO → system will check user already exist or not (read user profile called by userExternalId, idType and provider)

Case A → user not found → ask user to enter phone or email and do otp verification → make call to get user details by provided email or phone

Case B → user found  and he completed OTP verification then call user migrate endpoint→ on success of user migrate do user auto login.

Scenario 2 :

User is coming from SSO → system will check user already exist or not (read user profile called by userExternalId, idType and provider)

Case A → user not found → ask user to enter phone or email and do otp verification → make call to get user details by provided email or phone

Case B → if user not found and he completed OTP verification then call create user endpoint→ on success of create user do user auto login.

**approach 2:**   &#x20;

Scenario 1:

User is coming from SSO → system will check user already exist or not (read user profile called by userExternalId, idType and provider)

Case A → user not found → ask user to enter phone or email and do otp verification →  make call to create user → on success of user create do user auto login.

Case B → user found → allow login

Scenario 2:

User is coming from SSO → system will check user already exist or not (read user profile called by userExternalId, idType and provider)

Case A → user not found → ask user to enter phone or email and do otp verification →  make call to create user → on failure 400 error (phone or email is already in used ) → make migrate user api call → on success of migrate user do user auto login.

Case B → user found → allow login

#### Current Workflow (for reference)

&#x20; Scenario 1: &#x20;

&#x20;  User is coming from SSO → system will check user already exist or not (read user profile called by userExternalId, idType and provider) → if user found then user login will happen

&#x20;Scenario 2:&#x20;

&#x20;  User is coming from SSO → system will check user already exist or not (read user profile called by userExternalId, idType and provider) → user not found → ask user to enter phone and do otp verification → Once otp verification done call create user api → on success of create user do user auto login.

### API&#x20;

* URL : {baseURl}/private/user/v1/migrate
* Method : PATCH

#### Request

```js
"request":{
"userId":"123456",           
"channel":"TN",
"orgId":"123456789",
"orgExternalId":"1212423", 
"externalIds":[
                 {
                    "id":"userExternalId",
                    "idType":"externalIdType",
                    "provider":"externalIdProvider",
                    "operation":"ADD"
                 }
              ]
           }

Notes : userId and channel are mandatory. For externalIds all the field inside map like id,idType and provider is mandatory.
        


```

#### Response

```js
Response :
{
 "id": "api.private.user.migrate",
  "ver": "v1",
  "ts": "2019-05-28 11:56:33:089+0000",
  "params": {
      "resmsgid": null,
       "msgid": "217d76cd-8019-4f5e-8373-21f298180348",
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

FailureFailure response code : { 400,404 }

```js
// Example for 404
{
    "id": "api.private.user.migrate",
    "ver": "v1",
    "ts": "2019-05-29 07:02:49:899+0000",
    "params": {
        "resmsgid": null,
        "msgid": "test-123-0009-000000",
        "err": "USER_NOT_FOUND",
        "status": "USER_NOT_FOUND",
        "errmsg": "User not found."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}

// Example for 400
{
    "id": "api.private.user.migrate",
    "ver": "v1",
    "ts": "2019-05-29 07:05:25:867+0000",
    "params": {
        "resmsgid": null,
        "msgid": "test-123-0009-000000",
        "err": "INVALID_PARAMETER_VALUE",
        "status": "INVALID_PARAMETER_VALUE",
        "errmsg": "Invalid value test123 for parameter channel. Please provide a valid value."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}

// When user is not coming from custodianOrg
{ resmsgid: null,\n\n  msgid: '99ff4c70-884f-11e9-aa40-2fc573b523d2',\n\n  err: 'PARAMETER_MISMATCH',\n\n  status: 'PARAMETER_MISMATCH',\n\n  errmsg: 'Mismatch of given parameters: user rootOrgId and custodianOrgId.' }
```

### Mapping from SSO JWT to sunbird request body

| SSO        | Sunbird        |
| ---------- | -------------- |
| sub        | userExternalId |
| state\_id  | channel        |
| school\_id | orgExternalId  |
| state\_id  | idType         |
| state\_id  | provider       |

Notes

1. userExternalId is optional because some states might not have externalIds.
2. orgExternalId is provided in input to ensure the user sees these values correctly on first time login. Otherwise, subsequent orgExternalId changes will automatically be picked up with fix of [SB-11433](https://project-sunbird.atlassian.net/browse/SB-11433) (Enable user account updates as part of SSO.)
3. If orgExternalId is given, then the user will also be associated with the respective organisationId (if organisationId is different than rootOrgId for the given channel). Otherwise, user will get associated with only root organisation.
4. if provided orgExternalId does not exist or not belong to same channel then system will throw 400 error, with an error message
5. If user is providing idType and provider then uniqueness of all these three will be checked , if idType and provider is not provided by user then both value will be replaced with incoming channel value. Please note that this is not an update API.
6. It is safe to assume that externalIds are correctly updated in the SSO systems.
7. User in custodian org cannot create courses. Existing state users have created users having logged in SSO (not via self-signup).

Open questions

1. Do we need to validate the userId in request (whether its valid or not And if valid whether its active or not)? We suggest the validation must be done prior to calling this /migrate API; agreement needed.  **Owner** : Dev (Portal, User) and DC Agreement is that validation will be done at the portal.
2. Same doubt as above for orgExternalId and channel. We suggest the validation must be done prior to calling this /migrate API; agreement needed.  **Owner** : Dev (Portal, User) and DC . Agreement is that validation will be done at the portal.
3. What if externalIds they are passing is already being used by another user? Is it safe to assume SSO systems are correctly updated with userExternalId - **Owner** : DC  see note 6
4. Post migrate, the ElasticSearch will be updated with the correct org. Is there any impact to the reporting/dashboard. **Owner** :&#x20;
5. Once the user migrates from one org to another, would there be any impact to the courses he/she created? What would be the state of draft courses? Note, courses he/she enrolled will automatically migrate to the new org.  **Owner** : DC, ,  See Note 7

### Review comments (30 May 2019, DC - Rayulu, Portal - Vinu , Raghavendra, Anoop, User - Manzarul, Rajesh)

* Request is very specific to SSO
* Add Org id (instead of orgExternalId)
* No dependency with Mahesh (because custodian org users cannot create courses)
* Slight/No dependency with Analytics - Talk to Rahul (for confirmation)

Changes needed- orgExternalId is an array . (match what is the type in createUser)

&#x20;   :: **In create user API orgExternalId is string not an array.**

\*\*               In create user API, we have externalIds that is an array of map , which refer to user externalIDs ex:\*\*

\*\*                "externalIds" :  \[\*\*

\*\*                                        {\*\*

\*\*                                          "id":"userExternalId",\*\*

\*\*                                          "idType":"externalIdType",\*\*

\*\*                                         "provider":"externalIdProvider"\*\*

\*\*                                        }\*\*

\*\*                                     ]\*\* - Optionally, support orgId (not just orgExternalId)

:: **will support, but if in request both field is present then will consider only orgId ,will not check orgExternalId**

* Ensure replacement happens for org/sub-org associations (don’t append)
* Make the API specific to migrate user ONLY from custodian org (to be taken up later - root org to root org, involves course metadata updates)
* Ensure telemetry audit event for migration

```js
{
"eid": "AUDIT",
"ets": 1559788911351,
"ver": "3.0",
"mid": "1559788911351.dc14a6a5-8128-4fdf-92c8-5f596285ee2e",
"actor": {
"id": "internal",
"type": "Consumer"
},
"context": {
"channel": "0127766567206174720",
"pdata": {
"id": "local.sunbird.learning.service",
"pid": "learning-service",
"ver": "2.0.0"
},
"env": "Consumer",
"did": "X-Device-ID",
"cdata": [],
"rollup": {
"l1": "0127766648284446722"
}
},
"object": {
"id": "7d108bcf-75d8-4666-b3ec-eea30b35f5d1",
"type": "User"
},
"edata": {
"state": "Migrate",
"props": [
"channel",
"id",
"userId"
]
}
}

```

&#x20;                                                                                                                                                                        &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

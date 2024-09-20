# Master-Key-APIs

BackgroundCurrently content update is done by the user who created it which creates problem and is complex in scenarios where an admin want to update content by retired user. There should be an easy way to allow users to update content at the same time it should have authentication.

Problem Statement 1What is the approach to generate the key?

Solution 1Create JWT token with data passed upon. A JWT token will be created using secret key and below data&#x20;

1. channel
2. name
3. description
4. organisationId
5. createdBy
6. createdOn

Solution 2Custom generated time based key.

Solution 3Using keycloak to generate an verify token to be used as masterkey.

**Pros and Cons**

| Key Generation Approach | Pros                                             | Cons                                                                                             |
| ----------------------- | ------------------------------------------------ | ------------------------------------------------------------------------------------------------ |
| JWT                     | no need to store the key in DB                   |                                                                                                  |
| Custom                  | method is available so negligible time consuming | key needs to be stored in db                                                                     |
| Keycloak                | comparatively faster to implement                | no support for channel or organisation based keykey would expire based on keycloak configuration |

Problem Statement 2What are the APIs required to manage master keys?

API SpecificationsCreate APIname and channel / organisationId is mandatory.

URL:&#x20;

POST /v1/auth/masterkey/create

Headers:

* Authorization
* x-authenticated-user-token

Request Params:

| param name     | type   | description                                                                                           |
| -------------- | ------ | ----------------------------------------------------------------------------------------------------- |
| channel        | String | channel for which master key is applicable for, if not provided can be calculated from organisationId |
| name           | String | consumer name                                                                                         |
| organisationId | String | organisationId for which master key is applicable for, if not provided can be calculated from channel |

Response Params:

| param name | type   | description                                                                     |
| ---------- | ------ | ------------------------------------------------------------------------------- |
| key        | String | generated master key, mapped with the requested channel/organisationId and name |

Errors:

| status code | error code                    | error message                                                                     |
| ----------- | ----------------------------- | --------------------------------------------------------------------------------- |
| 400         | INVALID\_ORG\_DATA            | Given Organization Data doesn't exist in our records. Please provide a valid one. |
| 400         | MANDATORY\_PARAMETER\_MISSING | Mandatory parameter {channel/organisationId, name} is missing.                    |
| 400         | PARAMETER\_MISMATCH           | Mismatch of given parameters: channel, organisationId.                            |
| 400         | KEY\_EXISTS                   | Key exists for given channel {} and consumer {}                                   |

Sample Request and Response:

trueRequest

{ request : { "channel" : "sunbird", "name" : "DikshaImplTeam", "orgId" : "01262366359399628812" } }

Response

{ "id": "api.auth.masterkey.create", "result": { "key" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaGFubmVsIjoic3VuYmlyZCIsIm5hbWUiOiJEaWtzaGFJ bXBsVGVhbSIsImNyZWF0ZWRCeSI6MTUxNjIzOTAyMiwiY3JlYXRlZE9uIjoxNTE2MjM5MDIyLCJleHBpcmVzT24iOjE1MTYyNDkwMjIsIm9yZ0lkIjoiMjM0NTY1NDU2In0.Cs5-FW7OHip6njkQvMP6zpIVB5Q-xLLgz\_jnYW3zPOw" } }

Verify APIURL:

POST /v1/auth/masterkey/verify

Headers:

* Authorization

Request Params:

| param name | type   | description           |
| ---------- | ------ | --------------------- |
| key        | String | master key to verify  |

Response Params:

| param name     | type      | description                              |
| -------------- | --------- | ---------------------------------------- |
| channel        | String    | channel name related to master key       |
| name           | String    | consumer name                            |
| description    | String    | describes the purpose for master key     |
| organisationId | String    | organisation Id mapped with key          |
| createdBy      | String    | userId of the person who created the key |
| createdOn      | timestamp | timestamp when master key was created    |

Errors:

| status code | error code                    | error message                       |
| ----------- | ----------------------------- | ----------------------------------- |
| 400         | INVALID\_KEY                  | Given master key is invalid         |
| 400         | MANDATORY\_PARAMETER\_MISSING | Mandatory parameter key is missing. |

Sample Request and Response:

trueRequest

{ request : { "key" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaGFubmVsIjoic3VuYmlyZCIsIm5hbWUiOiJEaWtzaGFJ bXBsVGVhbSIsImNyZWF0ZWRCeSI6MTUxNjIzOTAyMiwiY3JlYXRlZE9uIjoxNTE2MjM5MDIyLCJleHBpcmVzT24iOjE1MTYyNDkwMjIsIm9yZ0lkIjoiMjM0NTY1NDU2In0.Cs5-FW7OHip6njkQvMP6zpIVB5Q-xLLgz\_jnYW3zPOw" } }

Response

{ "id": "api.auth.masterkey.verify", "result": { "channel": "sunbird", "name": "DikshaImplTeam", "description": "organisation content" "organisationId": "01262366359399628812" "createdBy": "00dd6646-be73-4fb0-b676-ccd01bda085e", "createdOn":1548932815386, } }

Delete APIURL:

POST /v1/auth/masterkey/delete

Headers:

* Authorization
* x-authenticated-user-token

Request Params:

| param name     | type   | description                                             |
| -------------- | ------ | ------------------------------------------------------- |
| channel        | String | channel for which master key needs to be deleted        |
| name           | String | consumer name                                           |
| organisationId | String | organisationId for which master key needs to be deleted |

Response Params:

None

Errors:

| status code | error code                    | error message                                                  |
| ----------- | ----------------------------- | -------------------------------------------------------------- |
| 400         | MANDATORY\_PARAMETER\_MISSING | Mandatory parameter {channel/organisationId, name} is missing. |
| 400         | KEY\_NOT\_EXISTS              | Key does not exists for given channel {} and consumer {}       |

Sample Request and Response:

trueRequest

{ request : { "channel" : "sunbird", "name" : "DikshaImplTeam", "orgId" : "01262366359399628812" } }

Response

{ "id": "api.auth.masterkey.delete", "responseCode": "OK", "result": { } }

Problem Statement 3What is the DB design for storing information about master keys?

approach 1:JWT token Table Structure&#x20;

| column         | type      | description                                         |
| -------------- | --------- | --------------------------------------------------- |
| channel\*      | text      | consist user provide channel name                   |
| name\*         | text      | provided by user                                    |
| organisationId | text      | provided by user or root org id mapped with channel |
| createdBy      | text      | user id who created the master key                  |
| createdOn      | timestamp | created time                                        |

approach 2:custom generated key

| column         | type      | description                                         |
| -------------- | --------- | --------------------------------------------------- |
| channel\*      | text      | consist user provide channel name                   |
| name\*         | text      | provided by user                                    |
| organisationId | text      | provided by user or root org id mapped with channel |
| key            | text      | holds custom generated key                          |
| createdBy      | text      | user id who created the master key                  |
| createdOn      | timestamp | created time                                        |

Problem Statement 4How to use generated master key to bypass existing user authentication?

approach 1:

* master key will be passed in X-authenticated-user-token
* use an extra header ( **X-authentication-type** ) declaring the type of authentication as master( for master key and user for user authentication).&#x20;

approach 2:

* extra header ( **X-authentication-master-key** ) to pass master key.
* If above header is present it supersedes the user authentication&#x20;

**Pros and Cons**

| Key Usage Approach    | Pros                                                     | Cons |
| --------------------- | -------------------------------------------------------- | ---- |
| X-authentication-type | In future it can support additional authentication types |      |

***

\[\[category.storage-team]] \[\[category.confluence]]

# Design-for-easy-way-to-update-content

Problem StatementCurrently to update the content implementation team needs to make multiple calls, which makes it a difficult process. Additionally there is no auditing in place to track as content was updated by whom. There should be an easier way to update the content.

[SB-10220 System JIRA](https://browse/SB-10220)Solution ApproachSolution approach to overcome the problem has below approaches

APPROACH 1

1. Sunbird Platform will expose an API for end user to initiate update content
2. Sunbird Platform will log the request in DB and pass the user a generated process Id
3. Sunbird Platform will send the request with processId to kafka message queue
4. Request will be picked up by Learning platform and would start the processing of update content based on the request
5. Sunbird Platform will use a listener to get the status update and store in DB from the kafka based on processId

Approach 2

1. Sunbird Platform will expose an API for end user to initiate update content
2. Sunbird Platform will internally call Content Service with the request provided by User.
3. Content Service will initiate the update process through kafka pipeline and will return unique process ID identifying the process.
4. For valid response from Content Service, processId with other details will be saved in Sunbird platform DB
5. On user call to get status, Sunbird Platform will call Content Service.&#x20;

pros and cons of both approaches

| approaches                | pros            | cons                                                                                                            |
| ------------------------- | --------------- | --------------------------------------------------------------------------------------------------------------- |
| 1.without content service | loosely coupled |                                                                                                                 |
| 2.with content service    |                 | dependent on content service,duplicate storage of statuses and processesby Content Service and Sunbird platform |

Problem StatementWhat is the API for update content?

Solution approachURL:

POST /v1/job/start

Headers:

Authorization

X-authenticated-user-token

Request Params:

| name       | type   | description                                                    |
| ---------- | ------ | -------------------------------------------------------------- |
| scriptName | String | name of the script to be run by Content Service                |
| version    | String | the version of the script                                      |
| attributes | Array  | attributes to be updated, will work as arguments to the script |

Response Params:

| name      | type   | description                                                                                       |
| --------- | ------ | ------------------------------------------------------------------------------------------------- |
| processId | String | unique identifier of the process started for the request, needed to get the status of the process |

Errors:

| status code | error code                    | error message                                    |
| ----------- | ----------------------------- | ------------------------------------------------ |
| 400         | MANDATORY\_PARAMETER\_MISSING | Mandatory parameter {script,version} is missing. |

Sample Request and Response:

trueRequest

{ request : { "scriptName" : "course\_rename", "version" : "1.2", "attributes" : \[{ "field" : "name" "oldValue" : "AB", "newValue" : "ab" },{ "field" : "orgDetails" "oldValue" : { "courseName" : "AB" }, "newValue" : { "courseName" : "ab" } }] } }

Response

{ "id": "api.job", "result": { "processId" : "01262366359399628812" } }

Problem StatementHow we store the process information in DB

Solution approachcontent\_update\_process table structure should be as below

| column     | type      | description                                     | Index     |
| ---------- | --------- | ----------------------------------------------- | --------- |
| id         | text      | holds process id                                | PRIMARY   |
| scriptName | text      | name of the script to run                       |           |
| version    | text      | the version of the script                       |           |
| request    | text      | holds the input request as it is                |           |
| status     | text      | the status last received from content service   |           |
| message    | text      | message from content service in case of failure |           |
| createdBy  | text      | userId of one who invoked the process           | SECONDARY |
| createdAt  | timestamp | when the process was started                    |           |
| updatedAt  | timestamp | when the process was last updated               |           |

Problem StatementWhat is the API for getting the process status

Solution approachURL:job

GET /v1/job/status/{processId}

Headers:

Authorization

X-authenticated-user-token

Request Params:

None

Response Params:

| name    | type | description                                |
| ------- | ---- | ------------------------------------------ |
| status  | text | status as COMPLETED or FAILURE             |
| message | text | contains error messages in case of failure |

Errors:

| status code | error code           | error message      |
| ----------- | -------------------- | ------------------ |
| 400         | INVALID\_PROCESS\_ID | Invalid Process Id |

Sample Request and Response:

trueRequest

GET /v1/job/status/01262366359399628812

Response

{ "id": "api.job.status", "result": { "status" : "FAILURE", "message" : "Operation to update failed" } }

Problem StatementWhat is the API for get all the processes by a user

Solution approachURL:

GET /v1/job/list

Headers:

Authorization

X-authenticated-user-token

Request Params:

None

Response Params:

returns an array of processes related to user

| name      | type | description                         |
| --------- | ---- | ----------------------------------- |
| processId | text | the process id                      |
| script    | text | the script for which process exists |
| version   | text | version of the script               |

Errors:

None

Sample Request and Response:

trueRequest

GET /v1/job/processes

Response

{ "id": "api.job.processes", "result": { processes : \[{ "processId" : "01262366359399628812", "script" : "course\_rename", "version" : "1.2" }] } }

Deprecated SOLUTION APPROACHSolution approach is divided into multiple part

* There should be generated key to facilitate the process of update of content in a channel by anyone who has the key, hence bypassing the user authentication process . The details of the master key generation design and approach are [here (Master Key APIs)](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/937394177/Master+Key+APIs).
* Auditing of the update of the content by keys.

***

\[\[category.storage-team]] \[\[category.confluence]]

# Tech-Design-for-Sync-Module

### Overview:

Need to design a module which is capable of queuing requests from the system.Request can be of following types:

a) Import Request

b) Delete Request

c) Export Request

d) Network Sync Request

&#x20;      1\) Telemetry Sync Request

&#x20;      2\)  Course Sync Request

&#x20;      3\)  FAQ Sync Request

&#x20;      4\)  Assessments Sync Request

### Problem statement:&#x20;

Offline Consumption Clients like Mobile,Desktop should have the capability to queue the requests as per user interaction. Since most of the times these clients are believed to be offline & support System Resource operations, It creates a need to have a queuing mechanism for the system so that user don't end up for longer time waiting for these requests to be served. Absence of such a system would end up having prolonged user experience, inefficient usage of system resources etc.

### Solution:

* Create two Queues in the system which can be broadly classified as follows:
  * System Queue
  * System Queue intends to support following operations:
  * Import (Download)
  * Delete
  * Export
  * Network Queue&#x20;
  * Network Queue
  * Telemetry Sync
  * Course Sync
  * FAQ Sync
  * Assessments Sync
* System Queue : This queue will enque the requests related to file system operations. There has been different categorisation to ensure we don't end up utilising resources during user interaction.
  * Export
  * Import
  * Delete

### Implementation Design:

Network Queue:&#x20;

Document Object:

{

id:,

baseUrl:,

pathToApi:,

requestHeaderObj:,

requestBody:,

authHeaderToken:,

BearerToken:,

priority:,

createdOn:,

updatedOn:,

}

SQLLite Table:

| id | baseUrl | pathToApi | requestHeaderObj | requestBody | authHeaderToken | BearerToken | priority | createdOn | updatedOn |
| -- | ------- | --------- | ---------------- | ----------- | --------------- | ----------- | -------- | --------- | --------- |
|    |         |           |                  |             |                 |             |          |           |           |

System Queue:

Document Object:

{

id: ,

type: '', //Example 'EXPORT','DELETE','IMPORT'/'DOWNLOAD',

size: '',

artifactUrl: '',

fileName: '',

Status:'',

Progress:'', //Percentage of Completion

createdOn: '',

updatedOn: '',

priority: ''

}

SQLLite Table

| id | type | size | artifactUrl | fileName | Status | Progress | createdOn | updatedOn | priority |
| -- | ---- | ---- | ----------- | -------- | ------ | -------- | --------- | --------- | -------- |
|    |      |      |             |          |        |          |           |           |          |

***

\[\[category.storage-team]] \[\[category.confluence]]

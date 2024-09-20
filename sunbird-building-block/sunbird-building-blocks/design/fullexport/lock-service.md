# Lock-Service

### Introduction

This page explains the design of lock service and types of locks that are possible with mechanism to lock a resource and unlock it with different possibilities.

### Background

When a user want to lock a resource if we take an example of a content creator editing a content which is available for other creators to collaborate there is a possibility of content being updated by other party without knowing creator of content who is editing at the same time in this scenario we need to lock or protect  the content  being modified by other creator and as sunbird which is possible if the resource locked and it will be available to other creators when the current user who locked that content  which similar to the operation system threads problem where multiple threads want to access same resource which handled using **mutex** **(mutual exclusion)**  we need to have the lock service as generalized solution for other use cases so that it can be used across the sunbird services to protect a resource whenever there is possibility of accessing multiple services or users.

#### Problem Statement&#x20;

Locking and unlocking of resource have multiple use cases which lock service should support

* Locking a resource by a user or system or service
* Unlock a resource by same user or system or service who acquired the lock
* Force unlock a resource by admin or other system or service,  in case of race condition where the user / system is unable to unlock the resource
* Auto unlock / Time based unlock&#x20;
* Request for lock by user or system  when  a lock is acquired by another system or user

#### Solution 1 - storing lock in cassandra and unlocking with db operations and using TTL for auto unlock&#x20;

In this solution  we will be storing lock and it's info in cassandra table which will have the interface methods or api's to acquire the lock and release the lock&#x20;

and the below is the table structure for it

**Lock Table**

| Column Name  | Data Type | Description                                                       |
| ------------ | --------- | ----------------------------------------------------------------- |
| resourceId   | text      | Resource id which is locked it is primary key                     |
| resourceType | text      | Type of the resource eg: content,org, user                        |
| resourceInfo | text      | Resource meta data                                                |
| creatorInfo  | text      | Additional information of the user / system who acquired the lock |
| createdBy    | text      | User or service id who acquired the lock                          |
| createdOn    | timestamp | Time when the lock is acquired                                    |
| deviceId     | text      | The device Id of the user                                         |
| expiresAt    | timestamp | Time at which the lock will expires                               |

here each row will have the TTL (Time To Leave) which will be configuration (By default 30 min) when a user gets the lock he will the time when the lock will be expires and he can refresh the lock before it expires the lock will provide another api to release it.

Below are the api Request and Response for lock service

### API

#### Create

&#x20;POST - _v1/lock/create_

**Headers:Authorization :** "" //Bearer &#x20;

**x-authenticated-user-token:** ""  // user token

**Content-Type:** "application/json"&#x20;

**X-device-Id:** "" // device Id generated using fingerprint2 js lib from client

**REQUEST BODY :**

&#x20;

{ "id": "api.lock.create", "ver": "1.0", "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn", "params": { "did": "", // device UUID from which API is called "key": "", // API key (dynamic) "msgid": "" // unique request message id, UUID }, "request":{\
"resourceId": "" // content Id, org Id "resourceType": "" // content for content, organization for orgs "resourceInfo": "" // meta data stringfied in JSON format for resource info "createdBy": "" // userId of the creator "creatorInfo": "" // user details who is trying for lock in stringified JSON format } }

\*\* RESPONSE :\*\*

{\
"id":"api.lock.create", "ver":"1.0", "ts":"YYYY-MM-DDThh:mm:ssZ+/-nn.nn", "params":{\
"resmsgid":"054f3b10-309f-4552-ae11-02c66640967b", "msgid":"h39r3n32-930g-3822-bx32-32u83923821t", "err":"", "status":"successful", // successful or failed "errmsg":"" }, "responseCode": "OK", "result":{\
"expiresIn": "" } }

**Refresh Lock** **PATCH** - v1/lock/refresh

**Headers:Authorization :** "" //Bearer &#x20;

**x-authenticated-user-token:** ""  // user token&#x20;

**Content-Type:** "application/json"

**X-device-Id:** "" // device Id generated using fingerprint2 js lib from client

{ "id": "api.lock.refresh", "ver": "1.0", "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn", "params": { "did": "", // device UUID from which API is called "key": "", // API key (dynamic) "msgid": "" // unique request message id, UUID }, "request":{\
"resourceId": "" // content Id "resourceType": "" // content } }

**RESPONSE:**

{\
"id":"api.lock.refresh", "ver":"1.0", "ts":"YYYY-MM-DDThh:mm:ssZ+/-nn.nn", "params":{\
"resmsgid":"054f3b10-309f-4552-ae11-02c66640967b", "msgid":"h39r3n32-930g-3822-bx32-32u83923821t", "err":"", "status":"successful", // successful or failed "errmsg":"" }, "responseCode": "OK", "result":{\
"expiresIn": "" } }

**UnLock** **DELETE** - v1/lock/retire

**Headers:Authorization :** "" //Bearer &#x20;

**x-authenticated-user-token:** ""  // user token&#x20;

**Content-Type:** "application/json"

**X-device-Id:** "" // device Id generated using fingerprint2 js lib from client

{ "id": "api.lock.retire", "ver": "1.0", "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn", "params": { "did": "", // device UUID from which API is called "key": "", // API key (dynamic) "msgid": "" // unique request message id, UUID }, "request":{\
"resourceId": "" // content Id, orgId "resourceType": "" // resource Type } }

**RESPONSE:**

{\
"id":"api.lock.retire", "ver":"1.0", "ts":"YYYY-MM-DDThh:mm:ssZ+/-nn.nn", "params":{\
"resmsgid":"054f3b10-309f-4552-ae11-02c66640967b", "msgid":"h39r3n32-930g-3822-bx32-32u83923821t", "err":"", "status":"successful", // successful or failed "errmsg":"" }, "responseCode": "OK" }

**List** **POST**  - v1/lock/list

**Headers:Authorization :** "" //Bearer &#x20;

**Content-Type:** "application/json"

**X-device-Id:** "" // device Id generated using fingerprint2 js lib from client

Request body is optional.&#x20;

{ "id": "api.lock.list", "ver": "1.0", "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn", "params": { "did": "", // device UUID from which API is called "key": "", // API key (dynamic) "msgid": "" // unique request message id, UUID }, "request": { "filters" : { "resourceId" :"" //Resource id - Can be array or string } } }

**RESPONSE:**

{ "id": "api.lock.list", "ver": "1.0", "ts":"YYYY-MM-DDThh:mm:ssZ+/-nn.nn", "params": { "resmsgid": "7dd6d650-f38d-11e8-a177-ebb7086bdf9c", "msgid": "7dd66120-f38d-11e8-b00a-83599527ff4d", "status": "successful", "err": null, "errmsg": null }, "responseCode": "OK", "result": { "count": 1, "data": \[ { "resourceId": "", // content Id, org Id "resourceType": "", // content for content, organization for orgs "resourceInfo": "", // meta data stringfied in JSON format for resource info "createdBy": "", // userId of the creator "creatorInfo": "", // user details who is trying for lock in stringified JSON format "created\_on": "", // time stamp on which the lock was created "deviceId": "", // device Id generated using fingerprint2 js lib from client "expiresAt": "", // // time stamp on which the lock will expire } ] } } **Scenarios:** **Create Lock:**

| Scenarios                                                                | Status Code | Message                                                            |
| ------------------------------------------------------------------------ | ----------- | ------------------------------------------------------------------ |
| If X-Authenticated-User-Token is not passed in header                    | 401         | Required field token is missing                                    |
| X-device-Id is not passed in header                                      | 400         | X-device-Id is missing in headers                                  |
| Request body is not valid. Eg - resourceId is not passed                 | 400         | "resourceId" is required                                           |
| Trying to create lock by the user who has already locked a same resource | 400         | The resource is already locked by you in a different window/device |
| Trying to create lock to a resource which is already locked              | 423         | The resource is already locked by \{{Lock creator\}}               |
| If resource id is not valid                                              | 412         | Content not found with id: \{{resourceId\}}                        |
| If content is not in draft state                                         | 412         | The operation cannot be completed as content is not in draft state |
| If user is not a creator or collaborator of the requested resourceId     | 412         | You are not authorized                                             |
| If fetching content details failed while locking a content               | 412         | Unable to fetch content details                                    |
| If lock creation API fails                                               | 500         | Creating lock failed                                               |
| If lock creation is successful                                           | 200         | No message →  Gets expiry time in miliseconds                      |

**Refresh Lock:**

| Scenarios                                                            | Status Code | Message                                                            |
| -------------------------------------------------------------------- | ----------- | ------------------------------------------------------------------ |
| If X-Authenticated-User-Token is not passed in header                | 401         | Required field token is missing                                    |
| X-device-Id is not passed in header                                  | 400         | X-device-Id is missing in headers                                  |
| Request body is not valid. Eg - resourceId is not passed             | 400         | "resourceId" is required                                           |
| Trying to refresh lock which is not locked                           | 400         | Resource is not locked                                             |
| Trying to refresh a content which is locked by different user        | 400         | You are not authorized to refresh this resource                    |
| If resource id is not valid                                          | 412         | Content not found with id: \{{resourceId\}}                        |
| If content is not in draft state                                     | 412         | The operation cannot be completed as content is not in draft state |
| If user is not a creator or collaborator of the requested resourceId | 412         | You are not authorized                                             |
| If fetching content details failed while refresing lock              | 412         | Unable to fetch content details                                    |
| If refresh lock API fails                                            | 500         | Refreshing lock failed                                             |
| If refreshing lock is successful                                     | 200         | No message →  Gets expiry time in miliseconds                      |

**Retire Lock:**

| Scenarios                                                            | Status Code | Message                                                            |
| -------------------------------------------------------------------- | ----------- | ------------------------------------------------------------------ |
| If X-Authenticated-User-Token is not passed in header                | 401         | Required field token is missing                                    |
| X-device-Id is not passed in header                                  | 400         | X-device-Id is missing in headers                                  |
| Request body is not valid. Eg - resourceId is not passed             | 400         | "resourceId" is required                                           |
| Trying to retire lock which is not locked                            | 400         | Resource is not locked                                             |
| Trying to retire a content which is locked by different user         | 400         | You are not authorized to retire this resource                     |
| If resource id is not valid                                          | 412         | Content not found with id: \{{resourceId\}}                        |
| If content is not in draft state                                     | 412         | The operation cannot be completed as content is not in draft state |
| If user is not a creator or collaborator of the requested resourceId | 412         | You are not authorized                                             |
| If fetching content details failed while retiring lock               | 412         | Unable to fetch content details                                    |
| If refresh lock API fails                                            | 500         | Retiring lock failed                                               |
| If retiring lock is successful                                       | 200         | No message                                                         |

**List Lock:**

| Scenarios                                                    | Status Code | Message                           |
| ------------------------------------------------------------ | ----------- | --------------------------------- |
| X-device-Id is not passed in header                          | 400         | X-device-Id is missing in headers |
| Request body is not valid. Eg - resourceId is not passed     | 400         | "resourceId" is required          |
| If list lock API fails                                       | 500         | Listing lock failed               |
| If listing lock is successful with valid resourceId in param | 200         | No message →                      |

1. Inside result there will be count which will be 1
2. data array with all details

\| | If listing lock is successful without any valid resourceId in param | 200 | No message →

1. Inside result there will be count which will be total number of locked contents
2. data array with all details

|

***

\[\[category.storage-team]] \[\[category.confluence]]

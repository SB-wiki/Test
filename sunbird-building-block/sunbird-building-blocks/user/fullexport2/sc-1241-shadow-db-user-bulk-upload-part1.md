# SC-1241-Shadow-DB---User-Bulk-Upload---part1

### \*

* [Solution :](sc-1241-shadow-db-user-bulk-upload-part1.md#solution-:)
  * [Approach 1:](sc-1241-shadow-db-user-bulk-upload-part1.md#approach-1:)
  * [Approach 2:](sc-1241-shadow-db-user-bulk-upload-part1.md#approach-2:)
* [Workflow:](sc-1241-shadow-db-user-bulk-upload-part1.md#workflow:)
* [Table details:](sc-1241-shadow-db-user-bulk-upload-part1.md#table-details:)
  * [Shadow table schema](sc-1241-shadow-db-user-bulk-upload-part1.md#shadow-table-schema)
* [API](sc-1241-shadow-db-user-bulk-upload-part1.md#api)
* [Kafka event data](sc-1241-shadow-db-user-bulk-upload-part1.md#kafka-event-data)
* [Pseudocode:](sc-1241-shadow-db-user-bulk-upload-part1.md#pseudocode:)
* [Bulk insertion:](sc-1241-shadow-db-user-bulk-upload-part1.md#bulk-insertion:)
* [Open questions:](sc-1241-shadow-db-user-bulk-upload-part1.md#open-questions:) Problem Statement: User data will be uploaded by state admin into a placeholder, we call it shadow DB. Now, each custodian org user identifier (email, phone) need to be matched with shadow db. Only if a match is found, then that user will be moved from custodian to state org. Ref: [SC-1241 System JIRA](https://browse/SC-1241)

### Solution :

#### Approach 1:

State admin will uplaod csv file, which will have all mandatory and optional parameter. System will do Validation of all mandatory attributes, if any mandatory attribute missing then system will throw upload error.

&#x20; Work flow :

&#x20;             \* Upload csv file

&#x20;             \* Do file basic validation (All mandatory parameter shold present, No duplicate identifier )

&#x20;             \* If any validation fails , system will throw error

&#x20;             \*  org external id validation will happen from elasticsearch before stroing data into bulk\_upload\_table

&#x20;             \* if all basic validation pass then system will store this file inside "bulk\_uplod\_process" table.

&#x20;             \* User will get operation Id in response to check upload status later.&#x20;

&#x20;             \* Now background actor will invoke to process uploaded data.

&#x20;             \* If it's new records then data will be inserted (If user externalid and state combination does not exist)

&#x20;             \* if it's old records and not claimed yet then overwrite it,else just update roles and org externalid

&#x20;             \*  Same records will be inserted into Elasticsearch as well.    &#x20;

&#x20;            \* Generate telemetry for bulk upload peocess which will indicate , uploaded rootOrg, no of records , time take to uplolad

&#x20;            \* Generate telemetry for each individual migrated user from shadow to user table.                                  &#x20;

#### Approach 2:

&#x20;File will be uploaded by user and system will do all basic validation of data. Incase validation fail system will throw error message, if validation passess then system will add record insdie bulk upload process table as a single row and it will push data into Kafka topic as well. We will write a Samza job that will listen to that topic and then process each records to save into DB. To save records learner service will expose an endpoint. Samza job will have retry logic in case of failure.

### Workflow:

There are 3 distinct stages in this:

Stage 1 - (sync) - CSV upload passes after syntax and duplicate checks. We must allow at least 15000 rows in a single CSV.

Stage 2 - (background) - CSV uploaded in stage 1 expands into shadow DB.Stage 3 - (backgound) - Changes done to shadow DB gets into DIKSHA DB.

![](<../../../../User/Fullexport2/images/storage/UserUpload (1).png>)

### Table details:

| Column                                             | type | description​​​​     |
| -------------------------------------------------- | ---- | ------------------- |
| id                                                 | text | identifier of table |
| data                                               | text | Complete csv data   |
| objectType                                         | text | user/org            |
| organisationId                                     | text | root org id         |
| ...plus refer to other columns in the schema below |      |                     |

```js
    id text PRIMARY KEY,
    createdby text,
    createdon timestamp,
    data text,
    failureresult text,
    lastupdatedon timestamp,
    objecttype text,
    organisationid text,
    processendtime text,
    processstarttime text,
    retrycount int,
    status int,
    storagedetails text,
    successresult text,
    taskcount int,
    uploadedby text,
    uploadeddate text


```

&#x20;&#x20;

#### Shadow table schema

|             | Type      | Description                                           |
| ----------- | --------- | ----------------------------------------------------- |
| id          | text      | table identifier as uuid                              |
| processId   | text      | identifier of bulk upload process table               |
| name        | text      | name of user                                          |
| email       | text      | user email                                            |
| phone       | text      | user phone                                            |
| channel     | text      | channel value                                         |
| orgExtId    | text      | org external identifier                               |
| userExtId   | text      | user external identifier                              |
| userStatus  | int       | 0-inactive , 1-active                                 |
| claimStatus | int       | 0-unclaimed,1-claimed,2-rejected,3-failed             |
| createdOn   | timestamp |                                                       |
| updatedOn   | timestamp |                                                       |
| claimedOn   | timestamp |                                                       |
| roles       | list      |                                                       |
| userId      | text      | identifier of claimed userId                          |
| userids     | list      | if provided user details matched with previous users. |
| addedBy     | string    | admin user id                                         |

### API

```js
1. Upload api: This api will be used to upload user csv file

curl -X POST \
  {baseUrl}/api/user/v1/upload \
  -H 'Authorization: Bearer {apiKey}' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -H 'x-authenticated-user-token: {userToken}' \
  -F shadowUser=@filePath

  Response: 
       * It will return processId in case success upload
       * Error response incase of file having data issue or file format issue 


2. Get upload data response based on processId:

curl -X GET \
   {baseUrl}/api/data/v1/upload/status/01265966274361753676 \
  -H 'Accept: application/json' \
  -H 'Authorization: Bearer {apiKey}' \
  -H 'Content-Type: application/json' \
  -H 'x-authenticated-user-token: {userToken}'

This will provide list of upload user status and details.

3. Api to add individual user from csv to db. This api is required if we are taking Samza job path.
Method: POST
URL: {baseUrl}/private/user/v1/add
Request body:
   {
        "request": {
         "userList" : [
        {
        "firstName": "name of user",
        "email": "useremail",
        "phone" : "userPhone"
        "state" : "user state,mostly it will be channel value",
        "orgExtId":"org external id",
        "userExtId" : "user external id",
        "status": "active/inactive",
        "roles": ["role1","role2"]
        }
        ]
    }
}

```

### Kafka event data

```js
{
  "actor": {
    "id": "User bulk upload",    //id of the actor
    "type": "System"
  },
  "eid": "BE_JOB_REQUEST",
  "edata": {
    "action": "user_bulk_upload_request",  //action name to check (Mandatory field)
    "data": "complete csv data in json format",        
    "iteration": 2
  },
  "ets": 1564144562948, //system time-stamp
  "context": {
    "pdata": {
      "ver": "1.0",
      "id": "org.sunbird.platform"
    }
  },
  "mid": "LP.1564144562948.0deae013-378e-4d3b-ac16-237e3fc6149a"//producer.system-time-stamp.uuid
  "object": {
    "id": "hash(completeData)",            //hash of string
    "type": "userBulkUplaod"
  }
}
```

### Pseudocode:

User migration will happen from custodian org to state org only. This will be triggered by a Quartz job every day at 01:00 Hours whose logic is as follows.

```
For all records of the shadow DB whose updatedOn timestamp is less than 24 hours, do the following:



Case: 'unclaimed' and 'active' :
```

*

```
Search for this phone or email in ElasticSearch against user index
```

```js
"request": {
    "filters":
     { 
      "$or": {
         "email":"eamil",
         "phone" : "phone"
       }, 
       "rootOrgId":"custodianId"
     }
}

```

```
```

*

```
Case A: No records found, do nothing.
```

*

```
Case B: Found exactly 1 record, migrate the following user details
```

```
* 
```

```
Update user table (channel, rootOrgId, updatedDate, email and phone ,maskemail, maskPhone, userType)
```

```
* 
```

```
Update user-org table: Fetch old entry and remove from db. Add new user org association based on passed channel and org externalid and roles
```

```
* 
```

```
Add records in usr-external-identity 
```

```
* 
```

```
User data need to be sync will elasticsearch
```

```
* 
```

```
update shadow db record status as 'claimed' and userId and claimedOn
```

```
```

*

```
Case C: Found more than one record, report failure on this entry. Can happen only when phone and email are used by 2 different persons. Very less likely.
```

```
Case 'claimed':
```

*

```
Status is "inactive":
```

```
* 
```

```
get userId from record, update userStatus as inactive.
```

```
* 
```

```
if no userId is found (very very less chance, like the user is 'deleted'), then do nothing.
```

*

```
Status is "active".
```

```
* 
```

```
Update roles, sub org id, name . DO NOT UPDATE PHONE or EMAIL.

    

    

    
```

### Bulk insertion:

&#x20;  During cassandra bulk insertion test we found bulk insert batch size is 250. Cassandra is throwing execption as " **Batch too large** " , incase batch size is more.  We bulk insertion in Sync and Async both mode.

&#x20; Table was not having any records. Testing is done on local system with java main method.&#x20;

```java
public Response batchInsertAsyn(
      String keyspaceName, String tableName, List<Map<String, Object>> records) {
    long startTime = System.currentTimeMillis();
    System.out.println("Batch process start time==="+startTime);
		/*
		 * ProjectLogger.log( "Cassandra Service batchInsert method started at ==" +
		 * startTime, LoggerEnum.INFO);
		 */    
    
    Session session = connectionManager.getSession(keyspaceName);
    Response response = new Response();
    BatchStatement batchStatement = new BatchStatement(Type.UNLOGGED);

    try {
      for (Map<String, Object> map : records) {
        Insert insert = QueryBuilder.insertInto(keyspaceName, tableName);
        map.entrySet()
            .stream()
            .forEach(
                x -> {
                  insert.value(x.getKey(), x.getValue());
                });
        batchStatement.add(insert);
      }
      
			  ResultSetFuture futureResult = session.executeAsync(batchStatement);
			  Futures.addCallback(futureResult, new FutureCallback<ResultSet>() {
			  
			  @Override public void onSuccess(ResultSet result) {
			  System.out.println("Complete response===" +result.all()); }
			  
			  @Override public void onFailure(Throwable t) {
			  System.out.println("Exception =="+t.getMessage()); } },
			  MoreExecutors.newDirectExecutorService());
			 
			 
      response.put(Constants.RESPONSE, Constants.SUCCESS);
    } catch (QueryExecutionException
        | QueryValidationException
        | NoHostAvailableException
        | IllegalStateException e) {
      ProjectLogger.log("Cassandra Batch Insert Failed." + e.getMessage(), e);
      throw new ProjectCommonException(
          ResponseCode.SERVER_ERROR.getErrorCode(),
          ResponseCode.SERVER_ERROR.getErrorMessage(),
          ResponseCode.SERVER_ERROR.getResponseCode());
    }
    //logQueryElapseTime("batchInsert", startTime);
    System.out.println("Batch process end time==="+(System.currentTimeMillis()-startTime));
    return response;
  }
```

&#x20;  \* value set inside cassandra.yml as follow:  batch\_size\_fail\_threshold\_in\_kb:50

| Records | Mode  | Time in millis              |
| ------- | ----- | --------------------------- |
| 250     | Sync  | run1-19,run2-24,run3-23     |
| 250     | Async | run1-6,run2-7,run3-6,run4-9 |

Behaviour of Async insertion is same in  **UNLOGGER** and **LOGGED** mode. LOGGED batches are atomic but UNLOGGED batches are not atomic.

We can use Async batch insertion for shadow user upload.On server we can keep batch size limit as 150-200.

* same test run in a loop then found average time is 7 ms.

&#x20; PART2 IMPLEMETATION: \[\[SC-1243 ShadowUser Choice Based Migration|SC-1243-ShadowUser-Choice-Based-Migration]]

### Open questions:

* DO we need to support both csv and excel or only CSV? Only CSV. PRD to reflect that.
* In 2.4.0, user migration from custodian to state will happen on request basis means . Some one need to ask that end point to do that or can it be scheduler job that will run every day mid night? Nightly job
* If state is uploading user data and in that some user is already migrated then how system should work? Ignore. Can't end up revoking the already tagged users.
* State will be name of state or state code or state id (created inside sunbird)
* Ext org id : it will be org external id not org id?
* if uploaded user account is inactive and it's identity found is custodian org then what need to be done?&#x20;
* if uploaded user account is inactive and it's identity found in state tanent then what need to be done?
* Max number of records supported per file upload? 2000. See PRD.
* Expected load on this api? One call per org. If there is already one processing happening, we can choose to ignore/disallow another upload. Can be controlled in UI.
* Can one CSV have multiple rootOrg user data? No, it must not&#x20;
* During upload if email/phone/user ext id, any one or all of them are same for more than one user then how system should behaviour? Pre-validation should fail and no further work is necessary.
* Importance of uploading inactive user account? And what will happen when some active custodian user account match with inactive row of shadow db?
* if shadow db having email and phone and custodian account having only phone then do we need to update email as well during migration - Yes
* same as email match - ditto
* if shadow db having email and phone and email is found is one custodian account and phone in another custodian account then how will it work? Indeterministic result. Whosoever stakes a claim first will get the custodian account migrated.
* Can we get to know when exactly same records need not be reprocess? if we are not going to put this logic then after some will have huge number of records to process and that can result performance issue.
* &#x20;Will all uploaded user type be teacher?&#x20;

&#x20; &#x20;

&#x20;   &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

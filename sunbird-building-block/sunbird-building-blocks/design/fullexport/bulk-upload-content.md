# Bulk-Upload---Content

Problem StatementRelated Jira Task - [SB-12164 System JIRA](https://browse/SB-12164)

1. Bulk Content Upload is to be supported in Sunbird, with 3 operation modes
2. API to be made available to check the real-time status of the bulk content upload process
3. API to be made available to list the statuses of processes initiated by an user

| operation-mode | workflow                                              |
| -------------- | ----------------------------------------------------- |
| upload         | create-upload content                                 |
| publish        | create-upload-publish content                         |
| link           | create-upload-publish content and link it to textbook |

Design **1. Validations** File related validations to be done are,

1. Validate the format of the file
2. Validate whether the file is readable
3. Validate whether the file has data

Data related validations to be done are,

1. Check whether the file is conforming to the bulk content upload template(The template should be configurable)
2. Number of rows in file should be less than Max rows allowed(configuration)
3. Duplicity check within the file. Key is **Taxonomy(BGMS)+ContentName**

**2. Synchronous Processing**

1. Upload the CSV file to blob storage

&#x20;     2\. Make an entry in bulk\_upload\_process table

| column           | data to insert            | remarks                                                                                                 |
| ---------------- | ------------------------- | ------------------------------------------------------------------------------------------------------- |
| id               | auto-generated unique id  | **processId**                                                                                           |
| createdby        | uploader id               |                                                                                                         |
| createdon        | current timestamp         |                                                                                                         |
| data             | blobstore url of CSV file |                                                                                                         |
| failureresult    |                           | **failedCount**  to be updated here                                                                     |
| lastupdatedon    |                           | last updated timestamp to be updated here on each update                                                |
| objecttype       | content                   |                                                                                                         |
| organisationid   | tenant id                 |                                                                                                         |
| processendtime   |                           | **endTime** - current timestamp to be inserted here while moving this process to **completed** state    |
| processstarttime |                           | **startTime** - current timestamp to be inserted here while moving this process to **processing** state |
| retrycount       | 0                         | Not used                                                                                                |
| status           | queued                    | **status** - possible values - **queued, processing, completed**                                        |
| storagedetails   |                           | **report** - blobstore url of result file                                                               |
| successresult    |                           | **successCount**  to be updated here                                                                    |
| taskcount        | number of records in file | **totalCount**                                                                                          |
| uploadedby       | uploader id               |                                                                                                         |
| uploadeddate     | current timestamp         |                                                                                                         |

3. Make entries into bulk\_upload\_process\_task table (One record per content)

| column        | data to insert             | remarks                                                  |
| ------------- | -------------------------- | -------------------------------------------------------- |
| processid     | processid                  | id from master table                                     |
| sequenceid    | auto-generated sequence id |                                                          |
| createdon     | current timestamp          |                                                          |
| data          | data in JSON format        |                                                          |
| failureresult |                            | JSON data + failed message                               |
| iterationid   | 0                          | Not used                                                 |
| lastupdatedon |                            | last updated timestamp to be updated here on each update |
| status        |                            | possible values - **queued** ,  **success** , **failed** |
| successresult |                            | JSON data + success message                              |

4. For LINK operation-mode, get draft hierarchy of Textbooks mentioned in CSV and cache the dialCode-TextBookUnitDoId mapping in Redis
5. Push events to Kafka with Textbook Id as partition key for LINK operation-mode. Use hashed-value generated during duplicity check as partition key for other operation modes.

![](<../../../../Design/FullExport/images/storage/Untitled Diagram.png>)

**3. Asynchronous Processing - Samza**

1. Validation of mandatory fields
2. Validate DIAL code (first against redis-cache, if not present, get draft hierarchy from cassandra and validate)
3. Validate the file size and file format in Google Drive
4. Validate the Taxonomy by creating the content - Hit the REST API
5. Download the AppIcon from Google Drive
6. Create an asset with downloaded image
7. Update content with AppIcon image URL
8. Download content file from Google Drive
9. Upload content - Hit the REST API
10. Publish the content - Hit the Java API
11. Get draft hierarchy of the TextBook from Cassandra
12. Get the metadata of the published content
13. Update the draft hierarchy of the TextBook in Cassandra
14. Update the status back to LMS Cassandra- bulk\_upload\_process\_task table
15. Retire the Content in case of any exception in the flow

**4. Scheduler**

1. Scheduler to run in periodic intervals to consolidate the result from **bulk\_upload\_process\_task** table and update the master table( **bulk\_upload\_process** ) with success\_count, failed\_count, process\_end\_time, result\_file\_url and status
2. While a process is being marked as completed, the result file has to be generated, uploaded to blobstore and URL updated back to  \*\*bulk\_upload\_process \*\* table

**5. Status Check API**

1. Data from bulk\_upload\_process table to be served based on the processId

**6. Status List API**

1. The userId of the user should be deduced from keycloak access token passed in the header.
2. Statuses of all uploads done by the user has to be served from the bulk\_upload\_process tables

API Specifications \*\*Bulk Content Upload API - \*\* POST - /v1/textbook/content/bulk/upload

**Request Headers**

\| Content-Type | multipart/form-data | | Authorization | Bearer \{{api-key\}} | | x-authenticated-user-token | \{{keycloak-token\}} | | x-channel-id | \{{channel-identifier\}} | | x-framework-id | \{{framework-identifier\}} | | x-hashtag-id | \{{tenant-id\}} | | operation-mode | upload/publish/link |

**Request Body**

```
content: [contentUploadFile.csv]] ]></ac:plain-text-body></ac:structured-macro><p><br /></p><p class="auto-cursor-target"><strong>Response : Success Response - OK (<strong>200</strong>)</strong></p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="a7047371-5719-42a7-b136-cd0d7e64edc2"><ac:plain-text-body><![CDATA[{
    "id": "api.textbook.content.bulk.upload",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "processId": "012813442982903808142"
    }
}
```

**Response : Failure Response - BAD REQUEST (400) - Corrupt File**

```
{
    "id": "api.textbook.content.bulk.upload",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": "CORRUPT_FILE",
        "status": "CORRUPT_FILE",
        "errmsg": "Bulk content upload failed due to corrupt file"
    },
    "responseCode": "CLIENT_ERROR",
    "result": { }
}
```

**Response : Failure Response - BAD REQUEST (400) - Invalid File Format(Only CSV files are supported)**

```
{
    "id": "api.textbook.content.bulk.upload",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": "INVALID_FILE_FORMAT",
        "status": "INVALID_FILE_FORMAT",
        "errmsg": "Bulk content upload failed due to invalid file format"
    },
    "responseCode": "CLIENT_ERROR",
    "result": { }
}
```

**Response : Failure Response - BAD REQUEST (400) - Invalid File Template (Columns Missing)**

```
{
    "id": "api.textbook.content.bulk.upload",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": "INVALID_FILE_TEMPLATE",
        "status": "INVALID_FILE_TEMPLATE",
        "errmsg": "Bulk content upload failed due to invalid file template"
    },
    "responseCode": "CLIENT_ERROR",
    "result": { }
}
```

**Response : Failure Response - BAD REQUEST (400) - Too many rows**

```
{
    "id": "api.textbook.content.bulk.upload",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": "MAX_ROW_COUNT_EXCEEDED",
        "status": "MAX_ROW_COUNT_EXCEEDED",
        "errmsg": "Max row count allowed is <config>"
    },
    "responseCode": "CLIENT_ERROR",
    "result": { }
}
```

\*\*Bulk Content Upload Status Check API - \*\* GET - /v1/textbook/content/bulk/upload/status/:processId

**Request Headers**

\| Accept | application/json | | Authorization | Bearer \{{api-key\}} | | x-authenticated-user-token | \{{keycloak-token\}} |

**Response : Success Response - OK (200) - In Queue**

```
{
    "id": "api.textbook.content.bulk.upload.status",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "processId": "012813442982903808142",
		"status": "Queued",
		"totalCount": 500
    }
}
```

**Response : Success Response - OK (200) - In Progress**

```
{
    "id": "api.textbook.content.bulk.upload.status",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "processId": "012813442982903808142",
		"status": "Processing",
		"totalCount": 500,
		"successCount": 100,
		"failedCount": 10,
		"startTime": "2019-07-26 11:28:42:315+0000"
    }
}
```

**Response : Success Response - OK (200) - Completed**

```
{
    "id": "api.textbook.content.bulk.upload.status",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "processId": "012813442982903808142",
		"status": "Completed",
		"totalCount": 500,
		"successCount": 450,
		"failedCount": 50,
		"startTime": "2019-07-26 11:28:42:315+0000"
		"endTime": "2019-07-26 12:28:42:315+0000",
		"report": "signedDownloadUrl"
    }
}
```

**Response : Failure Response - RESOURSE NOT FOUND (404) - ProcessId not found**

```
{
    "id": "api.textbook.content.bulk.upload.status",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": "PROCESS_NOT_FOUND",
        "status": "PROCESS_NOT_FOUND",
        "errmsg": "Process Id xxx is not found in the system"
    },
    "responseCode": "RESOURCE_NOT_FOUND",
    "result": { }
}
```

\*\*Bulk Content Upload Status List API - \*\* GET - /v1/textbook/content/bulk/upload/status/list

**Request Headers**

\| Accept | application/json | | Authorization | Bearer \{{api-key\}} | | x-authenticated-user-token | \{{keycloak-token\}} |

**Response : Success Response - OK (200)**

```
{
    "id": "api.textbook.content.bulk.upload.status.list",
    "ver": "v1",
    "ts": "2019-07-26 11:28:42:315+0000",
    "params": {
        "resmsgid": null,
        "msgid": "cf5b2e8e-70cf-401c-af29-980bc3151c67",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
		"userId": "f61826aa-8e5d-4356-b8ad-edda92460750",
		"uploads": [
			{
				"processId": "012813442982903808142",
				"uploadedDate": "2018-12-12 14:25:27:466+0530",
				"status": "Completed"
			},
			{
				"processId": "012813442982903808143",
				"uploadedDate": "2018-12-14 12:01:36:807+0530",
				"status": "Processing"
			}
		]
    }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]

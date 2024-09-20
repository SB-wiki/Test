# Cassandra-Approach-for-PII-data

The objective of this document is to explain the PII User Data Report via Cassandra Approach in the Program Dashboard CSV

**Jira Ticket:**

[https://project-sunbird.atlassian.net/browse/LR-285](https://project-sunbird.atlassian.net/browse/LR-285)[https://project-sunbird.atlassian.net/browse/ED-543](https://project-sunbird.atlassian.net/browse/ED-543)

**Github Discussion Forum:**

[https://github.com/Sunbird-Lern/Community/discussions/58](https://github.com/Sunbird-Lern/Community/discussions/58)[https://github.com/Sunbird-Lern/Community/discussions/54](https://github.com/Sunbird-Lern/Community/discussions/54)

![](<../../../../Analytics/Fullexport/images/storage/Actual Cassandra Arch.drawio.png>)

After capturing the data in the Backend - the data in real-time is streamed using Kafka.

**Schema of the Kafka Topic:**

**Kafka Topic Name** : \{{envName\}}.ml.programUsers.raw

**Structure :-**

```
{
      programId: {
        type : "ObjectId",
        required : true,
        index: true
      },
      programName: String,
      programExternalId: String,
      noOfResourcesStarted: {
        type:Number,
        index: true
        }
      userId: {
        type: String,
        index: true
      },
      requestForPIIConsent:true/false
      userProfile: Object,
      userRoleInformation: Object,
      appInformation: Object,
      createdAt: Date,
      updatedAt: Date,
      deleted:Boolean
}
```

**Sample JSON Data :-**

```json
{
    "_id" : "63bfa8f173f6368ebde21bbe",
    "deleted" : false,
    "programId" : "5f362b78af0a4decfa9a106f",
    "programName": "$prorgramName",
    "programExternalId": "$programExternalId",
    "requestForPIIConsent":true,
    "userRoleInformation" : {
        "role" : "HM,DEO",
        "state" : "db331a8c-b9e2-45f8-b3c0-7ec1e826b6df",
        "district" : "1dcbc362-ec4c-4559-9081-e0c2864c2931",
        "school" : "c5726207-4f9f-4f45-91f1-3e9e8e84d824"
    },
    "userId" : "ba9aa220-ff1b-4717-b6ea-ace55f04fc16",
    "appInformation" : {
        "appName" : "Diksha",
        "appVersion" : "5.2"
    },
    "userProfile": {
      "userLocations" :[
        {
          "code" : "2822",
          "name" : "ANANTAPUR",
          "id" : "2f76dcf5-e43b-4f71-a3f2-c8f19e1fce03",
          "type" : "district",
          "parentId" : "bc75cc99-9205-463e-a722-5326857838f8"
        },
        {
          "code" : "282262",
          "name" : "AGALI",
          "id" : "966c3be4-c125-467d-aaff-1eb1cd525923",
          "type" : "block",
          "parentId" : "2f76dcf5-e43b-4f71-a3f2-c8f19e1fce03"
        },
        {
          "code" : "28",
          "name" : "Andhra Pradesh",
          "id" : "bc75cc99-9205-463e-a722-5326857838f8",
          "type" : "state",
          "parentId" : null
        },
        {
          "code" : "2822620004",
          "name" : "ZPHS AGALI",
          "id" : "beb0bcf4-d7cd-4a72-8f35-be8e5b03c0d1",
          "type" : "cluster",
          "parentId" : "966c3be4-c125-467d-aaff-1eb1cd525923"
        },
        {
          "code" : "28226200816",
          "name" : "SMT PRAMEELAMMA AND SRI KGA GUPTA EM UP SCHOOL",
          "id" : "01337588247832985613211",
          "type" : "school",
          "parentId" : ""
        }
      ],
      "profileUserTypes": [
        {
           "type": "administrator",
           "subType": "hm"
        },
        {
           "type": "administrator",
           "subType": "crp"
         },
         {
            "type": "administrator",
            "subType": "chm"
         }
       ],
      "framework" : {
        "board" : [ 
          "CBSE"
        ],
        ...
      },
      ...
      "rootOrg":{
      "id": "0126796199493140480",
      "orgName": "Staging Custodian Organization"
      },
    },
    "noOfResourcesStarted": 3,
    "updatedAt" : ISODate("2023-01-12T06:30:56.829Z"),
    "createdAt" : ISODate("2023-01-12T06:30:09.476Z"),
    "__v" : 0
}
```

noteOnly the New programs rolled out after the Join program feature is enabled on the production, those data will flow into the kafka events, old program before the roll out will not be pushed into the events.

Only the New programs rolled out after the Join program feature is enabled on the production, those data will flow into the kafka events, old program before the roll out will not be pushed into the events.

### ML Data-pipeline Real-time Streaming :- Logic -

1. Consume the events from the Kafka topic using **Apache Flink** to perform the real-time streaming.
2. Stream Environment to be created to consume kafka event

```py
implicit val env: StreamExecutionEnvironment = FlinkUtil.getExecutionContext(config)
val source = kafkaConnector.kafkaEventSource[Event](config.kafkaInputTopic)
```

1.  Post that we would Pre-Process/Transform/Manipulate the data which to assign column names, data types and values prior to storing the data in the Cassandra Table.

    _**Logical Execution**_ :

    1. After the stream environment is created - connect to the Kafka topic mentioned above with the Kafka connector.
    2. Required transformation of data
    3. Once done, the following key-value pairs needs to be extracted ( _shown with their data-type_ ):

```
program_id text,
program_externalId text,
program_name text,
pii_consent_required boolean,
user_id text,
user_locations map<text, text>, 
organisation_id text,
organisation_name text,
user_sub_type text,
user_type text,
created_at date,
updated_at date
```

1. Once the value is extracted for the respective event - we would need to connect to the Cassandra table and push the data.
2. Finally, this entire setup needs to be setup as a job to be run in a Kubernetes cluster. Related configurations files will be added that corresponds to this job

_**Exception Handling**_ :

* Exceptions related to Kafka events → ProgramId and userId key missing
* Exceptions related to Cassandra DB → if pushing to DB fails

_**Structure and Repository Understanding:**_

* A new module needs to be created on this [Github Repository](https://github.com/Sunbird-Lern/data-pipeline/tree/release-5.1.0).
* The code structure can be followed using existing Flink job
* The flink-job will be scheduled in the Flink cluster with the Scala flink cluster - using the Job Manager IP address to allow running the job.

The discussion on this can be found here:

[https://github.com/Sunbird-Lern/Community/discussions/58#discussioncomment-4817602](https://github.com/Sunbird-Lern/Community/discussions/58#discussioncomment-4817602)

#### ER diagram :-

![](<../../../../Analytics/Fullexport/images/storage/Cassandra Schema ER Diagram.drawio (1).drawio (1).drawio (1).png>)

#### Cassandra DB Schema :-

*

```
CREATE KEYSPACE IF NOT EXISTS sunbird_programs WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': '1'
 };
```

* **User Program Table Schema** :-

```
CREATE TABLE IF NOT EXISTS sunbird_programs.program_enrollment (
    program_id text,
    program_externalId text,
    program_name text,
    pii_consent_required boolean,
    user_id text,
    user_locations map<text,text>,
    organisation_id text,
    organisation_name text,
    user_sub_type text,
    user_type text,
    created_at date,
    updated_at date,
    PRIMARY KEY (program_id,user_id)
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';
```

**Data Query :-**

1. Query **program\_enrollment** Cassandra Table :-

* select user\_id, program\_externalId, program\_name, user\_locations, user\_type, user\_sub\_type, organisation\_name,pii\_consent\_required from **program\_enrollment** where program\_id=='602512d8e6aefa27d9629bc3'
* check if the requested program id, **pii\_consent\_required** column value in Cassandra is true, if the value is true then only go ahead with below step 2 and 3 queries, if the value is false then store the query result into a csv
*   Dynamically filter out the data based on the job request (PostgreSQL table :- job\_request) in the spark dataframe, if the request contains filter apart from program\_id.

    Ex :- Job request contain these filters apart from program\_id:- District, Block, Organisation

```
spark_dataframe = df.select(user_id,program_externalId,program_name,user_locations, user_type,user_sub_type,organisation_name).where((col("user_locations['district_id']")==="456") && (col("user_locations['block_id']") ==="789") && (col("user_locations.org_id")=="abc"))
```

Dynamic filtering will be at the data frame level based on the job request after getting the data from Cassandra with the mandatory field i,e program\_id

2. Query **user\_consent** Cassandra Table :-

select user\_id, status, last\_updated\_on from **user\_consent where** object\_id == '602512d8e6aefa27d9629bc3'(program id) **;**

Filter the dataframe, only if consentflag == True ( status == "active" ) and go ahead with below step 3 query

3. Query **user** Redis cache Table :-

select email, phone, userName from **user** ;

Store the Result into Spark Dataframe

Join all the above 3 dataframe into a single dataframe and store into data into csv.

**Note :-** CSV to include :-

1. PII Data Like Username, Email and Phone number of the User to be captured as per the current profile data
2. Other Data Like State,District,Block,Cluster,User Type,User Sub Type,Organisation of the user to be captured at the time of joining the program
3. If pii\_consent\_required = false, Remove these below Column’s from the CSV

\| User Name (On user consent) | Mobile number (On user consent) | Email ID (On user consent) | Consent Provided | Consent Provided Date |

4. If pii\_consent\_required = true and consentflag = false, Keep below Column’s in the CSV, but value will be blank

\| User Name (On user consent) | Mobile number (On user consent) | Email ID (On user consent) | Consent Provided | Consent Provided Date |

5. If pii\_consent\_required = true and consentflag = true, Keep below Column’s in the CSV, but value will be present

\| User Name (On user consent) | Mobile number (On user consent) | Email ID (On user consent) | Consent Provided | Consent Provided Date |

#### Program User Custom Data-product :-

![](<../../../../Analytics/Fullexport/images/storage/Untitled Diagram.drawio (1).png>) **Schedular for the Scala Data Product Jobs :** -

[https://github.com/Sunbird-Obsrv/sunbird-data-pipeline/blob/release-5.1.0/ansible/roles/data-products-deploy/templates/model-config.j2#L138-L141](https://github.com/Sunbird-Obsrv/sunbird-data-pipeline/blob/release-5.1.0/ansible/roles/data-products-deploy/templates/model-config.j2#L138-L141)

*   **Model/Job Config :-**

    1. Execution of the data product in the server will be done by updating the config in the model-config.j2 file for the program-user-exhaust data product

    Similar to this userinfo-exhaust data product:- [https://github.com/Sunbird-Obsrv/sunbird-data-pipeline/blob/release-5.1.0/ansible/roles/data-products-deploy/templates/model-config.j2#L65](https://github.com/Sunbird-Obsrv/sunbird-data-pipeline/blob/release-5.1.0/ansible/roles/data-products-deploy/templates/model-config.j2#L65)

```
"program-user-exhaust")
		echo '{
  "search": {
    "type": "none"
  },
  "model": "org.sunbird.ml.exhaust.ProgramUserInfoExhaustJob",
  "modelParams": {
    "store": "local",
    "mode": "OnDemand",
    "authorizedRoles": [
      "PROGRAM_MANAGER"
    ],
    "id": "ml-program-user-exhaust",
    "keyspace_name": "sunbird_programs",
    "table": [
      {
        "columns": [
          "user_id",
          "program_name",
          "program_externalId",
          "user_locations",
          "user_type",
          "user_sub_type",
          "organisation_name",
          "pii_consent_required"
        ],
        "name": "program_enrollment",
        "user_locations_columns": [
          "state_name",
          "district_name",
          "block_name",
          "cluster_name",
          "school_code",
          "school_name"
        ]
      },
      {
        "name": "user",
        "columns": [
          "userid",
          "firstname",
          "lastname",
          "email",
          "phone",
          "username"
        ],
        "encrypted_columns": [
          "email",
          "phone"
        ],
        "final_columns": [
          "email",
          "phone",
          "username"
        ]
      }
    ],
    "label_mapping": {
      "user_id": "User UUID",
      "username": "User Name(On user consent)",
      "phone": "Mobile number(On user consent)",
      "email": "Email ID(On user consent)",
      "consentflag": "Consent Provided",
      "consentprovideddate": "Consent Provided Date",
      "program_name": "Program Name",
      "program_externalId": "Program ID",
      "state_name": "State",
      "district_name": "District",
      "block_name": "Block",
      "cluster_name": "Cluster",
      "school_code": "School Id",
      "school_name": "School Name",
      "user_type": "Usertype",
      "user_sub_type": "Usersubtype",
      "organisation_name": "Org Name"
    },
    "order_of_csv_column": [
      "User UUID",
      "User Name(On user consent)",
      "Mobile number(On user consent)",
      "Email ID(On user consent)",
      "Consent Provided",
      "Consent Provided Date",
      "Program Name",
      "Program ID",
      "State",
      "District",
      "Block",
      "Cluster",
      "School Id",
      "School Name",
      "Usertype",
      "Usersubtype",
      "Org Name"
    ],
    "sort": [
      "District",
      "Block",
      "Cluster",
      "School Id",
      "User UUID"
    ],
    "quote_column": [
      "User Name(On user consent)",
      "Program Name"
    ],
    "sparkElasticsearchConnectionHost": "localhost",
    "sparkRedisConnectionHost": "localhost",
    "sparkUserDbRedisIndex": "0",
    "sparkCassandraConnectionHost": "localhost",
    "sparkUserDbRedisPort": 6381,
    "fromDate": "",
    "toDate": "",
    "key": "ml_reports/",
    "format": "csv"
  },
  "output": [
    {
      "to": "file",
      "params": {
        "file": "ml_reports/"
      }
    }
  ],
  "parallelization": 8,
  "appName": "Program UserInfo Exhaust"
}' 
;;
```

2. In the Local Testing, Model Config will be updated at the time of writing the test case :-

```
val strConfig = """{"search":{"type":"none"},"model":"org.sunbird.ml.exhaust.ProgramUserInfoExhaustJob","modelParams":{"store":"local","mode":"OnDemand","authorizedRoles":["PROGRAM_MANAGER"],"id":"program-user-exhaust","keyspace_name":"sunbird_programs","table":[{"name":"program_enrollment","columns":["user_id","program_name","program_externalId","user_locations","user_type","user_sub_type","organisation_name","pii_consent_required"],"user_locations_columns":["state_name","district_name","block_name","cluster_name","school_code","school_name"]},{"name":"user_consent","columns":["user_id","status","last_updated_on"]},{"name":"user","columns":["userid","firstname","lastname","email","phone","username"],"encrypted_columns":["email","phone"],"final_columns":["email","phone","username"]}],"label_mapping":{"user_id":"User UUID","username":"User Name(On user consent)","phone":"Mobile number(On user consent)","email":"Email ID(On user consent)","consentflag":"Consent Provided","consentprovideddate":"Consent Provided Date","program_name":"Program Name","program_externalId":"Program ID","state_name":"State","district_name":"District","block_name":"Block","cluster_name":"Cluster","school_code":"School Id","school_name":"School Name","user_type":"Usertype","user_sub_type":"Usersubtype","organisation_name":"Org Name"},"order_of_csv_column":["User UUID","User Name(On user consent)","Mobile number(On user consent)","Email ID(On user consent)","Consent Provided","Consent Provided Date","Program Name","Program ID","State","District","Block","Cluster","School Id","School Name","Usertype","Usersubtype","Org Name"],"sort":["District","Block","Cluster","School Id","User UUID"],"quote_column":["User Name(On user consent)","Program Name"],"sparkElasticsearchConnectionHost":"localhost","sparkRedisConnectionHost":"localhost","sparkUserDbRedisIndex":"0","sparkCassandraConnectionHost":"localhost","sparkUserDbRedisPort":6381,"fromDate":"","toDate":"","key":"ml_reports/","format":"csv"},"output":[{"to":"file","params":{"file":"ml_reports/"}}],"parallelization":8,"appName":"Program UserInfo Exhaust"}"""
    
val jobConfig = JSONUtils.deserialize[JobConfig](strConfig)
```

Few Transformation and Manipulation logic need to be handled :-

* Label Mapping
* Column Ordering
* Sorting the data based on the given sort columns
* **Filter Format from UI :-**

```
{
  "program": [
    {
      "name": "User Detail Report",
      "encrypt": true,
      "id": "program-user-exhaust",
      "roles": [
        "PROGRAM_MANAGER"
      ],
      "filters": [
        {
          "table_name": "program_enrollment",
          "table_filters": [
            {
              "name": "program_id",
              "operator": "=",
              "value": "602512d8e6aefa27d9629bc3"
            },
            {
              "name": "user_locations['state_id']",
              "operator": "=",
              "value": "6d884bb0-307f-4f83-abfe-fc21bbd36abb"
            },
            {
              "name": "user_locations['district_id']",
              "operator": "=",
              "value": "ed9e0963-0707-443a-99c4-5994fcac7a5f"
            },
            {
              "name": "organisation_id",
              "operator": "=",
              "value": "0126796199493140480"
            },
            {
              "name": "updated_at",
              "operator": ">=",
              "value": "YYYY-MM-DD"
            },
            {
              "name": "updated_at",
              "operator": "<=",
              "value": "YYYY-MM-DD"
            }
          ]
        },
        {
          "table_name": "user_consent",
          "table_filters": [
            {
              "name": "object_id",
              "operator": "=",
              "value": "602512d8e6aefa27d9629bc3"
            }
          ]
        }
      ]
    }
  ]
}
```

**Default Date Format :-** when start and end date not present :-

```
           "startDate":"1901-01-01", "endDate":"2101-01-01"
```

#### Program Dashboard CSV Format :-

[https://docs.google.com/spreadsheets/d/1aipO6Lp9bmB3v\_iHQROM-6FI7ixRlXHdQ8uDtu6cHco/edit#gid=1021328825](https://docs.google.com/spreadsheets/d/1aipO6Lp9bmB3v\_iHQROM-6FI7ixRlXHdQ8uDtu6cHco/edit#gid=1021328825) **Required CSV Columns** :-

```
User UUID
User Name(On user consent)
Mobile number(On user consent)
Email ID(On user consent)
Consent Provided
Consent Provided Date
Program Name
Program ID
State	
District	
Block	
Cluster	
School Id	
School Name	
Usertype	
Usersubtype	
Org Name
```

***

\[\[category.storage-team]] \[\[category.confluence]]

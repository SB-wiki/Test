# \[Design-Brainstorm]---MVC---Content-Reuse

### Introduction

As a Sourcing Org Contributor when I try to Add from Library, I will get the most relevant content. _Most relevant content_ is defined based on the match between My textbook and Textbooks in Library.

1. As a Sourcing Org Contributor, I will get two options against each chapter (unit) in the textbook.
   1. (New) Add from Library
   2. Add New
2. (New) As a Sourcing Org Contributor, I will be able to Add from Library by _Exploring_ and by viewing _Suggestions_ .
3. Add from Library will have two ways: “Explore” (or “Library”) and “Suggestions” (or “Recommended”).
4. (New) As a Sourcing Org Contributor, I will be able to Explore pre-filtered set of textbooks, chapter (topic) wise.
5. (New) As a Sourcing Org Contributor, I will be able to Preview selected content quickly.
6. (New) As a Sourcing Org Contributor, I will Add Selected Content to any chapter (unit) in My Textbook.
7. (New) As a Sourcing Org Contributor, I will be able to view Suggested content, Preview, and Add to the Selected chapter (unit) in My Textbook.

### Problem Statement

1. Explore: When a textbook- TOC is uploaded, for each chapter/ topic, show similar chapter/ topic in other textbook and the content linked to those topics
   1. Based on the filter
   2. Search for Chapter/topics in other textbooks based on textbook nodes as query
2. Suggest: When a textbook- TOC is uploaded, for each chapter/ topic, show 5 MVC Content that can be linked to each chapter/topic
   1. Search for enriched MVC Content based on textbook nodes as query
   2. Search for enriched MVC Content embeddings based on textbook nodes query as embedding

### **MVC Content** &#x20;

1. Create a standard excel format for MVC Content
   1. State
   2. Type  &#x20;
   3. Board \[Important]
   4. Grade \[Important]&#x20;
   5. Subject \[Important]&#x20;
   6. Medium \[Important]&#x20;
   7. Textbook Name \[Important]
   8. Chapter No.&#x20;
   9. Chapter Name (Level 1) \[Important]
   10. Chapter Concept Name (Level 1) \[Important]
   11. Topic Name (Level 2) \[Important]
   12. Topic Concept Name (Level 2) \[Important]
   13. Sub Topic Name (Level 3) \[Important]
   14. Sub Topic Concept Name (Level 3) \[Important]
   15. Source \[Important]
   16. Content URL \[Important]
2. Existing excel data needs to be preprocessed so that standard structure can be achieved.
3. Please note that one Content URL can have multiple entries.
4. If the Content URL is multiple then we need to merge that in the Excel. There should be only one row per content URL.&#x20;
5. There are many cases where the Content URL is not valid so we will have to ignore those entries.
6. Columns Field Values mentioned in the excel will be considered as final and rest of the data will be read from Diksha Content Read API

### Design

![](<../../../../Design/sbdesign-content-td-des/images/storage/Screenshot 2020-06-23 at 9.57.56 AM.png>)

* Using Elasticsearch 7.4 to make use of vector indexing for semantic search.
* Using strict mapping for better performance.

**Implementation Flow**

1. Develop a script which will read the data from google sheets and merge the data into one CSV.
2. mvc-content-create API should handle
   1. Excel (xls)
   2. JSON
3. Develop a new **mvc-content-create API** which will accept the field and values defined in the excel.
   1. Check whether the Content URL is valid or not.
   2. Basis the Content URL, extract Content ID and other properties of the content using Content Read API of Diksha.
   3. Board, Grade, Subject and Medium data will be picked from the excel and not from the Diksha Content and pass the values to Auto Create Event.
   4. Trigger Auto Create Job with some extra parameters in event JSON
   5. textbookname
   6. level1name
   7. level1concept
   8. level2name
   9. level2concept
   10. level3name
   11. level3concept
   12. label (MVC)
   13. source \[Diksha, iDream, ToonMasti etc...]
   14. sourceurl
   15. Auto Create JOB internally calls the Content Create API of Vidyadaan and passes the appropriate request.
   16. Auto Create JOB internally trigger Publish Pipeline of Vidyadaan.
4. Content Create API of Vidyadaan Changes
   1. Change content definition of Neo4J to handle below mentioned additional columns
   2. textbookname
   3. level1name
   4. level1concept
   5. level2name
   6. level2concept
   7. level3name
   8. level3concept
   9. label (MVC)
   10. source \[Diksha, iDream, ToonMasti etc...]
   11. sourceurl
   12. Content Create API will insert this data in Neo4J
5. Publish Pipeline Changes
   1. Publish Pipeline will insert data in vidyadaan content ES with above additional columns.
   2. if the label parameter exists and its value is MVC, it triggers mvc-processor pipeline.
   3. We need to insert below mentioned values in MVC ES and Cassandra
   4. textbookname
   5. level1name
   6. level1concept
   7. level2name
   8. level2concept
   9. level3name
   10. level3concept
   11. label (MVC)
   12. source \[Diksha, iDream, ToonMasti etc...]
   13. sourceurl

#### Elastic Search Index Structure:

**Name:** mvc-content

| **Property**              | **Data Type** | **Tokenization** | **Group**                                          | **Description**                                                                   |
| ------------------------- | ------------- | ---------------- | -------------------------------------------------- | --------------------------------------------------------------------------------- |
| name                      | Text          | Yes              | core - metadata                                    |                                                                                   |
| description               | Text          | Yes              |                                                    |                                                                                   |
| mimeType                  | Text          | No               |                                                    |                                                                                   |
| contentType               | Text          | No               |                                                    |                                                                                   |
| resourceType              | Text          | No               |                                                    |                                                                                   |
| artifactUrl               | Text          | No               |                                                    |                                                                                   |
| streamingUrl              | Text          | No               |                                                    |                                                                                   |
| previewUrl                | Text          | No               |                                                    |                                                                                   |
| downloadUrl               | Text          | No               |                                                    |                                                                                   |
| framework                 | Text          | No               |                                                    |                                                                                   |
| board                     | Text          | Yes              |                                                    |                                                                                   |
| medium                    | Text          | Yes              |                                                    |                                                                                   |
| subject                   | Text          | Yes              |                                                    |                                                                                   |
| gradeLevel                | Text          | Yes              |                                                    |                                                                                   |
| keywords                  | Text          | Yes              |                                                    |                                                                                   |
| source                    | Text          | Yes              | source - metadata                                  | URI of the content. This is the public URI to access the source of the MVC.       |
| ml\_level1Concepts        | Text          | Yes              | ml - metadata                                      |                                                                                   |
| ml\_level2Concepts        | Text          | Yes              |                                                    |                                                                                   |
| ml\_level3Concepts        | Text          | Yes              |                                                    |                                                                                   |
| ml\_contentText           | Text          | Yes              | Text extracted form the pdf, video or ecml Content |                                                                                   |
| ml\_keywords              | Text          | Yes              |                                                    | Keywords identified from ml\_contentText                                          |
| ml\_content\_text\_vector | Dense vector  | No               |                                                    | Vector representation of ml\_contentText and description using pertained ml model |
| label                     | Text          | Yes              |                                                    | Tags that represent the Content. ex: MVC                                          |

#### Content-service

We can use the existing code of Content Search API for MVC Search by following two approaches.

1. Create a new route of MVC reuse in the existing API.
   1. Pros
   2. All the existing utilities and dependencies can be reused.
   3. Manageability becomes easy and both the Search API is part of one project.
   4. Cons
   5. It could impact the performance, though it is very less.
   6. Deployment of Diksha will impact Vidyadaan application as well.
   7. ES version has to be same for both Diksha and Vidyadaan.
2. Create a new API for MVC reuse
   1. Pros
   2. No impact on existing Diksha Search Service
   3. No dependency on Deployment now, as both are separate services.
   4. Latest ES version can be used for Vidyadaan
   5. Cons
   6. Maintainability would be an issue both at Code and DB level.

![](<../../../../Design/sbdesign-content-td-des/images/storage/Screenshot 2020-06-23 at 9.57.56 AM.png>)

**API Spec:**

1. Request:
   1. HTTP Verb: POST
   2. URL: "'[https://dock.sunbirded.org/api/mvc/v3/search'](design-brainstorm-mvc-content-reuse.md)["](https://dock.sunbirded.org/action/mvccomposite/v3/search%22)
   3. Header Parameters
   4. Content-Type: “application/json“
   5. Authorization: “Bearer “
   6. Request Parameters:
   7. mode: soft/hard
   8. filters
   9. softConstraints
   10. vector - search

```
{
  "request": {
    "mode": "explore",
    "filters": {
      "medium": [
        "Telegu"
      ],
      "gradeLevel": [
        "Class 4",
        "Class 5",
        "Class 6"
      ],
      "status": [
        "Live"
      ],
      "textbookName": [
        "Science"
      ],
      "level1Name": [
        "Sorting Materials Into Groups"
      ],
      "level1Concept": [
        "Materials"
      ],
      "level2Name": [
        "Objects Around Us"
      ],
      "level2Concept": [
        "Various Objects"
      ]
    }
  }
}
```

1. Response

```
{
  "id": "ekstep.mvc-composite-search.search",
  "ver": "1.0",
  "ts": "2020-05-21T22:23:43ZZ",
  "params": {
    "resmsgid": "c1658c85-e0a1-41ed-bd9a-72df223f505d",
    "msgid": null,
    "err": null,
    "status": "successful",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    "count": 3,
    "content": [
      {
        "organisation": [
          "Vidya2"
        ],
        "channel": "sunbird",
        "framework": "NCF",
        "board": "State(Tamil Nadu)",
        "subject": "English",
        "medium": [
          "Telegu"
        ],
        "gradeLevel": [
          "Class 4",
          "Class 5",
          "Class 6"
        ],
        "name": "15_April_ETB",
        "description": "Enter description for TextBook",
        "language": [
          "English"
        ],
        "appId": "dev.dock.portal",
        "contentEncoding": "gzip",
        "identifier": "do_113025640118272000173",
        "node_id": 5244,
        "nodeType": "DATA_NODE",
        "mimeType": "application/vnd.ekstep.content-collection",
        "resourceType": "Book",
        "contentType": [
          "TextBook"
        ],
        "objectType": "Content",
        "textbookName": [
          "Science"
        ],
        "level1Name": [
          "Sorting Materials Into Groups"
        ],
        "level1Concept": [
          "Materials"
        ],
        "level2Name": [
          "Objects Around Us"
        ],
        "level2Concept": [
          "Various Objects"
        ]
      }
    ]
  }
}
```

#### ML Workbench api:

Request:

```
POST /daggit/submit
{
	"request":{
		"input":{
			"APP_HOME": "/daggit_home/content_reuse",
			"content":[{
				"subject": "Science",
				"downloadUrl": "https://ntpproductionall.blob.core.windows.net/ntp-content-production/ecar_files/do_312533255910883328118977/muulyvaan-yogdaankrtaa-10th-vijnyaan_1532071348607_do_312533255910883328118977_2.0.ecar",
				"language": ["English"],
				"mimeType": "application/vnd.ekstep.ecml-archive",
				"objectType": "Content",
				"gradeLevel": ["Class 10"],
				"artifactUrl": "https://ntpproductionall.blob.core.windows.net/ntp-content-production/content/do_312533255910883328118977/artifact/1529938853455_do_312533255910883328118977.zip",
				"contentType": "Resource",
				"identifier": "do_312533255910883328118977",
				"graph_id": "domain",
				"nodeType": "DATA_NODE",
				"node_id": 575061}, 
				 {...},...]
		},
		"job":"diksha_content_keyword_tagging"
	}
}
```

Response:

```
api_response = {
        "id": "daggit.api",
        "ver": "v1",
        "ts": "",
        "params": {
            "resmsgid": "null",
            "msgid": "",
            "err": "null",
            "status": "fail",
            "errmsg": "null"
        },
        "responseCode": "OK",
        "result": {
            "status": 200
        }
    }
```

#### Text Vectorisation API:

Request:

```json
port:1729
endpoint: /ml/vector/search
{
	"request":{
		"text":["Class 11 English medium mathematics", "Today we will talk about Photosynthesis"],
		"language": "en",
		"model": "BERT",
		"params": {"dim": 768,"seq_len":25, ....} // optional. Default values configured based on the model
	}
}
```

Response:

```
{
    "id": "api.ml.vector",
    "ets": 1591603456223,
    "params": {
            "resmsgid": "null",
            "msgid": "",
            "err": "null",
            "status": "success",
            "errmsg": "null"
        },
    "result":{
        "action":"get_BERT_embedding",
        "vector": [[-0.34,1.2,.....],[0.5,1.8,.....]]         
    }
}
```

**action = getContentVec**

```
GET /ml/vector/contentText
{
	"request":{
		"text":["Class 11 English medium mathematics", "Today we will talk about Photosynthesis"],
		"language": "en",
		"model": "BERT",
		"params": {"dim": 768,"seq_len":25, ....} // optional. Default values configured based on the model
	}
}
```

```
{
    "eid": "MVC_JOB_PROCESSOR",
    "ets": 1591603456223,
    "mid": "LP.1591603456223.a5d1c6f0-a95e-11ea-b80d-b75468d19fe4",
    "actor": {
      "id": "UPDATE ML CONTENT TEXT VECTOR",
      "type": "System"
    },
    "context": {
      "pdata": {
        "ver": "1.0",
        "id": "org.ekstep.platform"
      },
      "channel": "01285019302823526477"
    },
    "object": {
      "ver": "1.0",
      "id": "do_113036318281465856163"
    },
    "edata":{
        "action": "update-ml-contenttextvector",
        "stage": 3,
        "ml_contentTextVector": [-0.34,1.2,.....]
    }
}
```

## MVC Content Create API

Request:

* **To create MVC content using JSON**

```json
endpoint: /v3/mvccontent/create
{
  "request": {
    "content": [
      {
        "board": "State(Tamil Nadu)",
        "subject": [
          "English"
        ],
        "medium": [
          "Telegu"
        ],
        "gradeLevel": [
          "Class 4",
          "Class 5",
          "Class 6"
        ],
        "textbookName": [
          "Science"
        ],
        "level1Name": [
          "Sorting Materials Into Groups"
        ],
        "level1Concept": [
          "Materials"
        ],
        "level2Name": [
          "Objects Around Us"
        ],
        "level2Concept": [
          "Various Objects"
        ],
        "source": [
          "Diksha 1",
          "TN 1.1"
        ],
        "sourceurl": ["https://diksha.gov.in/play/content/do_31283180221267968012331"]
      }
    ]
  }
}
```

* **To create MVC content using Excel**

```
curl --location --request POST '/v3/mvccontent/create' \
--form 'File=@{{LOCATION OF FILE}}/{{NAME OF FILE}}.xlsx'
```

Response:

```
{
    "id": ektep.mvc.content.create,
    "ver": "3.0",
    "ts": null,
    "params": {
        "resmsgid": null,
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {}
}
```

### MVC Processor Samza Job - Event JSON

**Stage 1: This job will get triggered from the Publish pipeline, if the Label is “MVC“**

```
{
    "eid": "MVC_JOB_PROCESSOR",
    "ets": 1591603456223,
    "mid": "LP.1591603456223.a5d1c6f0-a95e-11ea-b80d-b75468d19fe4",
    "actor": {
      "id": "UPDATE ES INDEX",
      "type": "System"
    },
    "context": {
      "pdata": {
        "ver": "1.0",
        "id": "org.ekstep.platform"
      },
      "channel": "01285019302823526477"
    },
    "object": {
      "ver": "1.0",
      "id": "do_113036318281465856163"
    },
    "eventData":{
        "identifier":"do_113036318281465856163",
        "action": "update-es-index",
        "stage": 1
    }
}
```

**Stage 2: ML Keyword Extraction API will be triggering this event**

```
{
    "eid": "MVC_JOB_PROCESSOR",
    "ets": 1591603456223,
    "mid": "LP.1591603456223.a5d1c6f0-a95e-11ea-b80d-b75468d19fe4",
    "actor": {
      "id": "UPDATE ML KEYWORDS",
      "type": "System"
    },
    "context": {
      "pdata": {
        "ver": "1.0",
        "id": "org.ekstep.platform"
      },
      "channel": "01285019302823526477"
    },
    "object": {
      "ver": "1.0",
      "id": "do_113036318281465856163"
    },
    "eventData":{
        "identifier":"do_113036318281465856163",
        "action": "update-ml-keywords",
        "stage": 2,
        "ml_Keywords":["maths", "addition", "add"],
        "ml_contentText":"This is the content text for addition of two numbers."
    }
}
```

**Stage 3: ML Vectorization API will be triggering this event**

```
{
    "eid": "MVC_JOB_PROCESSOR",
    "ets": 1591603456223,
    "mid": "LP.1591603456223.a5d1c6f0-a95e-11ea-b80d-b75468d19fe4",
    "actor": {
      "id": "UPDATE ML CONTENT TEXT VECTOR",
      "type": "System"
    },
    "context": {
      "pdata": {
        "ver": "1.0",
        "id": "org.ekstep.platform"
      },
      "channel": "01285019302823526477"
    },
    "object": {
      "ver": "1.0",
      "id": "do_113036318281465856163"
    },
    "eventData":{
        "identifier":"do_113036318281465856163",
        "action": "update-ml-contenttextvector",
        "stage": 3,
        "ml_contentTextVector":""
    }
}
```

**MVC Cassandra Table Modification**

```
ALTER TABLE content_data 
ADD (textbook_name list<text>, 
        level1_name list<text>, level1_concept list<text>, 
        level2_name list<text>, level2_concept list<text>, 
        level3_name list<text>, level3_concept list<text>, 
        ml_content_text list<text>, ml_keywords list<text>, 
        ml_content_text_vector frozen <set<decimal>>, 
        source list<text>, source_url text, label text);
```

```
select  content_id, textbook_name, level1_name, level1_concept, level2_name, level2_concept,
        level2_name, level2_concept, ml_content_text, ml_keywords, ml_content_text_vector, 
        source, source_url, content_type, label
from content_data;
```

***

\[\[category.storage-team]] \[\[category.confluence]]

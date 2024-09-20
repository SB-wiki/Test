# Redis-Cache-Supportability-API-changes

### Background

To scale content and hierarchy consumptions, metadata which is fetched as part of the response is stored in Redis cache. In order to support data reset in redis and also to compare neo4j and redis, small adhocs are added to existing APIs.

### API changes

#### Force read from Neo4j

To force read data from neo4j for live node instead of redis(which is default), _source=db_  is introduced.

Content Read API:

```
Request:
GET - content/v3/read/{content_id}?source=db

Response:
{
     "id": "ekstep.content.find",
     "ver": "3.0",
     "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn",
     "params": {
          "resmsgid": "",
          "msgid": "",
          "err": "",
          "status": "successful",
          "errmsg": ""
     },
     "responseCode": "OK",
     "result": {
          content: {
			//content metadata from neo4j
		}
     }
}
```

Get Hierarchy API:

```
Request:
GET - content/v3/hierarchy/{content_id}?source=db

Response:
{
     "id": "ekstep.learning.content.hierarchy",
     "ver": "3.0",
     "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn",
     "params": {
          "resmsgid": "",
          "msgid": "",
          "err": "",
          "status": "successful",
          "errmsg": ""
     },
     "responseCode": "OK",
     "result": {
          content: {
			//content metadata from neo4j
		}
     }
}


```

#### Reset Redis

To force reset data in redis, refresh\_cache _=true_ is introduced. This reads data from neo4j and reset the data in redis.

Content Read API:

```
Request:
GET - content/v3/read/{content_id}?refresh_cache=true

Response:
{
     "id": "ekstep.content.find",
     "ver": "3.0",
     "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn",
     "params": {
          "resmsgid": "",
          "msgid": "",
          "err": "",
          "status": "successful",
          "errmsg": ""
     },
     "responseCode": "OK",
     "result": {
          content: {
			//content metadata from neo4j
		}
     }
}
```

Get Hierarchy API:

```
Request:
GET - content/v3/hierarchy/{content_id}?refresh_cache=true

Response:
{
     "id": "ekstep.learning.content.hierarchy",
     "ver": "3.0",
     "ts": "YYYY-MM-DDThh:mm:ssZ+/-nn.nn",
     "params": {
          "resmsgid": "",
          "msgid": "",
          "err": "",
          "status": "successful",
          "errmsg": ""
     },
     "responseCode": "OK",
     "result": {
          content: {
			//content metadata from neo4j
		}
     }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]

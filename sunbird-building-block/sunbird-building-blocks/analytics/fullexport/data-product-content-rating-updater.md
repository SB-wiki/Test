
### Summary

*  **Type**  - Content rating updater- update the content model with average rating


*  **Computation Level**  - Level 1


*  **Frequency**  - Runs Daily




### Purpose

* Generating Graph Update Event with average rating of a Content from consumption data and pushing to ES which is used to create dashboards.




### Inputs

*  **Raw Telemetry:**  - FEEDBACK Event


* Previous content rating summary from DB




### Outputs

1. Update content_rating_summary table in content_db




```js
#Schema of data model
{
    "period": String, // Data sync date in YYYY-MM-DD format. For ex: 2019-05-04
    "content_id": String, // content id
    "content_type": String, // content type
    "total_rating": Double, // Sum of ratings for a content for the period
    "total_count": Long, // Number of times the content has been rated.
    "avg_rating": Double // Average rating on content
}
```

```sql
#Schema of table

TABLE content_rating_summary (
    period text,
    content_id text,
    content_type text,
    total_rating double,
    total_count bigint,
    avg_rating double,
    PRIMARY KEY (content_id, period)
);
```
2 Generate Graph Update Event and push to Kafka topic learning.graph.events.


```js
#Schema of Graph Update Event
{
    "ets" : Long, // Event generation time in epoch
    "nodeUniqueId" : String, // content id
    "operationType": String, // default to UPDATE
    "nodeType": String, // default to DATA_NODE
    "graphId": String, // default to domain
    "objectType": String, // object type - Resolve object type from `content_type` field
    "nodeGraphId": Int, // default to 0
    "transactionData" : {
        "properties" : {
            "me_averageRating" : {
                "ov" : Double,
                "nv" : Double
            }
        }
    }
}
```

### Algorithm Design
 **1. Update** content_rating_summary table in content_db

 **Computation Table:** 


* Filter FEEDBACK events and group by content_id





| Field | Computation | Remark | 
|  --- |  --- |  --- | 
| content_id | [object.id](http://object.id) value |  | 
| content_type | object.type value |  | 
| period | Get the sync date in YYYY-MM-DD format | Period is added to avoid replay complexity. If replay is done for last 2 days, only those 2 records for each content will be updated and final average computation for graph event will be recomputed | 
| total_rating | Sum of edata.rating |  | 
| total_count | Count of FEEDBACK events |  | 
| avg_rating | total_rating/total_count |  | 

 **2. Generate Graph Update Event** 


* Get the list of unique content_ids from FEEDBACK events.


* Get all the entries in Cassandra table for that content.


* Compute Sum(total_rating), Sum(total_count) from Cassandra data.


* Compute average_rating as Sum(total_rating)/Sum(total_count) and generate a Graph Update Event for each content.






## Updates to Content Rating Updater Job \[[SB-17458](https://project-sunbird.atlassian.net/browse/SB-17458)]:


 **Description:**  This report provides details about all the contents that are published and their consumption statistics. 



 **Druid Query:** 

The below query used to get the content  **total time spent**  and  **total play**  in the  **app** ,  **portal** , and  **desktop**  from the summary event data source.




```
{
  "queryType": "topN",
  "dataSource": "summary-events",
  "aggregations": [
    {
      "type": "count",
      "name": "count"
    },
    {
      "fieldName": "total_time_spent",
      "fieldNames": [
        "total_time_spent"
      ],
      "type": "doubleSum",
      "name": "SUM(total_time_spent)"
    }
  ],
  "granularity": "all",
  "postAggregations": [],
  "intervals": "2020-02-05T00:00:00+00:00/2020-02-06T00:00:00+00:00",
  "filter": {
    "type": "and",
    "fields": [
      {
        "type": "selector",
        "dimension": "dimensions_pdata_id",
        "value": "prod.diksha.app" // Value will get change (app, desktop, portal)
      },
      {
        "type": "and",
        "fields": [
          {
            "type": "selector",
            "dimension": "dimensions_type",
            "value": "content"
          },
          {
            "type": "selector",
            "dimension": "dimensions_mode",
            "value": "play"
          }
        ]
      }
    ]
  },
  "threshold": 10000,
  "metric": "count",
  "dimension": "object_id"
}
;
```


Using the above query result which updates the content model indexer.


```
{
      "me_total_time_spent_in_app":"3454",
      "me_total_time_spent_in_portal:"524",
      "me_total_time_spent_in_desktop":"3233",
      "me_total_play_sessions_in_app":"324",
      "me_total_play_sessions_in_portal":"323",
      "me_total_play_sessions_in_desktop":"5323",
}
```










*****

[[category.storage-team]] 
[[category.confluence]] 

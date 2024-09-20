# Download-csv-in-course-dashboard-page

## Problem Statement 1:

Extend this design to support the download for batches stats upto 1L participants. By default elastic search  support max 10k records , in one search query.&#x20;

Use Elastic search **scroll** **api** . 'Scroll API ' can be used to retrieve large numbers of results (or even all results) from a single search request, it will work in same way as cursor on a traditional database.

| Pros                                     | Cons                                                    |
| ---------------------------------------- | ------------------------------------------------------- |
| We can retrieve large data set           | We can not use scroll api for real time user request    |
| We can slice the data based upon shards  | Performance issues while using it for real time request |

Example:

```
Path: /{{IndexName}}/{{type}}/_search?scroll=1m 
Request Data{ 
  "query": {//Contains the query required to fetch the data
},
  "size" : 1000,
}

Returns → {"scrollId":"SCROLL ID"hits:["data"]}After receiving the scroll Id We need to send this request till we get all the resultPath: 
/_search/scroll{
  "scroll": "1m",
  "scroll_id":"Scroll id" // received in the previous request
}

Returns {
"_scroll_id": "Scroll Id",
  "hits": {
    "total": 263,
    "max_score": 0.11207403,
  "hits": [ 
      {data}//result data from scroll api
  ]
}
}
//Implementation 
QueryBuilder qb = //query;

SearchResponse scrollResp = client.prepareSearch(indicesName)
        .setScroll(new TimeValue(60000))
        .setQuery(qb)
        .setSize(100).get(); //max of 100 hits will be returned for each scroll
//Scroll until no hits are returned
do {
    for (SearchHit hit : scrollResp.getHits().getHits()) {
        //Handle the hit...
    }

    scrollResp = client.prepareSearchScroll(scrollResp.getScrollId()).setScroll(new TimeValue(60000)).execute().actionGet();
} while(scrollResp.getHits().getHits().length != 0);

```

Approach 1:We can't start the service instantly or we can generate the batch metrics by running this service once in a day, it should be Async process , and process id need to be track. This process will generate file and upload to some storage and link will be share to user on email. second time we might use same file for particular date range : Ex , if user request for stats for a course batch and for that course batch report is already generated and report validity time not expire then we can re-use it , instead of re-generating.

Important points

1. It will return the process Id so we can track the status of the process.
2. if multiple user try to create stats for same batch we can check if any process exists in the system for same batch id and the duration is less than a day, we can send already created file to the requested user, else we can trigger the process to get the latest data and store the file path in the process.
3. We have to maintain the list of user who triggered the request so that we can send a mail to all the requested user.

## Problem Statement 2:

Extend this design to support the batches stats page upto 1L participants. By default elastic search  support max 10k records , in one search query.&#x20;

Solution 1:Using relation database management system. RDBMS provide both pagination and sorting available.

| **Pros**                     | **Cons**                      |
| ---------------------------- | ----------------------------- |
| It can handle large data set | We have to manage a new DB    |
|                              | Syncing data will be an issue |

Solution 2: Using filter inside the current implementation.

Filters that can be added

1. Filtering based on userName
2. Filtering based up on enrolled date (eg:- between start and end date)
3. Filtering based upon root org name
4. Filtering based upon progress status ( eg:- user progress between 20-40% )

| **Pros**                                          | **Cons**                                                                                                             |
| ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| We just need to handle the extra query parameters | If after applying search filters, the result data is more than 10000 then user will not be able to read all the data |
|                                                   |                                                                                                                      |

**Solution 3:**  Use Elastic search scroll api . 'Scroll API ' can be used to retrieve large numbers of results (or even all results) from a single search request, it will work in same way as cursor on a traditional database.

| **Pros**                       | **Cons**                                                |
| ------------------------------ | ------------------------------------------------------- |
| Can fetch data more than 10000 | Performance issues while using it for real time request |
|                                |                                                         |

***

\[\[category.storage-team]] \[\[category.confluence]]

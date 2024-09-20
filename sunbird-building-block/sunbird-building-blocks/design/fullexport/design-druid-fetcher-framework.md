 **Introduction:** This document describes the design for enhancing Core Fetcher framework to support Druid as one of the input source. This enhancements to the framework enables data product creation from druid.

 **Current Fetcher Framework:** Following are the supported fetch types in the framework abstracted by DataFetcher:


1. S3 - Fetch data from S3
1. Azure - Fetch data from azure
1. Local - Fetch data from local file. Using the local file one can fetch data from hdfs too.

Following are the APIs available in the DataFetcher


```scala
// API to fetch data. Fetch the data as an RDD when an explicit type parameter is passed.
val rdd:RDD[T] = DataFetcher.fetchBatchData[T](search: Fetcher);

```
A Fetcher object should be passed to the DataFetcher along with the type the data should be serialized to. Following are the example structures of the Fetcher object.


```scala
// Example fetcher to fetch data from S3
val s3Fetcher = Fetcher("s3", Option(Query("<bucket>", "<prefix>", "<startDate>", "<endDate>", "<delta>")))

// S3 Fetcher JSON schema
{
    "type": "s3",
    "query": {
        "bucket": "telemetry-data-store",
         "prefix": "raw/",
        "startDate": "2019-07-01",
        "endDate": "2019-07-02"
    }
}

// Example fetcher to fetch data from Azure
val azureFetcher = Fetcher("azure", Option(Query("<bucket>", "<prefix>", "<startDate>", "<endDate>", "<delta>")))

// Azure Fetcher JSON schema
{
    "type": "azure",
    "query": {
        "bucket": "telemetry-data-store",
         "prefix": "unique/",
        "startDate": "2019-07-01",
        "endDate": "2019-07-02"
    }
}

// Example fetcher to fetch data from Local

val localFetcher = Fetcher("local", Option(Query(None, None, None, None, None, None, None, None, None, "/mnt/data/analytics/raw-telemetry-2019-07-01.log.gz")))

// Local Fetcher JSON schema
{
    "type": "local",
    "query": {
        "file": "/mnt/data/analytics/raw-telemetry-2016-01-01.log.gz"
    }
}

```
 **Enhancements - Support for new fetcher type** 
* 
###  **Druid**  - Fetch data from druid


Druid Fetcher is used to get results from druid for a specific query. It queries druid DB to fetch the results


```scala
// Example fetcher to fetch data from Druid
val druidFetcher = Fetcher("druid", None, None, Option(DruidQuery("<querytype>", "<dataSource>", "<interval>", "<granularity>", "<dimensions>", List(Aggregation("<type>", "<name>")), None, DruidHavingFilter("<type>","<aggregation>","<value>"))))

// Druid Fetcher JSON schema
{
    "type": "druid",
    "druidQuery": {
        "queryType": "groupBy",
        "dataSource": "telemetry-events",
        "intervals": "LastWeek",
        "granularity": "all",
        "dimensions": [
            "context_pdata_id"
        ],
        "aggregations": [
            {
                "type": "count",
                "name": "count"
            }
        ],
        "having": {
            "type": "greaterThan",
            "aggregation": "count",
            "value": 100
        }
    }
}

```
DruidQuery model:
```scala
#Schema of DruidQuery:
{
    "queryType": String, // type of query. Ex: groupBy, topN, timeseries
    "dataSource": String, // datasource name to be queried. Ex: telemetry-events, summary-events, telemetry-log-events
    "intervals": String, // Supported intervals are LastDay, LastWeek, LastMonth, Last7Days, Last30Days
    "granularity": String, // Determines how gets aggregated by day, week etc.. Supported values are all, none, second, minute, fifteen_minute, thirty_minute, hour, day, week, month, quarter and year.
    "dimensions": List<String>, // List of fields to do groupBy.
    "aggregations": List<Aggregation>, // Aggregations for summarising data at query time.
    "postAggregations": PostAggregation, // Aggregations to be applied on aggregated values.
    "filters": List<DruidFilter>, // Filters to be applied in query computation. Performs AND operations between filters.
    "having": DruidHavingFilter, // Filters to be applied post aggregation i.e., on aggregated fields.
    "threshold": Long, // Defining value for N in topN query.
    "metric": String, // metric field name on which topN values should be sorted.
    "descending": String // Whether to make descending ordered result for timeseries query. Default is false(ascending).
}

#Schema of Aggregation:
{
    "name": String, // output field name.
    "type": String, // type of the aggregator Ex: count, longSum, doubleSum, floatSum, doubleMin, doubleMax, longMin, longMax etc
    "fieldName": String // input field name.
}

#Schema of PostAggregation:
{
    "type": String, // type of the post-aggregator Ex: arithmetic, javascript, constant, doubleGreatest, longGreatest(similar to SQL Greatest function), fieldAccess, finalizingFieldAccess  etc
    "name": String, // output field name.
    "fn": Option[String], // only for arithmetic & javascript types Ex: +, -, /, * or some javascript functions
    "fields": List[String] // aggregated input fields.
}

#Schema of DruidFilter:
{
    "type": String, // type of filter. Ex: selector, in, true etc
    "dimension": String, // input fields on which filter should be applied.
    "value": String, // value to match for "selector" query.
    "values": List<String> // list of values to match for "in" filter.
}

#Schema of DruidHavingFilter:
{
    "type": String, // type of filter. Ex: greaterThan, equalTo, lessThan etc
    "aggregation": String, // aggregated field on which filter should be applied.
    "value": String // value to match.
}

```




*****

[[category.storage-team]] 
[[category.confluence]] 

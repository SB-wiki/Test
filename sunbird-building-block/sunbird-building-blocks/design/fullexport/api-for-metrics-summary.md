
# Requirement


Ref: [SB-8988 System JIRA](https:///browse/SB-8988)

Scope is :

1. This will expose one end point to show all metrics summary

2. Internally it will make call to analytics team and merge both static data and data got from analytics team.

3. Since Analytics data will change once in 24 hours, so sunbird will do the data cache and use it , only first time it will make call to analytics api.

4. Sunbird should have cache ttl as well, so that after x hours it should reload data.


# Problem Statements

1. Design a way to handle the data, metrics summary, onboard status and etb status that will be captured manually to the system
1. Design a service to read the static data mentioned above and dynamic data from analytics server and cache it with ttl for refresh and retrieval
1. Design an API to retrieve cached metrics data and return it in response


# Design

### Capturing static data


| Metrics Summary | Onboard Status data | ETB Status data | 
|  --- |  --- |  --- | 
| Metrics Key Metrics Value | Tenant NameTenant IdChannelOnboard StatusAcademic Year | Tenant NameTenant IdChannelBoardGradeSubjectETB Print CountAcademic YearETB Status | 



 **Approach 1:** 

Capture the static data in cassandra by running CQL queries directly in cassandra. The cache refresh service has to read the data from cassandra.

Pros:

Cassandra is the primary datastore in sunbird platform. Easier for adopters(implementation teams) to update the static data with CQL queries.

 **Approach 2:** 

Capture the static data in elastic search directly using ES rest calls. The cache refresh service has to read the data from elastic search.

Pros:

No rework is needed at cache refresh service, if CRUD APIs are implemented with data being stored at both cassandra and elastic search

 **Approach 3:** 

Develop an API for CRUD operations on the static data. This is planned for release-1.13

Pros:

No access to datastore is needed to configure the static data



Cassandra Table Design:



| Metrics Summary | Onboard Metrics | ETB Metrics | 
|  --- |  --- |  --- | 
| 


```
CREATE TABLE sunbird.metrics_summary (
	metricskey text,
	metricsvalue text,
	PRIMARY KEY(metricskey)
);
```


 | 


```
CREATE TABLE sunbird.metrics_tenant_onboard_status (
	tenantname text,
	tenantid text,
	channel text,
	onboardstatus text,
	academicyear text,
	PRIMARY KEY(tenantname)
);
```


 | 


```
CREATE TABLE sunbird.metrics_tenant_etb_status (
	tenantname text,
	tenantid text,
	channel text,
	board text,
	grade text,
	subject text,
	etbprintcount int,
	academicyear text,
	etbstatus text,
	PRIMARY KEY(board)
);
```


 | 


### Service to cache data
A service needs to be written to retrieve the static data from local datastore and dynamic data from the analytics server. The service should aggregate the data and cache it in memory with a expiry time.

The service should be called in two circumstances


1. Scheduled to be called at the end cache expiry time.
1. Should be triggered by set static data API, once it is implemented.




### Metrics API
Metrics API to provide following details


1. Metrics Summary
1. Onboard Status drilldown data
1. ETB Status drilldown data
1. Content Creation drilldown data
1. Content Consumption drilldown data(To be implemented in June-2019)



 **Request** :

metricsType : metricsSummary, onboardMetrics, etbPrintMetrics, contentCreationMetrics



 **Response** :



|  **metricsTypes**  | sample response | 
|  --- |  --- | 
| metricsSummary | 


```
{
  "response": {
    "metricsAsOn": "2019",
    "onboardSummary": {
      "tenantCount": 26
    },
    "etbSummary": {
      "etbPrintCount": 20000000,
      "tenantCount": 26
    },
    "contentCreationSummary": {
      "contentsPublished": 50000,
      "languages": 15,
      "contributors": 6000
    },
    "contentConsumptionSummary": {
      "uniqueDevices": 50000000,
      "learningExperiences": 20000000,
      "hoursOfInteraction": 65000000
    }
  }
}
```


 | 
| onboardMetrics | 


```
{
  "response": {
    "metricsAsOn": “2019",
    "tenantCount": 26,
    "tenants": [
      {
        "tenantName": "Maharashtra",
        "onboardStatus": "Live",
        "onboardYear": "2018-19"
      },
      {
        "tenantName": "Assam",
        "onboardStatus": "In Progress",
        "onboardYear": "2019-20"
      }
    ]
  }
}
```


 | 
| etbPrintMetrics | 


```
{
  "response": {
    "metricsAsOn": "2019",
    "boardCount": 29,
    "etbTotaCount": 4500000000,
    "boards": [
      {
        "board": "DSERT",
        "tenantName": "Karnataka",
        "classes": "1,2,6,8",
        "subjects": "English, Science",
        "etbPrintCount": 20000,
        "etbAcademicYear": "2018-19",
        "status": "Live"
      },
      {
        "board": "CBSE",
        "tenantName": "-",
        "classes": "6,8",
        "subjects": "Maths, Social Studies",
        "etbPrintCount": 15000,
        "etbAcademicYear": "2019-20",
        "status": "Inprogress"
      }
    ]
  }
}
```


 | 
| contentCreationMetrics | 


```
{
  "response": {
    "metricsAsOn": "2019",
    "creatorCount": 6000,
    "languageCount": 15,
    "contentTotalCount": 50000,
    "contentCreation": [
      {
        "publisher": "Maharashtra",
        "languages": "Hindi, Marathi, English",
        "contentCount": 20000
      },
      {
        "publisher": "Tamil Nadu",
        "languages": "Tamil, English",
        "contentCount": 10000
      }
    ]
  }
}
```


 | 



Open Questions:


1. Should tenant id and channel be captured at tenant level for onboard and etb metrics?
1. Store static data in cassandra or ES?
1. Should multiple values in a column be stored as a list or comma separated string?
1. Can a tenant have multiple onboarding statuses?
1. Can a board be associated to multiple tenants?



Accepted Solution

In the meeting with design council, following approach has been finalised.

Since this design is only for static data and this being a adopter specific requirement, the static data can be configured in a json file which would be parsed and presented by static pages.

The format of the json file is designed in [[Static data - JSON format|Static-data---JSON-format]]





*****

[[category.storage-team]] 
[[category.confluence]] 

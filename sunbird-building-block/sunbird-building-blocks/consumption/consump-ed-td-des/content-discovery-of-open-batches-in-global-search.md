
## Problem
As a system, Collections such as courses are associated with batch information to suggest if collection has open batches/ closed batches. In the case of non-trackable collections like textbooks etc. The info is not present as the information is not relevant. This brings a unique problem of discoverability. When user searches for Trackable collection, Consumption may end up with trackable. collections with closed batches which is not relevance to the user. In case of Global/Generic search this provides a unique challenge to filter only open batch trackable collections + Non Trackable collections to be returned as part of search query.


## Present System
In the present system, Tracked Collections are stamped with metdata of batch.status to indicate the presence of open batches.



Non Trackable Collection


```json
"content": [{
  "trackable": {
    "enabled": "No",
    "autoBatch": "No"
   }
]] ]></ac:plain-text-body></ac:structured-macro></ac:layout-cell><ac:layout-cell><p>Trackable - Open Batch</p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="7da12aa6-b860-4a63-993c-a29d5117508f"><ac:plain-text-body><![CDATA[{
  "content": [
    {
      "trackable": {
        "enabled": "Yes",
        "autoBatch": "No"
      },
      "batches": [
        {
          "name": "CBE Module 1- Batch 2021",
          "batchId": "01319332749176832013",
          "enrollmentType": "open",
          "enrollmentEndDate": "2021-12-30",
          "startDate": "2021-01-14",
          "status": 1
        }
      ]
    }
  ]
}
```
Trackable - Closed Batch


```json
{
  "content": [
    {
      "trackable": {
        "enabled": "Yes",
        "autoBatch": "No"
      },
      "batches": [
        {
          "name": "CBE Module 1- Batch 2021",
          "batchId": "01319332749176832013",
          "enrollmentType": "open",
          "enrollmentEndDate": "2021-12-30",
          "startDate": "2021-01-14",
          "status": 0
        }
      ]
    }
  ]
}
```

## Proposed System
In the proposed system, intent is to make collection searchable for batch status irrespective of whether the collection is trackable or non trackable. This gives the flexibility for the user to create custom filter preferences on “Open Batches“ for Collection.




## Solution
Using Existing metadata informationIn this solution, collection metadata metadata which represents batch information to be available with default values. For Ex:


```json
"content": [{
  "trackable": {
    "enabled": "No",
    "autoBatch": "No"
   }
]] ]></ac:plain-text-body></ac:structured-macro><p /></ac:layout-cell><ac:layout-cell><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="c5eb0eb3-60b1-4871-8605-687bcb424ac6"><ac:parameter ac:name="language">json</ac:parameter><ac:plain-text-body><![CDATA["content": [{
  "trackable": {
    "enabled": "Yes",
    "autoBatch": "No"
   },
   "batches": [
    {
      "name": "",
      "batchId": "",
      "enrollmentType": "",
      "enrollmentEndDate": "",
      "startDate": "",
      "status": -1
    }
  ]}
]] ]></ac:plain-text-body></ac:structured-macro></ac:layout-cell></ac:layout-section><ac:layout-section ac:type="fixed-width" ac:breakout-mode="default"><ac:layout-cell><p><strong>Note</strong>: This Approach would mean we need to carry migration with cassandra for existing “Non Trackable Collections“.</p><h4>Using a new Attribute at Collection Level metadata.</h4><p>In this solution, the collection metadata would have new attribute to suggest the batch count explicitly.</p></ac:layout-cell></ac:layout-section><ac:layout-section ac:type="two_left_sidebar" ac:breakout-mode="default"><ac:layout-cell><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="1be1c1c6-d82f-4e15-bcee-33fd0ab5834f"><ac:plain-text-body><![CDATA["content": [{
  "trackable": {
    "enabled": "No",
    "autoBatch": "No"
   }
]] ]></ac:plain-text-body></ac:structured-macro></ac:layout-cell><ac:layout-cell><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="aa6a9a38-0070-4999-b0ac-5c480aca08f1"><ac:plain-text-body><![CDATA["content": [{
  "trackable": {
    "enabled": "No",
    "autoBatch": "No"
   },
   "batchAvailablilty":"DEFAULT"
]] ]></ac:plain-text-body></ac:structured-macro></ac:layout-cell></ac:layout-section><ac:layout-section ac:type="two_left_sidebar" ac:breakout-mode="default"><ac:layout-cell><p>Non Trackable Collection - Open Batch</p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="fa2de792-8ee9-4f81-8d2f-9384af382bd6"><ac:plain-text-body><![CDATA[{
  "content": [
    {
      "trackable": {
        "enabled": "Yes",
        "autoBatch": "No"
      },
      "batches": [
        {
          "name": "CBE Module 1- Batch 2021",
          "batchId": "01319332749176832013",
          "enrollmentType": "open",
          "enrollmentEndDate": "2021-12-30",
          "startDate": "2021-01-14",
          "status": 1
        }
      ]
    }
  ]
}
```



```json
{
  "content": [
    {
      "trackable": {
        "enabled": "Yes",
        "autoBatch": "No"
      },
      "batchAvailablilty":"OPEN"
      "batches": [
        {
          "name": "CBE Module 1- Batch 2021",
          "batchId": "01319332749176832013",
          "enrollmentType": "open",
          "enrollmentEndDate": "2021-12-30",
          "startDate": "2021-01-14",
          "status": 1
        }
      ]
    }
  ]
}
```
Non Trackable Collection - Closed Batch


```
{
  "content": [
    {
      "trackable": {
        "enabled": "Yes",
        "autoBatch": "No"
      },
      "batches": [
        {
          "name": "CBE Module 1- Batch 2021",
          "batchId": "01319332749176832013",
          "enrollmentType": "open",
          "enrollmentEndDate": "2021-12-30",
          "startDate": "2021-01-14",
          "status": 0
        }
      ]
    }
  ]
}
```



```json
{
  "content": [
    {
      "trackable": {
        "enabled": "Yes",
        "autoBatch": "No"
      },
      "batchAvailablilty":"CLOSED"
      "batches": [
        {
          "name": "CBE Module 1- Batch 2021",
          "batchId": "01319332749176832013",
          "enrollmentType": "open",
          "enrollmentEndDate": "2021-12-30",
          "startDate": "2021-01-14",
          "status": 1
        }
      ]
    }
  ]
}
```
 **Note** : This Approach would mean we need to carry migration with cassandra for all collections (“Both Trackable and Non Trackable“)

Sample Search Query for Solution 1 & 2


```
{
  "request": {
    "filters": {
      "primaryCategory": [
        "Course",
        "Course Assessment"
        "Digital Textbook"
      ],
      "batches.status": [-1,1],//Not Sure If this is possible
      "status": [
        "Live"
      ],
      "se_boards": [
        "CBSE"
      ],
      "se_mediums": [
        "English"
      ],
      "se_gradeLevels": [
        "Class 5"
      ]
    },
    "limit": 100
  }
}
```

```
{
  "request": {
    "filters": {
      "primaryCategory": [
        "Course",
        "Course Assessment"
        "Digital Textbook"
      ],
      "batchAvailablilty":["DEFAULT","OPEN"],
      "status": [
        "Live"
      ],
      "se_boards": [
        "CBSE"
      ],
      "se_mediums": [
        "English"
      ],
      "se_gradeLevels": [
        "Class 5"
      ]
    },
    "limit": 100
  }
}
```


*****

[[category.storage-team]] 
[[category.confluence]] 

# Implementation-of-VDN-reports-with-analytics-data-product-framework

#### **Introduction** :

The VDN reports are for the states to track their data for necessary actions to be taken upon it. The reports will include the textbook level and chapter level content reports. The textbook level report is for the textbook's summary and detailed level report and the chapter reports are to check the chapter wise content summary.

####

**Proposed Design** : **Frequency:** Weekly.

**Reports:**

* Textbook Level Content Report
* Chapter Level Content Report

**Implementation:**

![](../../../../Analytics/Fullexport/images/storage/vdn-2\(2\).png)

**Queries:**

Query to get tenant info

```
{
    "params": { },
    "request":{
        "filters": {
            "isRootOrg": true
        },
        "offset": 0,
        "limit": 1000,
        "fields": ["id", "channel", "slug", "orgName"]
    }
}
```

**Output CSV:**

* Textbook Level Content Report:

| **Project Name**            | **Medium** | **Classes** | **Subjects**          | **Textbook Name** | **Total number of chapters (first level sections of ToC)** | **Number of chapters with atleast one approved content of each content type in project** | **Number of chapters with atleast one approved content** | **Total number of approved contents** | **Total number of approved contents of content type - Focus Spot** |
| --------------------------- | ---------- | ----------- | --------------------- | ----------------- | ---------------------------------------------------------- | ---------------------------------------------------------------------------------------- | -------------------------------------------------------- | ------------------------------------- | ------------------------------------------------------------------ |
| CBSE Class 1 to 5 Textbooks | English    | Class 3     | Environmental Studies | Looking Around    | 24                                                         | 0                                                                                        | 9                                                        | 183                                   | 8                                                                  |
|                             |            |             |                       |                   |                                                            |                                                                                          |                                                          |                                       |                                                                    |

* Chapter Level Content Report:

| **Project Name**            | **Medium** | **Classes** | **Subjects**          | **Textbook Name** | **Chapter Name (first level section of ToC)** | **Total number of approved contents** | **Total number of approved contents of content type - (List of contentTypes)** |
| --------------------------- | ---------- | ----------- | --------------------- | ----------------- | --------------------------------------------- | ------------------------------------- | ------------------------------------------------------------------------------ |
| CBSE Class 1 to 5 Textbooks | English    | Class 3     | Environmental Studies | Looking Around    | Chapter 1- Poonams Day out                    | 36                                    |                                                                                |
|                             |            |             |                       |                   |                                               |                                       |                                                                                |

***

\[\[category.storage-team]] \[\[category.confluence]]

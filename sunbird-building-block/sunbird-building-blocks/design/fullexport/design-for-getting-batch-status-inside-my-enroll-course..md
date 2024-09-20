# Design-for-getting-batch-status-inside-my-enroll-course.

**Overview**

We need to include Batch Status attribute in response of API to fetch user enrolled courses (/course/v1/user/enrollment/list/{‌{userId}‌}).

**/course/v1/user/enrollment/list/{‌{userId}‌}?batchDetails=\[fields comma separated ]\&orgDetails=name,email**

**e.g.** fields=relatedEntity1{field1,field2},relatedEntity2{field1,field2}

Response will be under key relatedEntity1 as key-value map

**Approaches** **Approach 1** API will accept a new query parameter as fields, where user can specify which batch fields need to be fetched along with enrolled courses.

| Pros                                                                             | Cons                                   |
| -------------------------------------------------------------------------------- | -------------------------------------- |
| Separation of the query param. Ex: OrgDetails is for org and fields is for batch | Explicit input for fields is required. |
| Gives flexibility for user to fetch batch fields as per requirement              |                                        |

**Solution:**

**Implementation details :**

1. Before returning the response , we will iterate over courses objects.
2. Get batchId from each course object and collect all batchIds and fetch batch data in single call from ES.
3. Iterate over courses object and append the required batch-data.
4. return the response.

&#x20;                              &#x20;

**API to get user course enrollment list**

**Get  ../course/v1/user/enrollment/list/{‌{userId}‌}?batchDetails =name,startDate,endDate,status**

Resopnse :

```js
{
  "id": "api.user.courses.list",
  "ver": "v1",
  "ts": "2018-11-15 09:17:31:909+0000",
  "params": {
    "resmsgid": null,
    "msgid": "9db786d3-45c2-447d-b657-f9768da15652",
    "err": null,
    "status": "success",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    "courses": [
      {
        "dateTime": "2018-07-04 09:31:22:294+0000",
        "status": 1,
         ...
        "batch": {
          "name": "batchName",
          "startDate": "2018-01-02",
          "endDate": "2018-01-22",
          "status": "1"
        }
      },
      {
        ...
        }
      }
    ]
  }
}
```

**Approach 2** Not accepting any attribute value in request parameters , returning standard supported fields for the course batches in which user is enrolled.

| Pros                    | Cons                                                                       |
| ----------------------- | -------------------------------------------------------------------------- |
| User input not required | Requires code changes for getting additional fields in response in future. |
|                         | Additional calls - regardless of whether user wants the additional data.   |

**Solution:**

**Implementation details :**

Same as approach 1, except the fields of batch to be returned are hard-coded in code.

**API to get user course enrollment list**

**Get  ../course/v1/user/enrollment/list/{‌{userId}‌}?orgDetails=orgName**

**Response** :

```js
{
  "id": "api.user.courses.list",
  "ver": "v1",
  "ts": "2018-11-15 09:17:31:909+0000",
  "params": {
    "resmsgid": null,
    "msgid": "9db786d3-45c2-447d-b657-f9768da15652",
    "err": null,
    "status": "success",
    "errmsg": null
  },
  "responseCode": "OK",
  "result": {
    "courses": [
      {
        "dateTime": "2018-07-04 09:31:22:294+0000",
        ...
        "batch": {
          "name": "batchName",
          "startDate": "2018-01-02",
          "endDate": "2018-01-22",
          "status": "1",
         
        }
      },
     { }
    ]
  }
}


```

**Approach 3**  Accepting attributes in request parameters and also providing standard batch data. If request parameter contains any other attribute different from standard batch data , the batch data map will also have the requested attributes with standard batch data.

| Pros                                                                                                                                                                                            | Cons                                                                                                                                                                                                                              |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <ul><li>This Hybrid of approaches mentioned above. So can return specific standard batch data as well as requested batch data about course batches in which user is enrolled.</li></ul>         | <ul><li>Need to handle if request attribute is not supported or already present in standard batch data.</li></ul>                                                                                                                 |
| <ul><li>If any unsupported fields is requested, we can return "field not found" for "unsupported field name" as key  in the batch  map, which already containing standard batch data.</li></ul> | <ul><li>Some time standard supported batch data may contain useless data for an specific request. ex: only batch status is required but some other standard details are also returned in response.(batchName,startDate)</li></ul> |

**Solution**

**API to get user course enrollment list**

**1.** **Get  ../course/v1/user/enrollment/list/{‌{userId}‌}?orgDetails=name   response  will same as approach 2 in which only standard batch data will be return as no other attribute is mentioned in this request.**

**2. Get  ../course/v1/user/enrollment/list/{‌{userId}‌}?orgDetails=name,status\&fields=batch{name,startDate,endDate,status}.   Here we  already have  batch start date , end date and status is standard batch data.**

**Implementation details :**

Algorithm same as **Approach 1**

**Responses**

```js
{
    "id": "api.user.courses.list",
    "ver": "v1",
    "ts": "2018-11-15 09:17:31:909+0000",
    "params": {
        "resmsgid": null,
        "msgid": "9db786d3-45c2-447d-b657-f9768da15652",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "courses": [
            {
                "lastReadContentId": "do_21253529011637452811543",
                "courseId": "do_21253534443347968011561",
                "status": 1,
                "batch" :{ 
					"startDate":"2018-01-02",
					"endDate":"2018-01-22",
					"status" :"1",
					"name":"batchName",
					"someUnsupportedField":"NOT_SUPPORTED",
					 "someOtherKey": "someOtherValue"
				}
            },
            {
               
            }
        ]
    }
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]

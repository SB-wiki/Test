  * [Introduction:](#introduction:)
  * [Background:](#background:)
  * [Problem Statement:](#problem-statement:)
  * [Key design problems:](#key-design-problems:)
  * [Solution 2:](#solution-2:)
  * [Solution 3:](#solution-3:)
    * [Pros:](#pros:)
    * [Cons:](#cons:)
  * [Related articles:](#related-articles:)

## Introduction:
This document describes how to add/show certificate rules dynamically based on the certificate type


## Background:
Jira Issue [https://project-sunbird.atlassian.net/browse/SH-993](https://project-sunbird.atlassian.net/browse/SH-993)


## Problem Statement:

1. How to show/add certificate rules dynamically based on certificate type?




## Key design problems:

1. How to get certificate rules based on cert type selection?


1. How to show/add certificate rules based on cert type selection?



 **Form field:** 


```
{
  code: "issueCertTo"
  dataType: "text"
  description: "Cert can be issues to"
  displayProperty: "Editable"
  editable: true
  index: 1
  inputType: "select"
  label: "Issue certificate to"
  name: "Issue certificate to"
  range: [{value: "", label: "All"}, {value: "{user:{rootOrgId: '?channel'}", label: "State teachers"}]
  renderingHints: {semanticColumnWidth: "four"}
  required: false
  visible: true
}
```
 **Certificate Rules** :  Samples(added some assumptions like age, timespent, top5 etc..)


```
 [
    {
         "key": "rootOrgId",
         "expression": "=",
         "value": "?channel",

     },
     {
        "key": "age",
        "expression": "<=",
        "value": "20"
    }, 
     {
         "key": "timespent",
         "expression": "<",
         "value": "{{miliseconds}}"
     },
     {
        "key": "score",
        "expression": "<",
        "value": "90"
    },
     {
         "key": "status",
         "expression": " = ",
         "value": "2"
     },
     {
        "key": "completed",
        "expression": ">",
        "value": "60"
    },
    {
        "key": "top",    // Top 5 users
        "expression": "max",
        "value": "5"
    }
 ]] ]></ac:plain-text-body></ac:structured-macro><h2>Solution 1:</h2><p>Custom configuration of form API response specific to Certificates</p><p>Create the RuleElement/template for each certificate rule. The user can add these rules by joining with AND or OR operations.</p><p>Sample certificate rule template/element</p><ol><li><p>Score</p></li><li><p>Completion</p></li><li><p>Timespent</p></li><li><p>Top5 </p></li><li><p>etc..</p></li></ol><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="1a1cad20-53d5-49ad-8a2b-f381c1111042"><ac:plain-text-body><![CDATA[{
    code: "certType"
    dataType: "text"
    description: "Cert can be issues to"
    index: 1
    inputType: "select"
    label: "Issue certificate to"
    name: "Issue certificate to"
    range: [{value: "completion", label: "Completion certificate"}, {value: "merit", label: "Merit certificate"}]
    renderingHints: {semanticColumnWidth: "four"}
    criteria: { type: "?certType"}
    visible: true
  },
{
    code: "rule"
    dataType: "list"
    description: "Cert can be issues to"
    index: 1
    inputType: "select"
    label: "Issue certificate to"
    name: "Issue certificate to"
    range: [{value: "", label: "All"}, {value: "?channel", label: "State teachers"}]
    renderingHints: {semanticColumnWidth: "four"}
    criteria: { user: {rootOrgId: "?channel"}}
    visible: true
  },
  {
    code: "rule"
    dataType: "list"
    description: "To issue certificate score should be"
    index: 2
    inputType: "score"
    label: "Issue certificate to"
    range: [{value: ">", label: ">"}, {value: "<", label: "<"}, {value: "<=", label: "<="}, {value: ">=", label: ">="}]
    renderingHints: {semanticColumnWidth: "four"}
    criteria: { "enrolment": {"score": "?operator ?value"}}
    visible: true
  },
  {
    code: "rule"
    dataType: "list"
    description: "Issue certificate for completion"
    index: 3
    inputType: "completion"
    label: "Issue certificate to"
    range: [{value: ">", label: ">"}, {value: "<", label: "<"}, {value: "<=", label: "<="}, {value: ">=", label: ">="}]
    renderingHints: {semanticColumnWidth: "four"}
    criteria: { enrolment: {progress: "?operator ?value"}}
    visible: true
  },
```

1. Do we need Cetificate template type? If so, it should be added while uploading the new cert template. All the template types will be added into form configuration of certType. This will help to filter the certificates based on certType. 


1.  **inputType: score** 

    Custom element to show score rule element. It will be having operation, value & joining operator(AND/OR).



This new element will allow adding multiple rules for the score.

 **Save Certificate rules** Multiple rules will be joined together while saving the Criteria.


```
criteria: { 
  "user": 
    {
      rootOrgId: "12345"
    },
    "enrolment": 
    {
      {"progress": {">=": 60, "<=": 80},
      {"score": ">80"}
    }
}
```
Pros:
1. Any new criteria can be supported by adding the new template/inputype element & criteial object


1. 



Cons:
1. New criteria support requires development effort to build new element  & criteria support(backend)


1. How to maintain the list of supporting elements.


1. Backend should know how to parse the data of criteria.query property




## Solution 2:
Form API to render the UI & adding the logic on front-end for each certificate rule.


```
// Existing form configuration
 {
    code: "rule"
    dataType: "object"
    description: "Cert can be issues to"
    displayProperty: "Editable"
    editable: true
    index: 1
    inputType: "select"
    label: "Issue certificate to"
    name: "Issue certificate to"
    range: [{value: "", label: "All"}, {value: "{'user':{rootOrgId: '?channel'}}", label: "State teachers"}]
    renderingHints: {semanticColumnWidth: "four"}
    required: false
    visible: true
  },
  {
    code: "rule"
    dataType: "object"
    description: "Mac score to get certificate"
    displayProperty: "Editable"
    editable: true
    index: 2
    inputType: "number"
    label: "Score"
    name: "Score"
    renderingHints: {semanticColumnWidth: "four"}
    required: false
    visible: true
  }

```
 **Save Certificate rules** Adding the service logic specific to backend supported request format. 


```
criteria: { 
  { "user": 
    {
      rootOrgId: "12345"
    }
  },
  { 
    "enrolment": 
    {
      {"progress": ">= 60 AND <= 80"}",
      {"score": ">80"}
    }
  }
}
```


Pros:
1. Easy to implement to support current certificate rules.



Cons:
1.  Front-end code will not be generic. It will support only present cert supported format data. Any change in the request format, front-end code has to change


1. Not a scalable solution.






## Solution 3:
Similar to elastic search


```
{
    "_source": [
        "status",
        "rootOrgId"
    ],
    "query": {
        "bool": { 
            "must": [
              { "match": { "status": 2        }},
              { "match": { "rootOrgId": "012345" }}
            ],
            "filter": [ 
              { "range": { "score": { "gte": "80" }}}
            ]
          }
    },
    "from": 0,
    "size": 5   // Top 5 users
 }
```



### Pros:

1. 


1. 




### Cons:

1. 




## Related articles:
[[Certificate: Attach to a batch|Certificate--Attach-to-a-batch]]

[https://project-sunbird.atlassian.net/wiki/spaces/SP/pages/1665925124/Certificate+criteria+verification?focusedCommentId=1679982648](https://project-sunbird.atlassian.net/wiki/spaces/SP/pages/1665925124/Certificate+criteria+verification?focusedCommentId=1679982648)





*****

[[category.storage-team]] 
[[category.confluence]] 

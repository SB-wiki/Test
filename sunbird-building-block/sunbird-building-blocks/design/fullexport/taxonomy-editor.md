# Taxonomy-editor

**Problem Statement:**

In Sunbird system classification of terms and identify the relations (association) between terms belongs to different categories and show that in visual representation help user to creation and publishing of framework with categories.

**Existing System**

Current system of Taxonomy classifications are hierarchical representation of terms belongs to different category in a tree structure which might be complex when there are large system, It is difficult to show relation or association between terms belong to different category

creation and association of terms in sun bird is done through postman collection,

**Proposed System of Taxonomy**

In proposed the taxonomy editor system under category we can create terms and associate/relate terms belonging to different categories in a visual representation as shown below this.

![](<../../../../Design/FullExport/images/storage/clip-board (1).jpg>)

**How it works:**

![](../../../../Design/FullExport/images/storage) **UI setup guide :-**

1. Install latest version of angular.

npm i sb-taxonomy-editor

1.  Add below element in sunbird-Ed-portal

    \<lib-taxonomy-view \[environment]="environment" \[taxonomyConfig]="taxonomyConfig">
2. Save below "environment" and "taxonomyConfig" in local storage before initialize above library. (this need to change as input to a library) / Default configuration is available.

```
         environment =  {
                 frameworkName: string,   
                 channelId: string,
                 authToken: string,
                 isApprovalRequired:  boolen  // set default to false,
          }

         taxonomyConfig = {
                    frameworkId: string,
                    config: [
                        {
                            index:number,
                            category:string,
                            icon: 'string',
                            color: 'string'
                        }
                    ]
        }
```

**Taxonomy overview :-**

What is taxonomy ?

```
 Taxonomy helps to clarify our thinking by classifying things neatly into categories and sub-categories based on their relationships. The

  primary goal of taxonomy is to recognize, characterise, classify, and name based on their properties.
```

What is term ?

```
Terms are items (entities or objects) with in the taxonomy, As below example shows education system    taxonomy, where CBSC, Hindi,

 Grade1, English are terms belonging to different categories,
```

What is Association ?

```
In the taxonomy system terms belonging to different category relate to each other, that relation is called association, each category term

might have multiple relations with terms belonging to different categories.
```

In the below example CBSC board have relate to Hindi medium, like Hindi medium might have grde 1 and grade 2 relation.

Example:- Education Taxonomy would look as below.

![](../../../../Design/FullExport/images/storage) **API’s Used:**

1. \*\*Framework Read \*\*

\{{domain\}} – should be replaced with the host address of the target environment.&#x20;

\{{frameworkId\}} – should be replaced with the framework identifier which is created.&#x20;

\{{channelId\}} - channel Id which the framework belongs to. &#x20;

\{{apiKey\}} - Kong Gateway API Key for the target environment.&#x20;

```
curl --location --request GET 'https://{{domain}}/api/framework/v1/read/{{frameworkId}} \ 

--header 'Content-Type: application/json' \ 

--header 'X-Channel-Id: {{channelId}}' \ 

--header 'Authorization: Bearer {{apiKey}}' 
```

1. \*\*Framework Publish \*\*

```
curl --location --request POST 'https://{{domain}}/api/framework/v1/publish/{{frameworkId}}' \ 

--header 'Content-Type: application/json' \ 

--header 'Authorization: Bearer {{apiKey}}' \ 

--header 'X-Channel-Id: {{channelId}}' \ 

--data-raw '{}' 
```

1. \*\*Term Create \*\*

\{{domain\}} - Host address of the target environment&#x20;

\{{frameworkId\}} – Framework identifier from the target environment.&#x20;

\{{newUUID\}} - provide newly generated UUID value from client.&#x20;

```
curl --location --request POST 'https://{{domain}}/api/framework/v1/term/create?framework={{frameworkId}}&category={{categoryId}}' \ 

--header 'Content-Type: application/json' \ 

--header 'Authorization: Bearer {{apiKey}}' \ 

--data-raw '{ 

    "request": { 

        "term": { 

            "code": "{{newUUID}}", 

            "name": "Noting and Drafting", 

            "description": "Draft and analyse a note, in order to move a proposal for decision making based on the availability of evidence and existing rules and precedents", 

            "status": "Draft", 

            "parents": [ 

                { 

                    "identifier": "{{frameworkId}}_{{categoryId}}" 

                } 

            ], 

           “approvalStatus" : “Draft”, 

            "additionalProperties": { 

                "competencyType": "Domain", 

                "competencyArea": "Office Management", 

                "sourceId": "CID02755" 

            } 

        } 

    } 

}' 
```

1. **Term Update** &#x20;

\{{domain\}} - Host address of the target environment&#x20;

\{{termCode\}} - Term code value which needs to be updated.&#x20;

\{{frameworkId\}} – Framework identifier from the target environment.&#x20;

\{{categoryId\}} - Category code from the selected object group.&#x20;

\{{targetTermIdentifier\}} - provide the target term object identifier which the association should be created.&#x20;

&#x20;

```
curl --location --request PATCH 'https://{{domain}}/api/framework/v1/term/update/{{termCode}}?framework={{frameworkId}}&category={{categoryId}}' \ 

--header 'Content-Type: application/json' \ 

--header 'Authorization: Bearer {{apiKey}}' \ 

--data '{ 

    "request": { 

        "term": { 

            "associations": [ 

                { 

                    "identifier": {{targetTermIdentifier}}, 

                     “approvalStatus" : “Draft”, 

                } 

            ] 

        } 

    } 

}' 
```

Note : “associations” array contain all the term object identifiers – which are previously created associations. &#x20;

**Approval flow (TODO)**

1.  \*\*Workflow Create \*\*

    ```
          {{domain}} - Host address of the target environment 
    ```

&#x20;            \{{userToken\}} - User Auth token&#x20;

&#x20;             \{{TermObject\}} -  Term objects&#x20;

```
curl --location '{{domain}}/api//workflow/taxonomy/create' \ 

--header 'userToken: {{userToken}} '\ 

--header 'Authorization: bearer {{api-key}}' \ 

--header 'Content-Type: application/json' \ 

--data '{ 

    "state": "INITIATE", 

    "action": "INITIATE", 

    "serviceName": "taxonomy", 

    "updateFieldValues": [ {{TermObjects}} ] 

}' 
```

1.  \*\*Workflow Application Search \*\*

    \{{status of the application\}} - Status of the application we want to search &#x20;

```
curl --location 'https://portal.igot-dev.in/api/workflow/taxonomy/search' \  

--header 'userToken: {{userToken}}' \  

--header 'Authorization: bearer {{api-key}}' \ 

--header 'Content-Type: application/json' \ 

 --data '{    

             "serviceName": "taxonomy",  

              "applicationStatus": "{{status of the application}}"  

}' 
```

1. \*\*Workflow Application Read \*\*

\{{wfId\}} - wfId of the application&#x20;

```
curl --location 'https://portal.igot-dev.in/api/workflow/taxonomy/read/{{wfId}}' \ 

--header 'userToken: {{userAuthToken}}' \ 

--header 'Authorization: bearer {{api-key}}' 
```

1. **Workflow Transition**

\{{wfId\}} - wfId of the application \\

1. **Approve Level 2** &#x20;

```
curl --location --request PATCH 'https://portal.igot-dev.in/api/workflow/taxonomy/update' \ 

--header 'userToken: {{userAuthToken}}' \ 

--header 'Authorization: bearer {{api-key}}' \ 

--header 'Content-Type: application/json' \ 

--data '{ 

    "wfId": "{{wfId}}", 

    "state": "SEND_FOR_REVIEW_L1", 

    "action": "APPROVE",  

    "serviceName": "taxonomy" 

}'  
```

1. **Approve Level 2** &#x20;

```
curl --location --request PATCH 'https://portal.igot-dev.in/api/workflow/taxonomy/update' \ 

--header 'userToken: {{userAuthToken}}' \ 

--header 'Authorization: bearer {{api-key}}' \ 

--header 'Content-Type: application/json' \ 

--data '{ 

    "wfId": "{{wfId}}", 

    "state": "SEND_FOR_REVIEW_L2", 

    "action": "APPROVE", 

    "serviceName": "taxonomy" 

}' 
```

1. **Publish** &#x20;

```
curl --location --request PATCH 'https://portal.igot-dev.in/api/workflow/taxonomy/update' \ 

--header 'userToken: {{userAuthToken}}' \ 

--header 'Authorization: bearer {{api-key}}' \ 

--header 'Content-Type: application/json' \ 

--data '{ 

    "wfId": "{{wfId}}", 

    "state": "SEND_FOR_PUBLISH", 

    "action": "APPROVE", 

    "serviceName": "taxonomy" 

}' 
```

***

\[\[category.storage-team]] \[\[category.confluence]]

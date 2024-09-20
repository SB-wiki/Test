# Migration-from-QUML-0.5-to-QUML-1.0-version

### Requirement

Old 'PracticeQuestionSet' contents created on the platform do not show print options in the application. Such 'PracticeQuestionSet' are to be modified to show print options.

### Solution

To achieve this, Questions should be updated in QUML version 1.0 format which contains property such as  _**editorstate**_  and  _**responseDeclaration**_   _**Itemsets**_  has to be created from updated  _**questions**_  and linked to  _**content**_  if the content is live it has to  _**publish**_  again

### Migration Steps

* **Step 1** : Get the content which doesn't have itemset property using composite search

```json
  EndPoint: /composite/v3/search
  requestParameters:  
  {
  		  "request": {
  		    "exists": "questions",
  		    "filters": {
  		      "contentType": "PracticeQuestionSet",
  		      "medium": "English",
  		      "objectType": "Content"
  		    },
  		    "not_exists": "itemSets",
  		    "sort_by": {
  		      "createdOn": "desc"
  		    }
  		  }
  		}

```

* **Step 2** : Get the question from content

```
  EndPoint: /assessment/v3/items/read

```

* **Step 3** : update the structure as per QUML version 1.0 which is to add editorState and responseDeclaration and update the question

```
  EndPoint: /assessment/v3/items/update/

```

* **Step 4** : Create the itemset using items/Questions

```
  EndPoint: /itemset/v3/create
  requestParameter: 
  {
      "request": {
          "itemset": {
              "code": UUID,
              "name": value.name,
              "description": value.name,
              "language": language,
              "owner": author,
              "items": itemset
          }
      }
  }

```

* **Step 5** : update content with itemset

```
 	Endpoint: /content/v3/update/
 	requestParameters:
 	{
     "request": {
       "content": {
         "itemSets": [
           {
             "identifier": itemSetIdentifier
           }
         ],
         "versionKey": versionKey
       }
     }
   }  

```

* Step 6: Publish content if status of content is live

```json
  	EndPoint: /content/v3/publish/
  	requestParameters:
  	 {
          "request": {
            "content": {
              "publisher": "EkStep",
              "lastPublishedBy": "EkStep"
            }
          }
        }
```

***

\[\[category.storage-team]] \[\[category.confluence]]

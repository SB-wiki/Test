# Deletion-of-inactive-user-Org-accounts

### Overview :

There are multiple user accounts created by states that have never been used/ been inactive for extended periods for time. As states move to officially onboard users (SSO, self sign up etc.), there is a need to clean up these legacy accounts.This will require a 'hard delete' so as to free up mobile numbers/ email IDs associated with them, if any.Active accounts for a state will be retained post validation with the state: Users who have created or created content, corse mentors, batch creators etc. will be retained in the system. [SB-10454](https://project-sunbird.atlassian.net/browse/SB-10454)  and [SB-10455](https://project-sunbird.atlassian.net/browse/SB-10455)

### Problem statement :

Since user details are spread across different systems and we need to remove it from all places. and same applicable for org as well.

Solution 1: Sunbird can expose an API to do user/org hard delete. Api structure will be as follow:

```js
Method : DELETE
URL: v1/data/delete
Request body :

 {
  "request": {
            "objectIds" : [],
            "objectType" : ""    
       }
   }

Response body: 
 {
    "id": "api.data.delete",
    "ver": "v1",
    "ts": "2019-02-06 05:21:18:948+0000",
    "responseCode": "OK",
    "result": {
        "response": {
            
        }
    }
}

```

### Solution 2:

&#x20;Sunbird will expose different end point to delete object based on object type. Api structure will be as follow:

```js
Method : DELETE
URL: v1/user/delete
Request body :

 {
  "request": {
            "userIds" : []  
       }
   }

Response body: 
 {
    "id": "api.user.delete",
    "ver": "v1",
    "ts": "2019-02-06 05:21:18:948+0000",
    "responseCode": "OK",
    "result": {
        "response": {
            
        }
    }
}

-- Similar it will have for org delete as well
URL: v1/org/delete
Request body :

 {
  "request": {
            "orgIds" : []  
       }
   }



```

Since this api will do all operations in background, it will do initial request validation and all other validation will be handle in background.

| Pros                                    | Cons |
| --------------------------------------- | ---- |
| Api will have more control on consumer  |      |
| Easy to generate Audit logs             |      |
| Easy for consumer to invoke             |      |
|                                         |      |

### Solution 3 :

&#x20;  Write an ETL job to preform same operations. ETL job will do following operations:

| User | Organisation |
| ---- | ------------ |
|      |              |

1. Find identifier of all those users, whom you want to delete.
2. Delete those users from Elasticsearch using ES delete api.&#x20;
3. in ES user need to delete from following index type (user,userprofilevisibility,usercourses,usernotes)
4. &#x20;Delete user from Keycloak, using keycloak delete end point
5. Delete user from cassandra : following tables will be involved (user,user\_courses,user\_skills,address, user\_badge\_assertion,user\_org,usr\_external\_identity,user\_job\_profile,user\_notes,user\_education)&#x20;

|

1. Find org ids that need to be deleted
2. Delete organisation from elasticsearch
3. &#x20;Delete organisation details from cassandra. Data need to be deleted from following tables(organisation,user\_org,org\_external\_identity,address)

\| | | |

| Pros                                      | Cons                                                                                                       |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Standalone job to perform this operation. |  Difficult to control caller , Ex: caller is not identified by sunbird                                     |
|                                           | Can't reuse it for later use case: Example: Org admin want's to delete some user or delete some of the org |

### Solution 4 :

Provide sequence of CQL queries and curl command to do all above operations.

***

\[\[category.storage-team]] \[\[category.confluence]]

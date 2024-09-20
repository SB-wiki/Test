# Overview :

&#x20;There is a need in **sunbird** platform to identify user and org based on their external id and provider, instead of identifying them using there ids.&#x20;

**Problem statement** : [Ticket Ref: SC-879](https://project-sunbird.atlassian.net/browse/SC-879)

&#x20; As of now in some APIs , sunbird identifies organisation based on externalId and provider key in following cases.

&#x20; 1\. Add user to org

&#x20;  2\. assign roles

&#x20;   Now the problem is we need to support above api's to identify user based on  user's externalId, idtype and provider.

&#x20; &#x20;

```js
// Old api structure
{
"request": {
      "userId":"identity of user",
      "externalId":"orgExternalId",
      "provider":"org provider",
       "organisationId":"org Id." ,
      "roles":[]    
   }

}

// new Structure
{
"request": {
      "userExternalId":" user external id",
      "userIdType": "id type of user",
      "userProvider": "user id type provider",
      "externalId":"orgExternalId",
      "provider":"org provider",
      "organisationId":"org Id." ,
      "userId":"userId"
      "roles":[]    
   }

}


Note: 
1. Code will first check for userId : if userId present then it will ignore (userExternalId,userIdType,userProvider) and validation will be done for provided userId only. If userId absent then it will fetch user id based on (userExternalId,userIdType,userProvider) attribute.
2. organisationId : if present then all validation will occur on same, other wise orgId will be fetched from externalId and provider.



```

| Attribute      | status                                                        |
| -------------- | ------------------------------------------------------------- |
| userExternalId | required if userId absent                                     |
| userIdType     |  required if userExternalId present                           |
| userProvider   | required if userExternalId  present                           |
| userId         |  required if userExternalId absent                            |
| organisationId | required if externalId absent                                 |
| externalId     | required if organisationId absent                             |
| provider       | required if externalId present                                |
| roles          | required for assign roles api , for add members it's optional |

&#x20;&#x20;

After few releases we propose to change this names as follows:

| **User**                    | **Org**                     |
| --------------------------- | --------------------------- |
| userExternalId (externalId) |  orgExternalId (externalId) |
| userProvider (provider)     | orgProvider (provider)      |
| userIdType (idType)         |                             |

***

\[\[category.storage-team]] \[\[category.confluence]]

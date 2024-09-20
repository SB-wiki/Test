# Course-batch-permission-design

**Overview:** Sunbird course batch api is built to manage batches of courses available. There are two type of batch ( Open , invite only). For open batch there is no mentors and is for self enrollment. For invite only batch creator need to add mentors and participants. As of now we can add mentors to a batch, but we can't remove it. There is no way to remove added mentors/participants from a batch.&#x20;

**Problem Statement:**   How to add permission to the mentors, so that they can manage the batches. &#x20;

&#x20; As requirement has changed , so there is no concept of permission , all added mentors will have default access of batch edit. So no changes required for handling permission.

\*\*Proposed Solution 1:  \*\* \*\*      \*\* Inside course-batch table a new map will be added , that map will hold userId and permission details.&#x20;

Changes in create batch api: Will add  a new field .

* &#x20;permissions type  (Map)

&#x20; **Request** :

{"request":{"courseId":"courseId","name":"batch logical name","description":"about course batch","enrollmentType":"invite-only","startDate":"start date","endDate":"enddate",

"createdFor":\["list of org ids"],"mentors":\["lsit of mentors"],

"permissions": {  // new field

&#x20;         "userId":\["permissionList"]

&#x20;       \}}}

&#x20;  Changes inside course batch table:

&#x20;          1.1 Column name permissions type Map \<text, bit>&#x20;

| Pros | Cons |
| ---- | ---- |
|      |      |

1. consume less memory

|

1. &#x20;Overhead of converting bit roles to user friendly string during sending response
2. &#x20;System need to have mapping for bit to string&#x20;

|

&#x20;            1.2 Column name permissions type Map \<text, text>&#x20;

| Pros                                                                                                                                                               | Cons                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| <ul><li>Permission will be super set of lower permissions </li><li>No overhead of permission value conversion at response time</li><li>No extra mapping </li></ul> | <ul><li>increase in the additional request parameter </li><li>Increase complexity to define permission subset </li></ul> |

&#x20;          1.3 Column name permissions type Map \<text, List>&#x20;

| Pros                                                                                                                                                                    | Cons                                                                                                  |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| <ul><li>Permission will contains the list of all permissions available to mentors</li><li>Easy to Manage , any time some permission can be revoked or added. </li></ul> | <ul><li>increase the additional request parameter </li><li>it will take little more storage</li></ul> |

**Solution 2 :** \*\*   \*\* Change existing request structure , to support permission list, As of now we are taking mentors as list data type , now it will become map that will support mentorId and it's roles. &#x20;

\*\* Request\*\* :

{"request":{"courseId":"courseId","name":"batch logical name","description":"about course batch","enrollmentType":"invite-only","startDate":"start date","endDate":"enddate",

"createdFor":\["list of org ids"],"mentors":         {

&#x20;         "userId": \[list of role]

&#x20;        }

\}}

&#x20; Change the structure of mentors object and store data in same table.

| Pros                                      | Cons                                                                                                                                                                                            |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <ul><li>clean request structure</li></ul> | <ul><li>Data migration required </li><li>Elasticsearch will have issues for changing data type</li><li>Need to create V2 version</li><li>V1 response structure need to be maintained.</li></ul> |

Alternative 1: Storing mentor permissions in new table&#x20;

| Pros                                                   | Cons                                                                                                                                                                                              |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <ul><li>Separation of permission and batch  </li></ul> | <ul><li>Increase Db read/write operation </li><li>Additional development effort for maintaining new DB table</li><li>Cassandra is not suitable for reading data from different-2 table.</li></ul> |

**Solution 3:** \*\*       \*\* We can introduce a new role , which will allow user to edit course batch, It means when i add a course mentor and that mentor having new roles then system will allow them to edit course batch.

| Pros                                                                                                                                                            | Cons                                                                                                                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <ul><li>  Minimal code change required</li><li> There is no separate permission , that need to be manage , it will be define based on user role only.</li></ul> | <ul><li> Need to maintain one more role</li><li>Cross org roles need to be manage : Ex: suppose batch is created for org1 and we added a mentor who belongs to org2 but both are in same rootOrg , how to handle this?</li></ul> |

**Problem Statement 2** Current problem with sunbird platform is, you can add user to a course batch, but you can not remove user also there is no provision to add or remove mentors&#x20;

**Problem Statement:** How to add or remove participants or mentors into a batch&#x20;

**Accepted design is as follow:**

* &#x20; To add participant or mentors , sunbird will use create batch api. So Create batch api need to be enhanced to support participant addition.
* &#x20;To update mentors or participant , sunbird will use updated batch api. In update batch api what ever mentors or participants list user will pass that will be replaced with existing one.
* &#x20;Add mentors or participant will be allowed if batch is not closed yet.
* &#x20;Add mentors or participant will be allowed for invite-only batch.

&#x20; &#x20;

&#x20; &#x20;

```js
Request for create batch api: 
"request": {
    "courseId": "string",
    "name": "string",
    "description": "string",
    "enrollmentType": "string",
    "startDate": "string",
    "endDate": "string",
    "createdFor": [
      "string"
    ],
    "mentors": [
      "string"
    ],
    "participants": [
      "string"
    ]
  }
```

&#x20;

```js
Request for update batch api:
"request": {
    "createdFor": [
      "string"
    ],
    "endDate": "string",
    "startDate": "string",
    "description": "string",
    "name": "string",
    "id": "string",
    "mentors": [
      "string"
    ],
    "participants": [
      "string"
    ]
  }
```

| Pros                                                                                                                                                                                                                        | Cons                                                                                                                                                                                                                                                                                                                                                         |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <ul><li>Api call will reduce , only one request to create batch, add mentors and participant</li><li>removal of mentors and participant can be handle during update batch api call, here also network call reduce</li></ul> | <ul><li>Three different operation are merged together , so any one business logic will change , can impact others as well.</li><li>One api is having different set of responsibility , so requirement for particular changes (mentors addition logic modified), developer need to understand the business logic for batch , participant as well.  </li></ul> |

Developer will implement  above solution.

Alternative 1:

&#x20;          Provide a separate method for removing mentors and participants.

&#x20;          Request :

&#x20;                       {

&#x20;                       "participants": \["list of participants that need to be removed"],

&#x20;                       "mentors" : \["list of mentors that need to be removed"]

&#x20;                      }&#x20;

| Pros                                                                                                                                                                  | Cons                                                                                       |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| <ul><li>Separate call based on functionality (as add and remove are two different operations)</li><li>code readability</li><li>no changes in existing api. </li></ul> | <ul><li>Caller need to make one more api call for removing mentors/participants.</li></ul> |

Alternative 2:

Create one request for Add and remove : In this approach caller need to pass complete list of mentors and participants and system will replace it.&#x20;

| Pros                                                          | Cons                                                                                                                                                                                  |
| ------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <ul><li>There is only one api call to add or remove</li></ul> | <ul><li>Can be more risk in future change request, because two operations are combined in one call.</li><li>Need to add v2 , can't modify existing v1 add members to batch </li></ul> |

Alternative 3:

&#x20;  Create one request for Add and remove : In this approach caller need to pass partial list only , based on list data system will decide , it need to be removed or added

&#x20;

| Pros                                                                                                       | Cons                            |
| ---------------------------------------------------------------------------------------------------------- | ------------------------------- |
| <ul><li>No need to send complete list always</li><li>There is only one api call to add or remove</li></ul> | <ul><li>same as above</li></ul> |

&#x20;

Alternative 4:

&#x20;  Create one request for Add and remove : In this approach caller need to pass map of participant and mentors as follow.

&#x20; &#x20;

&#x20;Request :

&#x20;                     {

&#x20;                       "participants": {

&#x20;                                      "userId":"operation" // add or removed

&#x20;                                          }

&#x20;                       "mentors" : {

&#x20;                                      "userId":"operation" // add or removed

&#x20;                                   }

&#x20;                      }&#x20;

Alternative 5:

&#x20;  Create one request for Add and remove : In this approach caller need to pass  list of map of users as follow.

&#x20; &#x20;

&#x20;Request :

&#x20;                     {

&#x20;                       "users": \[{

&#x20;                                      "userId":"",

&#x20;                                      "operation":"add/remove",

&#x20;                                      "userType":"mentor/participant"

&#x20;                                   },

&#x20;                                    ]

&#x20;                      }&#x20;

Task Ref: [SB-6998 System JIRA](https://browse/SB-6998)

[SB-6741 System JIRA](https://browse/SB-6741)

&#x20;  &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

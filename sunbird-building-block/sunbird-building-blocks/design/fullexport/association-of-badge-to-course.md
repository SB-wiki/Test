# Association-of-badge-to-course

**Problem statement:** \*\* \*\* As a sunbird system, it should have capability to associate/disassociate badge to/from course. Whenever any course batch is created, the batch inherits the associated badge. And the participant of the batch gets the same badge on completion of course.

**Description**

We need to expose two API endpoint to associate/dissociate badge to course.

&#x20;        **POST badging/v1/content/association/create**

```
Request body :- 

{
	"request" : {
		"contentId" : " ",
 		"badgeId"  : " ",
        "issuerId" : " "
	}
}

Response Body:-

{
    "id": "api.badging.content.association.create",
    "ver": "v1",
    "ts": "2019-01-31 11:31:47:381+0530",
    "params": {
        "resmsgid": null,
        "msgid": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS"
    }
}
```

&#x20;       **POST badging/v1/content/association/delete**

```
Request Body :-

{
	"request" : {
		"content" : " ",
		"badgeId" : " ",
		"issuerId" : " "
	}
}

Response Body :-

{
	"id": "api.badging.content.association.delete",
	"ver": "v1",
	"ts": "2019-01-31 11:31:47:381+0530",
	"params": {
		"resmsgid": null,
		"msgid": "8e27cbf5-e299-43b0-bca7-8347f7e5abcf",
		"err": null,
		"status": "success",
		"errmsg": null
	},
	"responseCode": "OK",
	"result": {
	"response": "SUCCESS"
	}
}
```

Problem Statement 1:

What is the data model for storing badge and course association information?

**Proposed Solution 1:**

As badge association is course based property and course object is stored inside Learning Platform. We can update the badge details in course object on every associate/dissociate request. The structure of badgeAssociations is as follows:-

| content          |                  |
| ---------------- | ---------------- |
| badgeAssociation | Map\<text, text> |

|   | name            | data type | Description                                          |
| - | --------------- | --------- | ---------------------------------------------------- |
| 1 | issuerId        | String    | Issues the badge                                     |
| 2 | badgeId         | String    | Id of the badge                                      |
| 3 | associatedTS    | ?         | Timestamp at which badge is associated to the course |
| 4 | badgeClassImage | String    | badge image url                                      |
| 5 | badgeClassName  | String    | name of the badge class                              |

\*\*For Association Request :- \*\* Iterate over all the badgeAssociatedInfo list from course object and check for status flag as true(if present). Will reset that particular flag to false, adding the new requested badge with status flag as true in course object and update it.

**For Dissociation Request :-** Iterate over all the badgeAssociatedInfo list from course object and check for status flag as true(if present) for the requested badge. Will reset that particular flag to false and update it.

The structure of content is expected as:-

```
{

"....,

"badgeAssociationInfo": [

{
	"issuerId": "issuerslug-398",

	"associationId": "10c8489e-7e7b-472e-90ee-714b9b961f94",

	"badgeClassImage": "https://sunbirddev.blob.core.windows.net/badgr/uploads/badges/2708a6facc3de4eb14100429bf6ef56d.png",

	"badgeId": "badgeslug-841",

	"badgeClassName": "FT_badge_class",

	"associatedTS": 1545397432795,

	"status": "true"
},

{
	"issuerId": "issuerslug-398",

	"associationId": "10c8489e-7e7b-472e-90ee-714b9b961f94",

	"badgeClassImage": "https://sunbirddev.blob.core.windows.net/badgr/uploads/badges/2708a6facc3de4eb14100429bf6ef56d.png",
	
	"badgeId": "badgeslug-841",

	"badgeClassName": "FT_badge_class",

	"associatedTS": 1545397432795,

	"status": "false"
},
],

....}]}}



```

**On batch creation:-** Iterate over all the badgeAssociationInfo from the courseObject and associate the badge for which status is true(if any). We need to store the corresponding badge details in course\_batch table.

We can add badgeId in course\_batch table.

| name            | dataType | description                    |
| --------------- | -------- | ------------------------------ |
| badgeId         | String   | uniquely identifies the badge. |
| issuerId        |          |                                |
| badgeClassName  |          |                                |
| badgeClassImage |          |                                |

| Pros                                                                 | Cons                                                                                          |
| -------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| Isolation of the course related info will be maintained with the LP. | We need to iterate over the list for every association/disassociation/batch-creation request. |

**Proposed Solution 2:**

We can store the badge association information in new table content\_badge\_association. The structure of the table will be :-

| name            | dataType  | description                                                                    |
| --------------- | --------- | ------------------------------------------------------------------------------ |
| contentId\*     | String    | uniquely identifies the courseId                                               |
| badgeIId\*      | String    | uniquely identifies the badgeId                                                |
| issuerId        | String    | uniquely identifies the issuerId                                               |
| badgeClassImage | String    | image url of the badge                                                         |
| badgeClassName  | String    | name of the badge                                                              |
| createdOn       | Timestamp | Timestamp at which the badge is associated with the courseId                   |
| status          | boolean   | states badge is currently associated to the course or not.Needs to be indexed. |
| lastUpdatedOn   | TimeStamp | Timestamp at which badge association is updated.                               |
| createdBy       |           |                                                                                |
| lastUpdatedBy   |           |                                                                                |

composite primary key :- ( **courseId, badgeId** )

\*\*For Association Request :- \*\*

1. If the requested badge is not associated with the course(i.e. if combination of courseId, badgeId is not present in the table), we will insert a row with status flag as true. Also, we will get all the other badge corresponding to the courseId and update the status flag to false(if exists) with the updatedTS.
2. But if the combination of courseid, badgeId is present, status will be checked and will be set to True if not already. Also, we will get all the other badge corresponding to the courseId and update the status flag to false(if exists with true) with the updatedTS.

**For Dissociation Request :-** Get the required course badge association information from the table(If it is there) and set the status flag as false with the updated timestamp.

\*\*On batch creation:- \*\* Get the active badge from course\_badge\_association table based on (courseId, badgeId, status=true) and impart the corresponding badge information to course\_batch table. We can store the badge information in course\_batch similar way as we have in proposed solution 1.

| Pros                                                                                              | Cons                                                                                                                       |
| ------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| We can directly access the current active badge associated with the course without any iteration. | Sunbird platform will have the course related information. Hence the isolation of course related info will be compromised. |

***

\[\[category.storage-team]] \[\[category.confluence]]

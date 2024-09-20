User roles were removed from user and user-organisation entity and added to user_roles table, as part of the user-org generalization changes ([[User/Org Data Model Changes for 3.9|User-Org-Data-Model-Changes-for-3.9]]). This change was done in release-4.0.0 and backward compatibility is maintained in user related api’s. Now in release-4.1.0 the request and response structure is going to change for assign roles api. Also for user read api and user search api.

 **Build release version: 4.1.0** 

 **Assign Role API changes:** 

 **Existing assign role api version 1** : /v1/user/assign/role

Request: 


```json
{
    "request": {
        "userId": "db60b23d-6aad-4344-a32a-7285afa4fc68",
        "organisationId":"0130107621805015045",
        "roles":["COURSE_CREATOR", "CONTENT_CREATOR"]
    }
}
```
This request does not support the new role structure with scope.

 **New V2 version of Assign Role API :** 

In new version, v2 assign roles api, request will have the option to pass scope along with role. The scope is currently supporting organisationId, later it can be extended to support programId or location or language as per the requirement.

V2 API endpoint: /v2/user/assign/role

Two different approaches are proposed for assign role api request. “PUBLIC” role is not saved to DB.

 **Approach 1: Request with out operation type** : 


* Assume that the user is already having existing roles - “ORG_ADMIN” and “CONTENT_CREATOR”. With this request the scope of existing roles that are present will be updated and remaining will be deleted. If any new roles, those will be added to the DB. 


* In below example, ORG_ADMIN will be deleted, ”CONTENT_CREATOR” will be updated and “COURSE_CREATOR” will be added. 


* ”CONTENT_CREATOR” role is being updated means, the scope is getting replaced with the new scope that is coming in request.


* If we want to remove all roles, we need to pass “PUBLIC” as default role. But this will delete all roles, but will not add public to DB.




```json
{
	"request": {
		"userId": "db60b23d-6aad-4344-a32a-7285afa4fc68",
		"roles": [{
				"role": "COURSE_CREATOR",
				"scope": [{
						"organisationId": "0130107621805015045"
					},
					{
						"organisationId": "0130107621805015068"
					}
				]
			},
			{
				"role": "CONTENT_CREATOR",
				"scope": [{
					"organisationId": "0130107621805015045"
				}]
			}
		]
	}
}
```
 **Approach 2: Request with operation type** :   


*  **add**  operation will contain scope w.r.t the roles. if not already existing, the role will be added. If already existing ignore it.


*  **remove**  operation will remove the scope of the existing role. If there is no scope in a role, then the role itself will be deleted.




```json
{
	"request": {
		"userId": "db60b23d-6aad-4344-a32a-7285afa4fc68",
		"roles": [
		    {
				"role": "COURSE_CREATOR",
				"operation": "add"
				"scope": [{
						"organisationId": "0130107621805015045"
					},
					{
						"organisationId": "0130107621805015068"
					}
				]
			},
			{
				"role": "ORG_ADMIN",
				"operation": "remove",
				"scope": [{
						"organisationId": "0130107621805015045"
					},
					{
						"organisationId": "0130107621805015068"
					}
				]
			}
		]
	}
}
```
 **Accepted Solution :** Opting for approach 2, as per the new UI design.

 **User-search API changes:** 

In user-search API, the request and response is going to have change according to the new role structure:

User-search api version 2, request for searching users based on roles is as below:


```json
{
    "request": {
        "filters": {
            "organisations.roles": ["COURSE_CREATOR"]
        },
        "limit":20,
        "offset": 0
    }
}
```
In user-search api version 2, roles are returned in the organisation sub-entity in the user entity as shown below.

Existing search api response: /v2/user/search/


```json
{
    "id": "api.user.search",
    "ver": "v2",
    "ts": "2021-06-15 15:18:58:527+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8cb4db2ea484e34c6a653219a22cb2b5",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "count": 1,
            "content": [
                {
                    "lastName": null,
                    "maskedPhone": null,
                    "tcStatus": null,
                    "aadhaarno": null,
                    "rootOrgName": "CustROOTOrg10",
                    "roles": [],
                    "channel": "custchannel",
                    "prevUsedPhone": "",
                    "updatedDate": null,
                    "stateValidated": false,
                    "isDeleted": false,
                    "organisations": [
                        {
                            "organisationId": "01285019302823526477",
                            "updatedBy": null,
                            "orgName": "CustROOTOrg10",
                            "addedByName": null,
                            "addedBy": null,
                            "associationType": 1,
                            "roles": [
                                "COURSE_CREATOR"
                            ],
                            "approvedBy": null,
                            "updatedDate": null,
                            "userId": "fc5b0ad2-f02a-4755-a2d1-aa7a889f6aab",
                            "approvaldate": null,
                            "isDeleted": false,
                            "hashTagId": "01285019302823526477",
                            "isRejected": null,
                            "id": "0132925409719910400",
                            "position": null,
                            "isApproved": null,
                            "orgjoindate": "2021-06-02 08:50:03:678+0000",
                            "orgLeftDate": null
                        }
                    ],
                    "managedBy": null,
                    "provider": null,
                    "countryCode": null,
                    "flagsValue": 0,
                    "maskedEmail": "us*******@yopmail.com",
                    "id": "fc5b0ad2-f02a-4755-a2d1-aa7a889f6aab",
                    "regorgid": null,
                    "recoveryEmail": "",
                    "email": "us*******@yopmail.com",
                    "identifier": "fc5b0ad2-f02a-4755-a2d1-aa7a889f6aab",
                    "updatedBy": null,
                    "tcUpdatedDate": null,
                    "recoveryPhone": "",
                    "userName": "user10111",
                    "rootOrgId": "01285019302823526477",
                    "userId": "fc5b0ad2-f02a-4755-a2d1-aa7a889f6aab",
                    "prevUsedEmail": "",
                    "firstName": "user10111",
                    "profileLocation": [
                        {
                            "id": "82b60d1c-8e84-4b66-b328-ee030b790196",
                            "type": "district"
                        },
                        {
                            "id": "5972c144-a7b3-4ac3-a3a1-3c0a6a138199",
                            "type": "state"
                        }
                    ],
                    "createdDate": "2021-06-02 08:50:02:422+0000",
                    "framework": {},
                    "tncAcceptedOn": null,
                    "allTncAccepted": {},
                    "createdBy": null,
                    "phone": "",
                    "profileUserType": {
                        "subType": null,
                        "type": "teacher"
                    },
                    "dob": null,
                    "tncAcceptedVersion": null,
                    "status": 1
                }
            ]
        }
    }
}
```
In release-4.1.0, new user-search api version 3 is getting added, in which the request and response is going to change as per the new role structure. 

User-search api version 3, request for searching users based on roles is as below:


```json
{
    "request": {
        "filters": {
            "roles.role": ["COURSE_CREATOR"]
        },
        "limit":20,
        "offset": 0
    }
}
```
In user-search api version 3, roles are returned in the  user entity as shown below.

Version 3 user-search api response: /v3/user/search/


```json
{
    "id": "api.user.search",
    "ver": "v3",
    "ts": "2021-06-15 15:18:58:527+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8cb4db2ea484e34c6a653219a22cb2b5",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "count": 1,
            "content": [
                {
                    "lastName": null,
                    "maskedPhone": null,
                    "tcStatus": null,
                    "aadhaarno": null,
                    "rootOrgName": "CustROOTOrg10",
                     "roles": [{
                        "role": "COURSE_CREATOR",
                        "scope": [
                          {
                            "organisationId": "0130107621805015045"
                          },
                          {
                            "organisationId": "0130107621805015084"
                          }
                          ]
                    }],
                    "channel": "custchannel",
                    "prevUsedPhone": "",
                    "updatedDate": null,
                    "stateValidated": false,
                    "isDeleted": false,
                    "organisations": [
                        {
                            "organisationId": "01285019302823526477",
                            "updatedBy": null,
                            "orgName": "CustROOTOrg10",
                            "addedByName": null,
                            "addedBy": null,
                            "associationType": 1,
                            "approvedBy": null,
                            "updatedDate": null,
                            "userId": "fc5b0ad2-f02a-4755-a2d1-aa7a889f6aab",
                            "approvaldate": null,
                            "isDeleted": false,
                            "hashTagId": "01285019302823526477",
                            "isRejected": null,
                            "id": "0132925409719910400",
                            "position": null,
                            "isApproved": null,
                            "orgjoindate": "2021-06-02 08:50:03:678+0000",
                            "orgLeftDate": null
                        }
                    ],
                    "managedBy": null,
                    "provider": null,
                    "countryCode": null,
                    "flagsValue": 0,
                    "maskedEmail": "us*******@yopmail.com",
                    "id": "fc5b0ad2-f02a-4755-a2d1-aa7a889f6aab",
                    "regorgid": null,
                    "recoveryEmail": "",
                    "email": "us*******@yopmail.com",
                    "identifier": "fc5b0ad2-f02a-4755-a2d1-aa7a889f6aab",
                    "updatedBy": null,
                    "tcUpdatedDate": null,
                    "recoveryPhone": "",
                    "userName": "user10111",
                    "rootOrgId": "01285019302823526477",
                    "userId": "fc5b0ad2-f02a-4755-a2d1-aa7a889f6aab",
                    "prevUsedEmail": "",
                    "firstName": "user10111",
                    "profileLocation": [
                        {
                            "id": "82b60d1c-8e84-4b66-b328-ee030b790196",
                            "type": "district"
                        },
                        {
                            "id": "5972c144-a7b3-4ac3-a3a1-3c0a6a138199",
                            "type": "state"
                        }
                    ],
                    "createdDate": "2021-06-02 08:50:02:422+0000",
                    "framework": {},
                    "tncAcceptedOn": null,
                    "allTncAccepted": {},
                    "createdBy": null,
                    "phone": "",
                    "profileUserType": {
                        "subType": null,
                        "type": "teacher"
                    },
                    "dob": null,
                    "tncAcceptedVersion": null,
                    "status": 1
                }
            ]
        }
    }
}
```


 **User-read API changes:** 

In earlier releases roles data use to come in roles attribute in user entity and the same data comes in roles attribute of organisations sub-entity. 

Read api: /v4/user/read/:uid


```json
{
    "id": "api.user.read.7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
    "ver": "v4",
    "ts": "2021-06-07 11:30:12:463+0530",
    "params": {
        "resmsgid": null,
        "msgid": "330973f3-462a-4c07-b803-83c6cb7cfc93",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "maskedPhone": null,
            "channel": "channel1003",
            "updatedDate": null,
            "managedBy": null,
            "flagsValue": 0,
            "id": "7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
            "recoveryEmail": "",
            "identifier": "7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
            "updatedBy": null,
            "rootOrgId": "0130107621805015045",
            "prevUsedEmail": "",
            "firstName": "localtest2",
            "isMinor": false,
            "profileLocation": [],
            "tncAcceptedOn": null,
            "allTncAccepted": {},
            "phone": "",
            "dob": "1992-12-31",
            "status": 1,
            "lastName": "localtest2",
            "roles": [],
            "prevUsedPhone": "",
            "stateValidated": false,
            "isDeleted": false,
            "organisations": [
                {
                    "isSelfDeclaration": false,
                    "organisationId": "0130107621805015045",
                    "updatedBy": null,
                    "addedByName": null,
                    "addedBy": null,
                    "associationType": 1,
                    "roles": [
                        "ORG_ADMIN"
                    ],
                    "approvedBy": null,
                    "updatedDate": null,
                    "userId": "7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
                    "approvaldate": null,
                    "isSystemUpload": false,
                    "isDeleted": false,
                    "hashTagId": "0130107621805015045",
                    "isSSO": true,
                    "isRejected": null,
                    "id": "0132939576857231360",
                    "position": null,
                    "isApproved": null,
                    "orgjoindate": "2021-06-04 14:20:19:254+0530",
                    "orgLeftDate": null
                }
            ],
            "countryCode": null,
            "maskedEmail": "lo********@yopmail.com",
            "email": "lo********@yopmail.com",
            "rootOrg": {
                "keys": {},
                "channel": "channel1003",
                "description": null,
                "updatedDate": null,
                "organisationType": null,
                "isTenant": null,
                "provider": "channel1003",
                "id": "0130107621805015045",
                "email": null,
                "slug": "channel1003",
                "isSSOEnabled": false,
                "orgName": "localrootorg3",
                "updatedBy": null,
                "locationIds": [],
                "externalId": "localrootorg3",
                "orgLocation": [],
                "isRootOrg": true,
                "rootOrgId": "0130107621805015045",
                "isDefault": null,
                "createdDate": "2020-04-30 11:46:02:202+0530",
                "createdBy": null,
                "hashTagId": "0130107621805015045",
                "status": 1
            },
            "tcUpdatedDate": null,
            "recoveryPhone": "",
            "userName": "localtest2",
            "userId": "7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
            "promptTnC": true,
            "createdDate": "2021-06-04 14:20:16:861+0530",
            "framework": {},
            "createdBy": null,
            "profileUserType": {},
            "tncAcceptedVersion": null
        }
    }
}
```


In the upcoming release-4.1.0 the roles attribute will be removed from organisations sub-entity and it will be in the  user main entity with following structure.

New version 5 read api response : /v5/user/read/:uid


```json
{
    "id": "api.user.read.7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
    "ver": "v5",
    "ts": "2021-06-07 11:30:12:463+0530",
    "params": {
        "resmsgid": null,
        "msgid": "330973f3-462a-4c07-b803-83c6cb7cfc93",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "maskedPhone": null,
            "channel": "channel1003",
            "updatedDate": null,
            "managedBy": null,
            "flagsValue": 0,
            "id": "7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
            "recoveryEmail": "",
            "identifier": "7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
            "updatedBy": null,
            "rootOrgId": "0130107621805015045",
            "prevUsedEmail": "",
            "firstName": "localtest2",
            "isMinor": false,
            "profileLocation": [],
            "tncAcceptedOn": null,
            "allTncAccepted": {},
            "phone": "",
            "dob": "1992-12-31",
            "status": 1,
            "lastName": "localtest2",
            "roles": [{
                        "role": "ORG_ADMIN",
                        "scope": [
                          {
                            "organisationId": "0130107621805015045"
                          },
                          {
                            "organisationId": "0130107621805015084"
                          }
                          ]
                    }],
            "prevUsedPhone": "",
            "stateValidated": false,
            "isDeleted": false,
            "organisations": [
                {
                    "isSelfDeclaration": false,
                    "organisationId": "0130107621805015045",
                    "updatedBy": null,
                    "addedByName": null,
                    "addedBy": null,
                    "associationType": 1,
                    "approvedBy": null,
                    "updatedDate": null,
                    "userId": "7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
                    "approvaldate": null,
                    "isSystemUpload": false,
                    "isDeleted": false,
                    "hashTagId": "0130107621805015045",
                    "isSSO": true,
                    "isRejected": null,
                    "id": "0132939576857231360",
                    "position": null,
                    "isApproved": null,
                    "orgjoindate": "2021-06-04 14:20:19:254+0530",
                    "orgLeftDate": null
                }
            ],
            "countryCode": null,
            "maskedEmail": "lo********@yopmail.com",
            "email": "lo********@yopmail.com",
            "rootOrg": {
                "keys": {},
                "channel": "channel1003",
                "description": null,
                "updatedDate": null,
                "organisationType": null,
                "isTenant": null,
                "provider": "channel1003",
                "id": "0130107621805015045",
                "email": null,
                "slug": "channel1003",
                "isSSOEnabled": false,
                "orgName": "localrootorg3",
                "updatedBy": null,
                "locationIds": [],
                "externalId": "localrootorg3",
                "orgLocation": [],
                "isRootOrg": true,
                "rootOrgId": "0130107621805015045",
                "isDefault": null,
                "createdDate": "2020-04-30 11:46:02:202+0530",
                "createdBy": null,
                "hashTagId": "0130107621805015045",
                "status": 1
            },
            "tcUpdatedDate": null,
            "recoveryPhone": "",
            "userName": "localtest2",
            "userId": "7b11d2ed-f6e1-40bd-8ca2-bb609614bd63",
            "promptTnC": true,
            "createdDate": "2021-06-04 14:20:16:861+0530",
            "framework": {},
            "createdBy": null,
            "profileUserType": {},
            "tncAcceptedVersion": null
        }
    }
}
```






*****

[[category.storage-team]] 
[[category.confluence]] 

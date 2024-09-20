

[[SC-2184 : Data model changes to user schema to store location, persona, subpersona in generic way|SC-2184---Data-model-changes-to-user-schema-to-store-location,-persona,-subpersona-in-generic-way]]


## New API Version : 
End-point : /v4/user/read/:uid

Method: GET

Response: 


```
{
    "id": "",
    "ver": "v4",
    "ts": "2021-04-07 09:24:59:200+0530",
    "params": {
        "resmsgid": null,
        "msgid": "a1d3d756-0f9b-4ec6-95a6-6560896d5294",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "lastName": null,
            "maskedPhone": null,
            "tcStatus": null,
            "roles": [
                "PUBLIC"
            ],
            "channel": "dikshaChannel123",
            "prevUsedPhone": "",
            "updatedDate": null,
            "stateValidated": true,
            "isDeleted": false,
            "organisations": [
                {
                    "organisationId": "0132514804465254400",
                    "updatedBy": null,
                    "addedByName": null,
                    "addedBy": null,
                    "roles": [
                        "PUBLIC"
                    ],
                    "approvedBy": null,
                    "updatedDate": null,
                    "userId": "919d92d8-ff61-4c35-bf36-979f0326cb9f",
                    "approvaldate": null,
                    "isDeleted": false,
                    "hashTagId": "0132514804465254400",
                    "isRejected": null,
                    "id": "0132515448920719360",
                    "position": null,
                    "isApproved": null,
                    "orgjoindate": "2021-04-05 16:17:14:002+0530",
                    "orgLeftDate": null
                }
            ],
            "managedBy": null,
            "provider": null,
            "countryCode": null,
            "flagsValue": 6,
            "maskedEmail": "re*************@yopmail.com",
            "id": "919d92d8-ff61-4c35-bf36-979f0326cb9f",
            "recoveryEmail": "",
            "email": "re*************@yopmail.com",
            "rootOrg": {
                "dateTime": null,
                "preferredLanguage": null,
                "keys": {},
                "approvedBy": null,
                "channel": "localhost1009",
                "description": "KAE State",
                "updatedDate": "2021-03-26 16:59:59:302+0530",
                "addressId": null,
                "organisationType": null,
                "isTenant": null,
                "provider": "localhost1009",
                "locationId": null,
                "orgCode": null,
                "theme": null,
                "id": "0132388841493626880",
                "communityId": null,
                "isApproved": null,
                "email": null,
                "slug": "localhost1009",
                "isSSOEnabled": true,
                "thumbnail": null,
                "orgName": "KAE",
                "updatedBy": null,
                "locationIds": [],
                "externalId": "localhost1009",
                "orgLocation": null,
                "isRootOrg": true,
                "rootOrgId": "0132388841493626880",
                "approvedDate": null,
                "imgUrl": null,
                "homeUrl": null,
                "isDefault": null,
                "createdDate": "2021-03-18 19:07:13:916+0530",
                "createdBy": null,
                "hashTagId": "0132388841493626880",
                "noOfMembers": null,
                "status": 0
            },
            "identifier": "919d92d8-ff61-4c35-bf36-979f0326cb9f",
            "updatedBy": null,
            "phoneVerified": false,
            "tcUpdatedDate": null,
            "recoveryPhone": "",
            "userName": "resh1_r9u8",
            "rootOrgId": null,
            "userId": "919d92d8-ff61-4c35-bf36-979f0326cb9f",
            "prevUsedEmail": "",
            "emailVerified": true,
            "firstName": "resh1",
            "profileLocation": [
                {
                    "id": "4b3e0114-f2b1-4632-8366-f1e428994698",
                    "type": "district"
                },
                {
                    "id": "2563fd50-8e70-470c-b911-4bcc9fab8a17",
                    "type": "state"
                }
            ],
            "createdDate": "2021-04-05 16:17:13:651+0530",
            "framework": {},
            "tncAcceptedOn": null,
            "allTncAccepted": {},
            "createdBy": null,
            "phone": "",
            "profileUserType": {
                "subType": "aeo",
                "type": "student"
            },
            "dob": null,
            "tncAcceptedVersion": null,
            "status": 1
        }
    }
}
```






*****

[[category.storage-team]] 
[[category.confluence]] 

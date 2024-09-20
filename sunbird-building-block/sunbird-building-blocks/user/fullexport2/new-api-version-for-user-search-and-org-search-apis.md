
## SB-23718 : New API version - User Search
End-point: /v2/user/search 

Method: POST

Request:


```
{
    "request": {
        "filters": {
            "id": "919d92d8-ff61-4c35-bf36-979f0326cb9f" 
        },
        "limit": 100
    }
}
```
Response: 


```
{
    "id": "api.user.search",
    "ver": "v2",
    "ts": "2021-04-07 09:22:27:887+0530",
    "params": {
        "resmsgid": null,
        "msgid": "481a5632-9fa8-47fd-b435-949b7f21aa7d",
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
                    "rootOrgName": "KAE",
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
                            "orgName": "Diksha Org Name",
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
            ]
        }
    }
}
```

## SB-23719 : New API version - Org Search
End-point: /v2/org/search

Method: POST

Request: 


```
{
    "request": {
        "filters": {
            "id": "0132514795292098562"
        },
        "limit": 100
    }
}
```
Response:


```
{
    "id": "api.org.search",
    "ver": "v2",
    "ts": "2021-04-07 09:51:08:210+0530",
    "params": {
        "resmsgid": null,
        "msgid": "2e89a4b8-0ff7-4274-b5b0-7c9c427cb056",
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
                    "dateTime": null,
                    "preferredLanguage": null,
                    "keys": {},
                    "approvedBy": null,
                    "channel": "dikshaChannel12345",
                    "description": "Diksha org Description",
                    "updatedDate": null,
                    "addressId": null,
                    "organisationType": 2,
                    "isTenant": true,
                    "provider": "dikshachannel12345",
                    "locationId": null,
                    "orgCode": null,
                    "theme": null,
                    "id": "0132514795292098562",
                    "communityId": null,
                    "isApproved": null,
                    "email": "info@diksha.org",
                    "slug": "dikshachannel12345",
                    "isSSOEnabled": true,
                    "identifier": "0132514795292098562",
                    "thumbnail": null,
                    "orgName": "Diksha Org Name",
                    "updatedBy": null,
                    "locationIds": [],
                    "externalId": "dikshaextid12345",
                    "orgLocation": null,
                    "isRootOrg": null,
                    "rootOrgId": "0132514795292098562",
                    "approvedDate": null,
                    "imgUrl": null,
                    "homeUrl": null,
                    "isDefault": null,
                    "createdDate": "2021-04-05 14:09:36:208+0530",
                    "createdBy": null,
                    "hashTagId": "0132514795292098562",
                    "noOfMembers": null,
                    "status": 1
                }
            ]
        }
    }
}
```


[Test cases - collection](https://www.getpostman.com/collections/dad6027a05e66bf395e8)





*****

[[category.storage-team]] 
[[category.confluence]] 


## Introduction
This wiki explains the design of process for ownership transfer of the assets owned by a user in case of user profile deletion.


## Background & Problem Statement
Sunbird supports the mobile app for Android and iOS. As per the latest policy update of the Apple App Store and Google Play Store, mandates the user deletion from the app, if the app is having the signup from app. The specific policy mandates can be found using the following links:


* Apple App Store Policy - [https://developer.apple.com/app-store/review/guidelines/#data-collection-and-storage](https://developer.apple.com/app-store/review/guidelines/#data-collection-and-storage)


* Apple App Store Policy - [https://developer.apple.com/support/offering-account-deletion-in-your-app](https://developer.apple.com/support/offering-account-deletion-in-your-app)


* Google Play Store Policy - [https://support.google.com/googleplay/android-developer/answer/13327111?hl=en](https://support.google.com/googleplay/android-developer/answer/13327111?hl=en)



Registered users must have access to a "Delete Account" option on both the app and the portal. This option will allow them to initiate the account deletion process themselves. Once a user deletes his/her account, assets created by the users as part of the organisation in the system will no longer be accessible for maintenance by others from the organisation (except contents/collections having collaborators). There is a need to enable asset maintenance by the organisation by transferring ownership of such assets to other users of the organisation. 


### Key Design Problems
Enable OrgAdmin user flows to transfer the deleted user’s assets that are part of the organisation to new user in the organisation.


* Ability to transfer complete assets as a single action


* Ability to transfer assets partially by selection




## Design
‘Deleted User’s Assets' Report (LERN - spark job) can be generated on a daily (or chosen frequency) basis which can list all users and their assets belonging to a channel.

Report will have following columns:

 **userId,username,roles,assetIdentifier,assetName,assetStatus,objectType** 



 **Steps to achieve the report data:** 


1. List of Assets belonging to the channel will be fetched using List/Search APIs of the respective Building Blocks with ‘createdBy’ as one of the search assets' metadata information.



Content Service and Questions Service: Composite search API


```
curl --location --request POST '{{host}}/api/composite/v1/search' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer {{api_key}}' \
--data-raw '{
    "request": {
        "filters": {
            "channel": "{{channel_id}}",
            "status": ["Live","Draft","Review","Unlisted"]
        },
        "fields": ["identifier","createdBy","name","objectType","status"],
        "sortBy": {"createdOn": "Desc"},
        "limit": 1
    }
}'
```
ML Program: 


```
curl --location --request GET ‘http://ml-core-service:3000/v1/users/getPMPDInOrg?orgId=0126684405014528002’ \
--header ‘internal-access-token: {{$internal-access-token}}’


Sample response:
{
    "message": "All Program Manager and Designer fetched successfully",
    "status": 200,
    "result": {
        PMPDs: [
            "0c274517-d3b9-4858-9d88-b41cfcc2727e",
            "0f209f21-a093-421e-b867-561d85bc011b",
            "19a22722-9e35-4f80-9412-f2668d50ec3c",
        ]
    }
}
```
Course Service: Batch List API


```
curl --location --request POST '{{host}}/api/course/v1/batch/list' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer {{api_key}}' \
--header 'x-authenticated-user-token: {{user_access_token}}' \
--data-raw '{
    "request": {
        "filters": {
            "channel": {{channel_id}},
            "status": 1
        },
        "fields": ["identifier","name","createdBy","status"],
        "limit": 10000
    }
}'
 
```

1. Unique list of ‘createdBy’ users' list will be taken from the combination of the return List/Search API responses from above API calls.


1. ‘User Search API' will be used to pass the list of users’ identifiers and fetch the list of users in deleted status.

    


```json
curl --location --request POST '{{host}}/api/user/v3/search' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer {{api_key}}' \
--header 'x-authenticated-user-token: {{user_access_token}}' \
--data-raw '{
    "request": {
        "filters": {
          "status": 2,
          "identifier": [""] // Unique List of Users Ids from above search APIs
        },
        "fields": ["identifier","userName","organisations","roles","lastUpdatedOn","status"],
        "limit": 10000
    }
}'


```




Note: Report will be a zip file containing multiple parts as csv/excel files when the data exceeds max configured rows per file.



As an OrgAdmin, application will have an option to download the ‘Deleted User’s Assets'  report and look for users' and assets' information.



OrgAdmin will also have an option to input the ‘userName’ (copied from report) to trigger asset transfer action.

Once OrgAdmin selects the fromUser, 


* (Optional step - if partial transfer of assets is to be enabled) application will list all assets of the user created for the organisation enabling provision to select assets for partial transfer if needed. 


* OrgAdmin will select the toUser to whom assets are to be transferred.




* OrgAdmin can initiate asset transfer with single click action or selected assets transfer action to new user of the organisation.




### Common Steps:

* Only OrgAdmin users can trigger the asset ownership transfer action.


* On selection of assets partially, resources information will be passed onto ‘Ownership transfer API’ exposed by UserOrg service.


* ‘Ownership transfer API’ will then trigger events for each resource into a common kafka event ‘ **{{envName}}.user.ownership.transfer’** . Each BB will be listening to this kafka topic and process the resource ownership transfer. Each BB will make the role check of the toUserId mentioned in the event for appropriateness.





Ownership transfer API'{{host}}/api/user/v1/ownership/transfer'
```json
curl --location --request POST '{{host}}/api/user/v1/ownership/transfer' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer {{api_key}}' \
--header 'x-authenticated-user-token: {{user_token}}' \
--data-raw '{
    "request":{
      "context": "User Deletion",  // "User Deletion", "Role Change", etc.
      "organisationId": "{{organisationId}}",
      "actionBy": {
		"userId": {{user_id}},
		"userName": {{user_name}}
      },
      "fromUser": {
		"userId": {{}},
		"userName": {{}},
		"channel":{{}},
		"organisationId": {{}},
		"roles": [{
          
		}]
      },
      "toUser": {
		"userId": {{}},
		"userName": {{}},
		"firstName": "",
		"lastName": "",
		"roles": [{
          
		}]
      },
      "objects": [
        {
          "objectType": "Content",
          "identifier": "do_id1",
          "primaryCategory": "ExplanationContent",
          "name": "TestContent"
        },
        {
          "objectType": "Program",
          "identifier": "programId1",
          "name": "TestProgram"
        }
      ]
    }
}'
```
Response
```json
{
    "id": "api.user.ownership.transfer",
    "ver": "1.0",
    "ts": "2023-08-28T13:54:45Z+05:30",
    "params": {
        "resmsgid": "a638c46e-63a5-47de-bf00-029cbe435e5e",
        "msgid": null,
        "err": null,
        "status": "successful",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "status": "Ownership transfer process is submitted successfully!"
    }
}
```

* This API will trigger the kafka events individually for each resource mentioned in the API request.




### Transfer ownership Kafka Event


|  **Property**  |  **Description**  | 
|  --- |  --- | 
| organisationId | organisation identifier of the org admin user who is triggering the asset transfer action | 
| context | This will help to identify the context of transfer. e.g. Delete User, Role Change | 
| actionBy | org admin user profile information who is triggering the asset transfer action | 
| fromUserProfile | User Profile Information whose asset needs to be transferred. | 
| toUserProfile | User Profile Information of the user to whom ownership of the assets needs to be transferred to. | 
| assetInformation | Assets' metadata information passed in the API body | 

Sample event{

  "eid": "BE_JOB_REQUEST",

  "ets": 1712750750956,

  "mid": "LP.1712750750956.07a0a24d-37ef-462c-a614-b76ad2a6a6ac",

  "actor": {

    "type": "System",

    "id": "ownership-transfer"

  },

  "context": {

    "pdata": {

      "ver": "1.0",

      "id": "org.sunbird.platform"

    }

  },

  "object": {

    "type": "user",

    "id": "72d8cd69-2469-4234-82e7-6b849e0a28d9"

  },

  "edata": {

    "organisationId": "01394517023437619214_1111",

    "actionBy": {

      "userId": "ad8c3adf-2447-4559-af15-f6d1057a0b8a",

      "userName": "gtest-user-007"

    },

    "context": "User Deletion",

    "action": "ownership-transfer",

    "fromUserProfile": {

      "userId": "72d8cd69-2469-4234-82e7-6b849e0a28d9",

      "userName": "gtest-user-005",

      "channel": "",

      "organisationId": "",

      "roles": \[]

    },

    "iteration": 1,

    "assetInformation": {

      "name": "TestContent",

      "identifier": "do_123",

      "primaryCategory": "Practice Question Set",

      "objectType": "QuestionSet"

    },

    "toUserProfile": {

      "userId": "4c009ce1-b069-4d27-879b-605c55ff4ef9",

      "userName": "gtest-user-006",

      "firstName": "G-Test",

      "lastName": "User-006",

      "roles": \[

        "BOOK_CREATOR",

        "CONTENT_CREATOR"

      ]

    }

  }

}



As part of future enhancement, Signing the message to ensure event is generated by authorised personnel can be considered.


## References

* [[\[PRD] Delete Account functionality|[PRD]-Delete-Account-functionality]]


* [https://docs.google.com/presentation/d/1EoRJD8KWd0002hHtxc4PWwAVB0FQr_Z5l4PUOsvxpdQ/edit?pli=1#slide=id.p](https://docs.google.com/presentation/d/1EoRJD8KWd0002hHtxc4PWwAVB0FQr_Z5l4PUOsvxpdQ/edit?pli=1#slide=id.p)


* Apple App Store - [https://developer.apple.com/support/offering-account-deletion-in-your-app](https://developer.apple.com/support/offering-account-deletion-in-your-app)


* Google Play Store - [https://support.google.com/googleplay/android-developer/answer/13327111?hl=en](https://support.google.com/googleplay/android-developer/answer/13327111?hl=en)





*****

[[category.storage-team]] 
[[category.confluence]] 

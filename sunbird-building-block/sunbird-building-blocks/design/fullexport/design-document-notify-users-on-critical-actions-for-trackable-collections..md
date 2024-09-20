This document will help us to achieve the implementation of the notification feature for any specific activity on groups workflow.


### Background:
As per the ticket [https://project-sunbird.atlassian.net/browse/SB-24361](https://project-sunbird.atlassian.net/browse/SB-24361), we are trying to notify the users when there is some action happened in groups workflow. 



As discussed with the UP team, we can use the existing the feed APIs to 


1. Notify the users of some actions made in the group scenario.


1. Mark any notification read




### Trigger a notification:

```
curl --location --request POST 'https://dev.sunbirded.org/api/user/feed/v1/create' \
--header 'Authorization: Bearer <Bearer Key>' \
--header 'x-authenticated-user-token: <user-token>' \
--header 'Content-Type: application/json' \
--data-raw '{
  "request": {
    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",
    "category": "group-feed",
    "priority": 1,
    "data": {
      "actionData": {
          "actionType": "groupNotify",
          "title": "Title for Notification",
          "description": "Description which will be displayed in Notification",
          "contentURL": "my-groups/group-details/c59cca34-c574-49ad-953b-c1cfc7ad50a3", 
          "identifier": //
      }
  }
}'
```
Response:
```
{
    "id": "api.user.feed.create",
    "ver": "v1",
    "ts": "2021-05-07 06:08:30:954+0000",
    "params": {
        "resmsgid": null,
        "msgid": "9238f58b985ff0903692475346dc2cee",
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

### Read a notification:

```
curl --location --request GET 'https://dev.sunbirded.org/api/user/v1/feed/e79ee6a4-d79c-4236-9e05-f754010932d6' \
--header 'Authorization: Bearer <auth-token>' \
--header 'x-authenticated-user-token: <user-token of the given user>' \
--header 'Content-Type: application/json'
```
Response:
```
{
    "id": "api.user.feed.e79ee6a4-d79c-4236-9e05-f754010932d6",
    "ver": "v1",
    "ts": "2021-05-10 05:54:35:649+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8470ecb7fa05d7d22313a30c9a16927d",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "userFeed": [
                {
                    "id": "ddab7b78-5978-4a11-b7f8-6594c7a6e7b8",
                    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "category": "group-feed",
                    "priority": 1,
                    "createdBy": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "status": "unread",
                    "data": {
                        "actionData": {
                            "actionType": "groupNotify",
                            "title": "Title for Notification",
                            "description": "Description which will be displayed in Notification",
                            "contentURL": "my-groups/group-details/c59cca34-c574-49ad-953b-c1cfc7ad50a3",
                            "identifier": ""
                        }
                    },
                    "createdOn": 1620626043127
                }
            ]
        }
    }
}
```

### Mark notification as read:
To make a notification as read,  we have two options here. 


1. We can make the update/feed API call to make a particular feed as read.


1. Delete a particular feed once it is read.



 Update feed:
```
curl --location --request POST 'https://dev.sunbirded.org/api/user/feed/v1/update' \
--header 'Authorization: Bearer <auth-token>' \
--header 'x-authenticated-user-token: <user-token>' \
--header 'Content-Type: application/json' \
--data-raw '{
  "request": {
    "userId": "a10d5216-6b96-404c-8d1c-cc1f720d910a",
    "category": "group-feed",
    "feedId": "22ba004f-3b07-429e-bb9a-0bd3dfb21d2b",
    "status": "read",
  }
}'
```
Delete feed:
```
curl --location --request POST 'https://dev.sunbirded.org/api/user/feed/v1/delete' \
--header 'Authorization: Bearer <auth-token>' \
--header 'x-authenticated-user-token: <user token of the given user>' \
--header 'Content-Type: application/json' \
--data-raw '{
  "request": {
    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",
    "category": "group-feed",
    "feedId": "12a13052-6e64-431d-b622-185bc0aca33f"
  }
}'
```
Response:
```
{
    "id": "api.user.feed.update/delete",
    "ver": "v1",
    "ts": "2021-05-07 06:54:22:856+0000",
    "params": {
        "resmsgid": null,
        "msgid": "814e2ade1965ede9dce2fe6fac2bc61d",
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

### Proposed solutions :


Solution 1:  Generic solution
* Triggering notification will be handled from CSL side


* inside on click event handler, we’ll make a generic method in the portal side.


* This will make sure irrespective of the category (user-feed, group-feed, etc), it will perform the defined action.


* There won't be any hardcoded checks before redirecting. 


* redirection URL will also be part of the response.




### Pros: 

* It can be used later as well.


* There will not be any code changes required for this if it becomes generic. 




### Cons: 

* Since it is hardcoded in the portal side to support Category type as “notification“ to show the notifications, we need to make some code changes




### Solution 2:  Only to handle groups scenario:

* create a method in group service.


* It will take care of the redirection based on the category (group-feed).


* It will only be bound to groups scenario.



Pros: 
* less code change





Cons: 
* It will be only related to groups scenario. 


* if any new requirements come, we need to modify the code once again. 





*****

[[category.storage-team]] 
[[category.confluence]] 

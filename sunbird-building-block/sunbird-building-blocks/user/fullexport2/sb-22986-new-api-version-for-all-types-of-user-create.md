
## SB-22986 : New API version - User Signup
End-point: /v2/user/signup

Method: POST

Request:


```
{
  "request": {
    "firstName": "rohan",
    "password": "Password@123",
    "email": "rohan123@yopmail.com",
    "lastName": "123",
    "userName": "rohan123",
    "emailVerified": true,
    "profileUserType":{"type":"teacher","subType":"null"}
   
  }
}
```
Response:


```
{
    "id": "api.user.signup",
    "ver": "v2",
    "ts": "2021-04-07 19:28:05:336+0530",
    "params": {
        "resmsgid": null,
        "msgid": "a1d3d756-0f9b-4ec6-95a6-6560896d5294",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS",
        "err_msg": "User is created but password couldn't be updated.",
        "userId": "54c10172-0f96-49d2-b701-8edd1743bbf1"
    }
}
```


End-point: /v1/manageduser/create

Method: POST

Request:


```
{
    "request": {
        "firstName": "user",
        "userName": "user1234",
        "managedBy": "48382e16-282c-4eec-854f-c8112e4aefba",
        "profileLocation": [
            {
                "code": "32",
                "type": "state"
            },
            {
                "code": "3210",
                "type": "district"
            }
        ]
    }
}
```


Response:


```
{
    "id": "api.manageduser.create",
    "ver": "v1",
    "ts": "2021-04-08 16:25:07:672+0530",
    "params": {
        "resmsgid": null,
        "msgid": "a1d3d756-0f9b-4ec6-95a6-6560896d5294",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS",
        "userId": "856bce6d-7ea6-4808-b013-8264e5a382db"
    }
}
```






*****

[[category.storage-team]] 
[[category.confluence]] 


### About
OTP verify API is called before user registration, to verify the user’s email/phone. Once email/phone verified, portal is making call to user registration API to create user in our system.

This flow of user registration has one issue i.e user can change their verified email/phone before calling user create API. Currently portal is hashing the user request to verify the email/phone after OTP verification is done by the user. Now this hashing and verification flow will be handled by user-org service.


## Solution

1. For user self sign-up & state sso:



       user-org service will send the encrypted or hashed value of email/phone in OTP verify response and use the same to verify the email/phone from user registration request body.

OTP verify Response:


```
{
    "id": "api.otp.verify",
    "ver": "v1",
    "ts": "2021-10-18 08:01:50:644+0000",
    "params": {
        "resmsgid": null,
        "msgid": "3d3ddda149504a8aee7d4f6c22596c35",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS",
        "token": "12ea49c78a547f92c423c6af1e217cdb"
    }
}
```
User create Request:




```
{
    "request":{                 
      "firstName": "xyz",
      "lastName": "xyz",
      "email": "xyz@xyz.com",
      "password":"password",
      "token":"12ea49c78a547f92c423c6af1e217cdb"
    }
}
```
 **Note** : user-org service will use the token value in the above user create request to validate the email/phone, else will throw the 401 Unauthorized error.

2. Google SO:

     Once the user successfully signs in , portal will get the user's ID token. And send this to user-org service, using this token, user-org service will fetch the user details and will call user registration API internally.

This need new user registration API to support user creation via google sign on, this will require only user’s ID token in request body.



 **Note** : Same flow should be used to update user’s email\phone.




## Queries:

1. Do we need new version of all the user registration APIs to implement these changes? (only portal is using user registration related APIs and app is using portal for the same.)


1. Can we depreciate the older version of user registration APIs? 


1. Update API need newer version if we have to implement this flow.







*****

[[category.storage-team]] 
[[category.confluence]] 

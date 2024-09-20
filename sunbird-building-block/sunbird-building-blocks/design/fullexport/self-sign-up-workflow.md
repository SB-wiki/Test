# Self-sign-up-workflow

## Problem statement:

&#x20;  Sunbird system will allow user on-boarding with following ways:

1. &#x20; Self sign up
2. &#x20; Google plus login
3. &#x20; State login   &#x20;

Problem will have during user profile merging. Migrating self sign up user profile with Google plus login or state login.

Note : As create user required phone or email verification by sending OTP, so is our assumption is each adopter will be using sms gateway, if there user want to signup with phone.

### User attribute required during sign up:

| Attribute     | Type         | Required    | purpose                                                                             |
| ------------- | ------------ | ----------- | ----------------------------------------------------------------------------------- |
| name          | string       | true        | name of user. can be combination of firstname , middle name and lastname            |
| username      | alphanumeric | false       | unique identity to identify user. user name will be unique per installation         |
| password      | alphanumeric | true        |                                                                                     |
| phone         | number       | conditional | either phone or email is mandatory . but during creation time user can't pass both. |
| email         | alphanumeric | conditional | either phone or email is mandatory . but during creation time user can't pass both. |
| userType      | string       | internal    | To identify user is Teacher or Other , as of now there is only two types            |
| signUpType    | string       | internal    | To identify user came via selfsignUp, googleplus , statelogin or stateonboard       |
| phoneVerified | boolean      | internal    | will be true only when user verified phone otp                                      |
| emailVerified | boolean      | internal    | will be true only when user verified email otp                                      |
| otp           | number       | false       | OTP can be passed during signup                                                     |

### Proposed solution 1:

Self sign up work flow:

* &#x20;User will enter all mandatory field (name, phone/email, username,password) on consumer portal/app
* Consumer will make call for generate OTP for either phone or email
* &#x20;OTP Generation will be taken care by \[\[Design for One time password (OTP)|Design-for-One-time-password-(OTP)]]
* Once User enter OTP, consumer will verify OTP using following design \[\[Design for verify OTP|Design-for-verify-OTP]]
* Once OTP is verified then they will call create user api.
* if any validation fails then it will throw proper error

```js
Changes in Create User api request body:
URI: v2/user/create
Method: POST
Request body:

{
 "request":
      {
       "firstName":"name of user",
       "email":"valid and unique email id",
       "phone":"valid phone number",
       "password":"user password",
       "username" : "unique user name. Optional",
       "channel" : "rootOrgchannel value (Optional)"// if user pass it , it must be valid and user will be associated with this as "PUBLIC" role.
       "organisationId": "",
       "emailVerified": true, // will be true when user pass emailId
       "phoneVerified" : true // will be true when user pass phone.
    }
}

- Changes in create user api:
  * username : field will be optional (if user is passing it then system will verify uniqueness only, if user is not passing then system will generate unique username.)
  * channel : This field is optional .
        * if caller will pass it, then system will verify it's validity ( should be rootOrg and status as active) once it's verified then user will be associated with that rootOrg.
        * if channel is invalid or not active then creation will fail with proper error message.
 * organisationId : This field is optional.
       * if caller passes both channel and organisationId then , organisationId should be either suborg or rootOrg under same channel. it's status should be active. once it's verified then user will be associated with both as role "PUBLIC"
       * if channel and organisationId belongs to different rootOrg or channel is active but suborg(organisationId) is inactive then user creation will fail with proper error message.
       * if user will pass on organisationId , then system will check organisationId should be valid and active. if both condition satisfied then user will be associated with
       corresponding rootOrg and suborg with role "PUBLIC".  
      * Once Phone/email is verified by user in DB it will mark PhoneVerified or emailVerified as true.
      * For Google signIn user email verified will be always true.       

Doubts:
* How to do validation for Indian phone number. As per PRD only Indian phone number is valid.
* Are we taking country code as well from user , or always will associate user country code as "+91"

```

As per discussion with design council we are going to take proposed solution 1:Storage of user data pre-user creation:   Requirement is sunbird should not create user into system unless or until it's verified.&#x20;

Proposed solution 1:

&#x20;         Consumer (portal/app) can hold user data in local cache , and  once OTP is verified then only they make create user api call.

| Pros | Cons |
| ---- | ---- |
|      |      |

1. Junk data won't be in system.
2. System will always has verified user account.

|

1. if you refresh cache or clear cache that might clear user store data.

\| | | |

&#x20; &#x20;

#### Proposed solution 2:&#x20;

&#x20; User Data can be stored under sunbird as some temp table or inside OTP table as well, and once user verify OTP then , it will move data from temp to user table.

| Pros | Cons |
| ---- | ---- |
|      |      |

1. All attempted user data is in sunbird

|

1. it will have lot of unverified profile in sunbird.&#x20;

|

#### Proposed solution 3:&#x20;

&#x20; Sunbird can introduce Redis service and all unverified user data can be stored under Redis.This service can be used for other centralized cache as well.

| Pros | Cons |
| ---- | ---- |
|      |      |

1. Data lost issues can be resolved
2. Sunbird will have all verified and un-verifed data.
3. Redis cache can be used in other places as well. As of now sunbird is doing in-memory cache of some data , and that will vary from server to server.

|

1. Implementation time will be more.
2. Need to manage one more stack

|

Notes: After design discussion No need for storage of pre user creation.

## Google sign In:

&#x20;When user come to sunbird via Google sign in , Caller will do following check.

* &#x20;If user already exist in sunbird  and user status is not deleted , then allow that user to do login.
* &#x20;If user does not exist in sunbird then make below api call&#x20;
* User existence check will happen with provided email.(In user search request ,you can pass email inside filter.)

```js
URI: v1/user/verifyAndCreate
Method: POST
Request body: 

 {
  "request": {
       "firstName":"",
       "email":"",
       "phone":"valid phone number", 
       "verificationCode":"can be OTP or google token",
       "verificationSource":"id_token in case of Google",
      }
}

Response: 
  same as create user api

* This api will do following validation:
   1.  Make request verification api call based on verificationSource. In Case of OTP it will verify against generated OTP and in case of Google it will verify against below url.
 https://www.googleapis.com/oauth2/v3/tokeninfo?id_token={verificationKey}
   2. once verified then it will make create user api call to create a user once user is created his/her email  verified field will be true.


 Open Question:
   1. What will happen if user is in sunbird but his/her status is inactive or deleted?
   2. There is an old user in system whose emailVerified filed is false and same user trying to login with Google signin?  


```

Notes: As per design discussion this will be completely handled by portal or app team . Sunbird backend need to just make emailVerified as true, if user create call is coming after Google signin.&#x20;

## State sign-in

When user comes through state-portal, he/she will get a link to access Diksha portal.

1. Once user clicks, internally it will check existence of the user in the diksha.
2. If found with status as active and isPhoneVerified as true then user will be directly taken to the Diksha portal, as login user.
3. If not found, then portal will take user phone number by parsing JWT token and generate OTP,
4. OTP will be generated and sent to user's mobile phone. OTP Generation will be taken care by \[\[Design for One time password (OTP)|Design-for-One-time-password-(OTP)]]
5. On diksha user will be redirected to Enter OTP&#x20;
6. On successful OTP validation, user will be created within Diksha and user will be logged into the platform.

&#x20;  &#x20;

&#x20;   Case 2:

&#x20;     1\.   User found with status as active and isPhoneVerified as false, then Caller need to generate OTP and ask user to verify it, once caller verified it, That user profile isPhoneVerified need to be marked as ture.

&#x20;    2\. User found with status as inactive/deleted then what need to be done?&#x20;

### \*\* Open Questions:

&#x20;    \* What should be userName in this case?  &#x20;

&#x20;        Resp: As discussed username will be auto-generated - internally system will make sure that auto-generated username will be related to user and not very hard to remember.&#x20;

&#x20;           it will have lowercase of name and appended with 4 random digit. if name will be separated by spaces then space will be replaced by "\_".

&#x20;         Example : MD MANZARUL HAQUE : md\_manzarul\_haque0098&#x20;

&#x20;  \*  Does system need to generate password for Google signup user?

&#x20;       Resp:  As per discussion , no need to generate password.

&#x20;  \* Do we need to send any welcome email to user? if yes then what should be content?

&#x20;      Resp:  As per discussion, for Google user creation no need to send any email.

&#x20;  \* What will happen if some old Google user won't have firstName or name itself?

&#x20;  \* There might be scenario user already exist but his status is deleted?

&#x20;      Resp:  As per discussion, user creation will fail.

&#x20;  \* Do we need to carry loginId as well?

&#x20; \* In Old implementation during user create we have to send phoneVerified as true?

&#x20;\* User external Id workflow?(In old )

***

\[\[category.storage-team]] \[\[category.confluence]]

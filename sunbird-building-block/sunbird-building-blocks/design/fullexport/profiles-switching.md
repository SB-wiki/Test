# Profiles-Switching

### Introduction:

This document describes the design approach of creating and switching of Managed User’s account

### Background:

Jira Issue: [https://project-sunbird.atlassian.net/browse/SH-68](https://project-sunbird.atlassian.net/browse/SH-68)

[https://project-sunbird.atlassian.net/browse/SH-95](https://project-sunbird.atlassian.net/browse/SH-95)

Epic: [https://project-sunbird.atlassian.net/browse/SH-67](https://project-sunbird.atlassian.net/browse/SH-67)

Presently only user having email address or phone number can register and use application.

### Problem Statement:

1. How managed user account can be created.
2. How to switch between different managed user account and user account.

### Key design problems:

1.  How to map actions performed by managed user to his account.

    Telemetry should be mapped with different user ID.
2. Device ID will be same for user and managed user.

### Existing workflow:

User login in to his account and starts using application.

![](<../../../../Design/FullExport/images/storage/Untitled Diagram.jpg>)

**Change request:** As part of [https://project-sunbird.atlassian.net/browse/SH-68](https://project-sunbird.atlassian.net/browse/SH-68) user should be able to switch and create profiles.

Below is data store in session

Session object

```
{
  "cookie": {
    "originalMaxAge": null,
    "expires": null,
    "httpOnly": true,
    "path": "/"
  },
  "auth_redirect_uri": "http://localhost:3000/profile?auth_callback=1",
  "keycloak-token": {
    "access_token": "aJcYtJvbeZmEKMZRSG9jctEb5Vug_nL5aU6O15aT2v6QSGL_nqPfI2ZRdG2At7o9jecCDlg",
    "expires_in": 172795,
    "refresh_expires_in": 172795,
    "refresh_token": "-uc7ElglOgx5YmKm11KepmPQQp7X43yaQYLxYs",
    "token_type": "bearer",
    "id_token": "-hq2iMbBMUPTto1Xi0xDGhXQo1p4FBCExBNcsbJQkjmk4RiOyO_7VlJKMuz0V2tPwLkpoAxroE-O5LZtvbvRxhVyFcdiLl0r_6HAX1gwfZPySPqm4RHDKedLBiU94sCafImeMnhyQVgUm-eK47uveybbinueWyBlTyGszlIkecAKYEaA",
    "not-before-policy": 1565356374,
    "session_state": "682b012d-2466-4d84-98cb-f46cdec4057a",
    "scope": "openid"
  },
  "userId": "95e4942d-cbe8-477d-aebd-ad8e6de4bfc8",
  "roles": [
    "public",
    "CONTENT_REVIEWER",
    "FLAG_REVIEWER",
    "BOOK_CREATOR",
    "REPORT_VIEWER",
    "PUBLIC"
  ],
  "orgs": [
    "ORG_001"
  ],
  "rootOrgId": "ORG_001",
  "rootOrghashTagId": "b00bc992ef25f1a9a8d63291e20efc8d",
  "rootOrg": {
    "dateTime": null,
    "preferredLanguage": "English",
    "keys": {
      "signKeys": [
        "5766",
        "5767"
      ],
      "encKeys": [
        "5766",
        "5767"
      ]
    },
    "approvedBy": null,
    "channel": "ROOT_ORG",
    "description": "Andhra State Boardsssssss",
    "updatedDate": "2018-11-28 10:00:08:675+0000",
    "addressId": null,
    "provider": null,
    "locationId": null,
    "orgCode": "sunbird",
    "theme": null,
    "id": "ORG_001",
    "communityId": null,
    "isApproved": null,
    "email": "support_dev@sunbird.org",
    "slug": "sunbird",
    "identifier": "ORG_001",
    "thumbnail": null,
    "orgName": "Sunbird",
    "updatedBy": "1d7b85b0-3502-4536-a846-d3a51fd0aeea",
    "locationIds": [
      "969dd3c1-4e98-4c17-a994-559f2dc70e18"
    ],
    "externalId": null,
    "isRootOrg": true,
    "rootOrgId": "ORG_001",
    "approvedDate": null,
    "imgUrl": null,
    "homeUrl": null,
    "orgTypeId": null,
    "isDefault": true,
    "contactDetail": [
      {
        "phone": "213124234234",
        "email": "test@test.com"
      },
      {
        "phone": "+91213124234234",
        "email": "test1@test.com"
      }
    ],
    "createdDate": null,
    "createdBy": null,
    "parentOrgId": null,
    "hashTagId": "b00bc992ef25f1a9a8d63291e20efc8d",
    "noOfMembers": 5,
    "status": 1
  }
}
```

### Solution 1:

Create separate session - 1. User session

```
                                            2. Managed user session.
```

Both sessions should reference to each other internally.

It can be handled via 2 different approaches -

* Creating sub session and adding a pre-fix for all the routes which will generate 2 session ID.
* Create and maintain 2 session objects referencing to userId

**Pros** :

1.

**Cons** :

1. Maintaining multiple sessions could be cumbersome and lead to errors.
2. Adding prefix to routes could be extra work.

### Solution 2:

Once switch profile is initiated fetch the managed user profile details. Replace the user data in session keeping the parent token as it is.

![](<../../../../Design/FullExport/images/storage/Untitled Diagram (3).jpg>)Things to reinitialise -

* Telemetry
* User profile
* Update UserId in elements in index.html

Proposed changes to session.

Proposed changes to session object

```
{
  "cookie": {
    "originalMaxAge": null,
    "expires": null,
    "httpOnly": true,
    "path": "/"
  },
  "auth_redirect_uri": "http://localhost:3000/profile?auth_callback=1",
  // same parent object session token 
  "keycloak-token": {
    "access_token": "g",
    "expires_in": 172795,
    "refresh_expires_in": 172795,
    "refresh_token": " sss",
    "token_type": "bearer",
    "id_token": "eYEaA",
    "not-before-policy": 1565356374,
    "session_state": "682b012d-2466-4d84-98cb-f46cdec4057a",
    "scope": "openid"
  },
  "userId": "managed user Id",
  // Other user details of the managed user 
  "roles": [
    "ROLES",
    "OF",
    "MANAGED ",
    "USER"
  ],
  "orgs": [
    "ORG_001"
  ],
  "rootOrgId": "ORG_001",
  "rootOrghashTagId": "b00bc992ef25f1a9a8d63291e20efc8d",
  "rootOrg": {
    "dateTime": null,
    "preferredLanguage": "English",
    "keys": {
      "signKeys": [
        "5766",
        "5767"
      ],
      "encKeys": [
        "5766",
        "5767"
      ]
    },
    "approvedBy": null,
    "channel": "ROOT_ORG",
    "description": "Andhra State Boardsssssss",
    "updatedDate": "2018-11-28 10:00:08:675+0000",
    "addressId": null,
    "provider": null,
    "locationId": null,
    "orgCode": "sunbird",
    "theme": null,
    "id": "ORG_001",
    "communityId": null,
    "isApproved": null,
    "email": "support_dev@sunbird.org",
    "slug": "sunbird",
    "identifier": "ORG_001",
    "thumbnail": null,
    "orgName": "Sunbird",
    "updatedBy": "1d7b85b0-3502-4536-a846-d3a51fd0aeea",
    "locationIds": [
      "969dd3c1-4e98-4c17-a994-559f2dc70e18"
    ],
    "externalId": null,
    "isRootOrg": true,
    "rootOrgId": "ORG_001",
    "approvedDate": null,
    "imgUrl": null,
    "homeUrl": null,
    "orgTypeId": null,
    "isDefault": true,
    "contactDetail": [
      {
        "phone": "213124234234",
        "email": "test@test.com"
      },
      {
        "phone": "+91213124234234",
        "email": "test1@test.com"
      }
    ],
    "createdDate": null,
    "createdBy": null,
    "parentOrgId": null,
    "hashTagId": "b00bc992ef25f1a9a8d63291e20efc8d",
    "noOfMembers": 5,
    "status": 1
  }
}
```

**Pros** :

1. Simple to do.

**Cons** :

1. Managing session data each time when profile is switched.
2. Session ID remains same for user and managed user profile.

### Solution 3:

![](<../../../../Design/FullExport/images/storage/Untitled Diagram (9).jpg>)

Things to reinitialise -

* Telemetry
* User profile
* Update UserId and session ID in elements in index.html

**Challenges :**

* Securing switch user API as it can generate token/login any user.
* Securing API for mobile as mobile will generate token from portal

**Notes** -

* 2 user ID current user and switching user id should be send.
* Verifying user id after fetching details

**Things to discuss** -

* Storing session id and mapping it with User Id in cassandra (where portal store sessions)
* Cassandra TTL might delete the other mapped data (not sure NOC team says they dont add explicit TTL currently).
* Fetch user details should give details of parent if parent exists
* How to do in mobile
* How mobile will support offline swtich (as switch requires to generate token)

### Conclusion

* Team to follow Solution 2.
* Parent’s token will be used and child’s token will not be generated.
* Session data to be updated with child user profile data. Just changing the session data is required no need to change cookie and generate new session.
* Re initialisation of telemetry server and user service.

***

\[\[category.storage-team]] \[\[category.confluence]]

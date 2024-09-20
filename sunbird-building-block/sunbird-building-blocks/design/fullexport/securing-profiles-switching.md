# Securing-Profiles-Switching

### Introduction:

This document describes the design approach for securing of switching of Managed User’s account

### Background:

Jira Issue: [https://project-sunbird.atlassian.net/browse/SH-95](https://project-sunbird.atlassian.net/browse/SH-95)

Epic: [https://project-sunbird.atlassian.net/browse/SH-67](https://project-sunbird.atlassian.net/browse/SH-67)

Presently user can be switched to managed user’s profile and managed-user can consume application as a normal user.

### Problem Statement:

Currently switch of user is not secured

### Existing workflow:

User login in to his account and starts using application.

Parent’s token is used for managed-user actions.

![](<../../../../Design/FullExport/images/storage/Untitled Diagram.jpg>) **Change request:**

For managed Users’s an extra MUT should be send in API’s.

Below is current data stored in session

Current Session object

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

![](<../../../../Design/FullExport/images/storage/Untitled Diagram.jpg>)

1.  user/search API to be intercepted at portal backend.

    A. portal backedn to save token into current user’s session.

    B. Only user related information is send to front end.
2.  User initiated switch.

    A.Portal backed maps the saved data of switched user.

    B.Deletes other user data
3. Save JWT token in session for furthur use
4. Add headers for all required API and send token

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
  //sameparentobjectsessiontoken"keycloak-token": {
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
  //Otheruserdetailsofthemanageduser"roles": [
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
    "status": 1,
    managedUserTokens: {
      "userId1": "token",
      "userId2": "token2"
    }
  }
}

      
```

**Pros** :

1. Not exposing MUT.

**Cons** :

1. Storing large redundant data in session.

### Solution 2:

![](<../../../../Design/FullExport/images/storage/Untitled Diagram (1).jpg>)

**Pros** :

1. Token not being exposed in frontend.
2. Session data does not have redundant data

**Cons** :

1. Extra API call to LMS service (user/search)

### Solution 3 :

![](<../../../../Design/FullExport/images/storage/Untitled Diagram (2).jpg>)

**Pros** :

1. Only MUT stored in session.
2. Verification of request before switching of user addes extra security to existing swtich user flow.

**Cons** :

1. Exposing MUT token into front. Any one can see it and intercepts it and use it furthur.

### Solution 4 :

User Read API can be modified to send user token.

### Conclusion

*

***

\[\[category.storage-team]] \[\[category.confluence]]

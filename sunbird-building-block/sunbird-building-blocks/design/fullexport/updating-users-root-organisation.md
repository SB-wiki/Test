# Updating-User's-Root-Organisation

**Overview** As, most of the users will be doing self sign-up into the sunbird platform, all users will by default belong to default organisation/channel, i.e. Custodian channel. Currently, we do not allow to change the user's root organisation from update user api. As, most user will be now created through self sign-up we need a way to change user's root-org, so that user can be associated with state's root-org, and contribute in the platform based on membership.

**Solution approaches** **Approach 1** Allow updating the root org from update user API.

| Pros                                                    | Cons                                                                                         |
| ------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| Using the same API, so no new API need to be introduced | Role having user-update will be able to carry out the operation, so role cannot be seperated |
|                                                         | Will add and make current business logic and make update method more complex                 |

**Approach 2** Provide additional API to update the user's root-org

| Pros                                                             | Cons                                    |
| ---------------------------------------------------------------- | --------------------------------------- |
| More control on user-role management, we can restrict API access | Introducing new API, one more end-point |
| Better managed from code-design perspective.                     |                                         |

#### API Design

```
{
  "request": {
    "userId" : "id-of-user-to-migrate",
    "rootOrg": "newRootOrg",
    "roles" : ["role1","role2"], //Optional - default just public role
    "organisation" : ["org1", "org2"] //Optional - Roles will be applicable to rootOrg, if nothing passed
  }
}

Response: 200 OK
{
    "id": "api.user.updaterootorg",
    "ver": "v1",
    "ts": "2018-11-20 17:29:16:879+0530",
    "params": {
        "resmsgid": null,
        "msgid": "ac29772e-45e1-4e48-8efb-3882d762b06e",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS"
    }
}

Response 400 Bad Request - User permission issue
{
    "id": "api.user.updaterootorg",
    "ver": "v1",
    "ts": "2018-11-20 17:29:16:879+0530",
    "params": {
        "resmsgid": null,
        "msgid": "ac29772e-45e1-4e48-8efb-3882d762b06e",
        "err": null,
        "status": "UNAUTHORIZED",
        "errmsg": "You are not authorized to update user's root org"
    },
    "responseCode": "Unauthorized",
    "result": {
    }
}


Response 400 Bad Request - Invalid root org
{
     "id": "api.user.updaterootorg",
    "ver": "v1",
    "ts": "2018-11-20 17:29:16:879+0530",
    "params": {
        "resmsgid": null,
        "msgid": "ac29772e-45e1-4e48-8efb-3882d762b06e",
        "err": "INVALID_ROOT_ORG_ID",
        "status": "INVALID_ROOT_ORG_ID",
        "errmsg": "Root Org Id '111' does not exist, please provide a valid Root Org Id"
    },
    "responseCode": "Bad Request",
    "result": {
    }
}
```

**Open doubts:**

* \*\*  \*\* Which role user will have above api call access?
* &#x20; Does caller need to have same role under newly proposed moved org or he can be part of any rootOrg.

**Complete solution/Change required for successful root-org migration** **Check's and warnings for user before proceeding**

* User needs to be shown warning for current suborg membership/roles that user holds if any, will be removed.
* User needs to be shown warning for enrolled courses, that belong to previous root-org, having status "Not Started" or "In Progress"
* User should be asked to un-enroll or complete such courses, before executing root-org migration.

**Actions to be executed for successful migration**

* While fetching courses, if there is any filtering based on root-org, that needs to be removed, while showing user completed courses. (Within sunbird core level there are no business logic for user-course association related to root-org)
* Remove user\_org association, which are invalid according to new root-org to be associated.

***

\[\[category.storage-team]] \[\[category.confluence]]

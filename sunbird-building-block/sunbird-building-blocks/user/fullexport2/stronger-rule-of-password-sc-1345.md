# Stronger-rule-of-password-(SC-1345)

### \*

* [Solution 1:](stronger-rule-of-password-sc-1345.md#solution-1:)
* [Solution 2:](stronger-rule-of-password-sc-1345.md#solution-2:)
* [Solution 3:](stronger-rule-of-password-sc-1345.md#solution-3:)
  * [ Workflow](stronger-rule-of-password-sc-1345.md# workflow) Problem statement:  Since password rule is set inside keycloak and user creation is done from user-service to keycloak, so if the user provides some password which does not match with set policy, then the update password will fail from keycloak.

Keycloak is not providing any API for password validation.

### Solution 1:

&#x20;We can use **regex** for password validation and this regex will be read from env, so that other consumers (portal) can also use the same regex. The system will do password validation prior to user creation. incase password validation failed used will get the error message " **invalid password** .", error code as "INVALID\_PASSWORD" with HTTP code 400.

| Pros                                                                                                                                                                    | Cons                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| password policy changes does not required any code changes, as it's \*\*regex \*\* coming from env, so once env value change will be applied on portal and user-service | Adding one more env will increase DevOps dependency. |

&#x20;&#x20;

### Solution 2:

&#x20; Keycloak password policy support for \*\*regex \*\* (means user can supply regex for supporting password policy), so the same regex can be used for portal and user-service as well. In this way, there is only one regex that is used by all services, so in the future, if any changes required that can be done in one place and changes will reflect in all. Inside keycloak regex can be set as env or directly using admin console. **Setting value inside env need to be explore** , but providing value inside admin console is available.

| Pros                                                                                                  | Cons                            |
| ----------------------------------------------------------------------------------------------------- | ------------------------------- |
| Since all services are using common regex , so future changes applied only one place.                 | increase one new env for DevOps |
| there is no code change , if we use this regex as env only deployment required to see changes impact. |                                 |

### Solution 3:

User-service will use the \*\*regex \*\* to do password syntax validation. This regex will be stored inside the properties file but will have the capability to read from ENV as well.

#### &#x20;Workflow

&#x20;1\. validate user password in user create API

&#x20;   case 1: if validation fails then the system will respond with HTTP code as **400,** error-code as " **INVALID\_PASSWORD** ", error-message as " **The provided password not matched with policy.** "

2. validation of user password :

&#x20;  Create user inside sunbird and then call keycloak API to do password update. now if due to some reason update password failed then it will work in same way as it is working currently.

&#x20; **Note** : In current work flow , we are creating user in sunbird and then calling keycloak password update, incase update password fails , user will get response as below:

```js
 Http code : 200   
 "id": "api.user.create",
    "ver": "v2",
    "ts": "2019-11-18 15:41:14:884+0530",
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS",
        "userId": "903a9327-17e3-46d6-a3cd-5e3dc0538646",
        "err_msg":"User is created but password couldn't be updated.",
        ...
    }
}
```

**Update - 2.8.x -**

Space is disallowed in portal and learner-service. (This is acceptable in KeyCloak).

_At least 1 numeral, 1 upper case, 1 lower case, 1 special character from this list  !"#$%&'()\*+,-./:;<=>?@\[]^_\`{|}\~\_ Here is the [source](https://www.ipvoid.com/password-special-characters/) of the special characters.

Solution 3 is approved and dev team is going to implement it.

***

\[\[category.storage-team]] \[\[category.confluence]]

# LR-328-POC-on-OIDC-support-using-keycloak-

As of now our system is just authorising the users which are stored in our eco-system.

In this POC we are trying to configure Google OIDC and save the users in our eco-system.

As of now we are trying to leverage the OpenID connect with google , flow-chart was mentioned in the doc: [https://docs.google.com/document/d/1dRHyorJUD1VHxL219yreyV9irCsJBrJNV\_pcPFDARNc/edit#heading=h.1tl58f2emzss](https://docs.google.com/document/d/1dRHyorJUD1VHxL219yreyV9irCsJBrJNV\_pcPFDARNc/edit#heading=h.1tl58f2emzss)

![](<../../../../User/Fullexport2/images/storage/Screenshot 2023-03-24 at 11.01.00 AM.png>)Once the user is authenticated, we can get user details and as of now it is getting saved in the keycloak own database, this need to be customised.

Customisation can be done with the support of spi’s provided by the Keycloak.

As of now we customised UserStorageProvider, UserLookupProvider, UserQueryProvider Interfaces for our purpose, right now for saving the user details into our eco-system needs to implement a new interface UserRegistrationProvider

Methods need to override for this activity is:

```
 @Override
  public UserModel addUser(RealmModel realm, String username) {
    logger.info("UserServiceProvider: addUser called");
    return null;
  }

  @Override
  public boolean removeUser(RealmModel realm, UserModel user) {
    return false;
  }
```

Add customised user-fedaration which is “cassandra-storage-provider” in our sunbird. If we are creating a new realm make sure it is not missed.

![](<../../../../User/Fullexport2/images/storage/Screenshot 2023-11-17 at 1.06.32 PM.png>)

After Integrating _**Google as Identity provider**_ , we can see google login for user to login into keycloak.

steps can be followed from : [https://www.keycloak.org/docs/latest/server\_admin/#\_google](https://www.keycloak.org/docs/latest/server\_admin/#\_google)

![](<../../../../User/Fullexport2/images/storage/Screenshot 2023-04-03 at 11.26.54 PM.png>)

![](<../../../../User/Fullexport2/images/storage/Screenshot 2023-04-03 at 11.27.19 PM.png>)

_Flow chart will be added soon…_

These are the logs that rolled while we tested with the existing flow:

```
12:45:37,347 INFO  [org.keycloak.storage.UserStorageProvider] (default task-3) UserServiceProvider: getUserByEmail called
12:45:37,348 INFO  [org.keycloak.storage.UserStorageProvider] (default task-3) UserServiceProvider: getUserByUsername called
12:45:37,352 INFO  [org.sunbird.keycloak.storage.spi.UserSearchService] (default task-3) UserSearchService:post: uri = http://localhost:9000/private/user/v1/lookup, body = {request={fields=[email, firstName, lastName, id, phone, userName, countryCode, status], value=harip@ilimi.in, key=email}}
12:45:42,453 INFO  [org.sunbird.keycloak.utils.HttpClientUtil] (default task-3) Response from post call : 200 - OK
12:45:42,503 INFO  [org.sunbird.keycloak.storage.spi.UserSearchService] (default task-3) UserSearchService:getUserByKey responseMap {id=.private.user.v1.lookup, ver=private, ts=2023-04-03 12:45:42:218+0530, params={resmsgid=359b3384-b900-43bd-9043-8372e42609e4, msgid=359b3384-b900-43bd-9043-8372e42609e4, err=null, status=SUCCESS, errmsg=null}, responseCode=OK, result={response=[]}}
12:45:42,657 INFO  [org.keycloak.storage.UserStorageProvider] (default task-3) UserServiceProvider: getUserByUsername called
12:45:42,664 INFO  [org.sunbird.keycloak.storage.spi.UserSearchService] (default task-3) UserSearchService:post: uri = http://localhost:9000/private/user/v1/lookup, body = {request={fields=[email, firstName, lastName, id, phone, userName, countryCode, status], value=harip@ilimi.in, key=email}}
12:45:43,128 INFO  [org.sunbird.keycloak.utils.HttpClientUtil] (default task-3) Response from post call : 200 - OK
12:45:43,136 INFO  [org.sunbird.keycloak.storage.spi.UserSearchService] (default task-3) UserSearchService:getUserByKey responseMap {id=.private.user.v1.lookup, ver=private, ts=2023-04-03 12:45:43:106+0530, params={resmsgid=6372f639-6e9d-4aa8-a951-d03b5b6b900e, msgid=6372f639-6e9d-4aa8-a951-d03b5b6b900e, err=null, status=SUCCESS, errmsg=null}, responseCode=OK, result={response=[]}}
12:45:43,147 INFO  [org.keycloak.storage.UserStorageProvider] (default task-3) UserServiceProvider: addUser called
```

As of now it is observed email of user is coming in username variable.

```
@Override
  public UserModel addUser(RealmModel realm, String username) {
    logger.info("UserServiceProvider: addUser called");
    return null;
  }
```

***

\[\[category.storage-team]] \[\[category.confluence]]

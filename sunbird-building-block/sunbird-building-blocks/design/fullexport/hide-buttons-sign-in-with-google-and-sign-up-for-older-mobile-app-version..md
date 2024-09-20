# Hide-buttons-'Sign-in-with-Google'-and-'Sign-Up'-for-older-mobile-app-version.

**Problem** Hide buttons 'Sign in with Google' and 'Sign Up' for older version mobile app on the login page.

### Solution&#x20;

This can be done by passing the query parameter with the login URL and displaying buttons only when the parameter has expected value.&#x20;

### Implementation

These buttons will be hidden on the page by default so that it won't be displayed in the older app version. The buttons will be only displayed when if it finds  \*\*`version=1` \*\* in query params. We can read this query parameter value in keycloak login theme javascript file and show these buttons.&#x20;

```
```

\*\*Query parameter name: \*\* The proposed name for query parameter is **version** so that if needed in future we can increase the version value and perform the additional logic as well as we can maintain backward compatibility if needed.

```
```

_**Note:**_ As of now there is no way available in keycloak to read custom query parameter in .ftl file.&#x20;

```
```

**E.g login URL for will be.** [https://DOMAIN/auth/realms/sunbird/protocol/openid-connect/auth?redirect\_uri=https://](https://staging.open-sunbird.org/auth/realms/sunbird/protocol/openid-connect/auth?redirect\_uri=https://staging.open-sunbird.org/oauth2callback\&response\_type=code\&scope=offline\_access\&client\_id=android&)[DOMAIN](https://staging.open-sunbird.org/auth/realms/sunbird/protocol/openid-connect/auth?redirect\_uri=https://staging.open-sunbird.org/oauth2callback\&response\_type=code\&scope=offline\_access\&client\_id=android&)[/oauth2callback\&response\_type=code\&scope=offline\_access\&client\_id=android&](https://staging.open-sunbird.org/auth/realms/sunbird/protocol/openid-connect/auth?redirect\_uri=https://staging.open-sunbird.org/oauth2callback\&response\_type=code\&scope=offline\_access\&client\_id=android&) **version=1** **Cons**

* login URL change will be needed in the portal as well as in tenant pages.&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

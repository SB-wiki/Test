# Sign-Up-Sign-In-using-Google-OAuth-for-Mobile-Portal

### Overview:&#x20;

Currently user can access Sunbird either by using account created by admin or user should register manual by entering basic information and then verifying their Mobile No/Email Id. This is tedious and time consuming process. Registering user, verifying mailed and subsequently allowing user to log in to system can be achieved in single step with google SignIn feature.&#x20;

### Problem statement:&#x20;

Google SignIn feature should solve below problems

* Should support both Mobile and portal.
* Should redirect to appropriate callback url after successful Sign In.

#### Solution:&#x20;

![](../../../../Design/FullExport/images/storage/SignIn\_SignUp\_using\_Google.png)

In this approach google signIn buttons are integrated in Keycloak page. When user clicks signIn with google button state information are passed to portal, same are passed to google as well and they will be retrieved back from google after authentication. After successful google Authentication, If user mailed dosnt exist in sunbird system they are created. Based on the state information obtained from google callback user redirected to Portal/mobile. If the google authentication fails they will be redirected to error page.&#x20;

### Google Sign In url:

**/google/auth**

Mandatory Param expected

1. client\_id(android/portal)
2. redirect\_uri(/home, /learn etc)
3. error\_callback
4. scope(openid/offline\_access)
5. state(any value)
6. response\_type(code)

#### Scenarios:

1. Sign In from mobile, callback url and state are missing, after successful authentication redirect to /home.&#x20;
2. Sign In from portal, callback url and state are missing, after successful authentication redirect to /home.
3. Sign In from mobile, google Authentication fails, redirect back to error page.&#x20;
4. Sign In from portal, google Authentication fails, redirect back to error page.&#x20;
5. Sign In from mobile, after google Authentication, getting user information from google api fails.&#x20;
6. Sign In from portal, after google Authentication, getting user information from google api fails.&#x20;
7. Sign In from mobile, After successful google auth, checking user exist api fails, redirect to error page.
8. Sign In from portal, After successful google auth, checking user exist api fails, redirect to error page.
9. Sign In from mobile, After successful google auth, user doesnt exist, creating user fails. redirect to error page.
10. Sign In from portal, After successful google auth, user doesnt exist, creating user fails. redirect to error page.

***

\[\[category.storage-team]] \[\[category.confluence]]

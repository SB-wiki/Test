# Google-Sign-in-Flow-in-Portal

**Overview:** User sign in to Sunbird/Diksha is handled by the portal.

Currently, the portal uses Google plus API to fetch the user profile when the user tries to sign-in using google.

**Problem statement:** Google has shut down Google Plus API from 7 March 2019. Google has also stopped new integration with google plus api.

**Approach :** Instead of using google plus API portal will be using google auth API to fetch the user details.

Fetch the Code from google (once the user is authenticated by Google) using which call Oauth API to generate token.

Using the token extract the information from the token decoding the token.

Check if the user information is available in token proceed else call oath API to fetch user information.&#x20;

**Flow Chart :** ![](<../../../../Design/FullExport/images/storage/Google Sign Flow.jpg>)

Sample token fetched from google API

```
{

  "iss":"accounts.google.com",

  "at_hash":"HK6E_P6Dh8Y93mRNtsDB1Q",

  "email_verified":"true",

  "sub":"10769150350006150715113082367",

  "azp":"1234987819200.apps.googleusercontent.com",

  "email":"jsmith@example.com",

  "aud":"1234987819200.apps.googleusercontent.com",

  "iat":1353601026,

  "exp":1353604926,

  "nonce":"0394852-3190485-2490358",

  "hd":"example.com"}



Response sample received after fetching user profile from google oauth2 server([https://www.googleapis.com](https://www.googleapis.com)/oauth2/v2/userinfo).


```

\| {  "sub":"10769150350006150715113082367", "name": "Aaron Parecki", "given\_name": "Aaron", "family\_name": "Parecki", "picture": "[https://lh4.googleusercontent.com/-kw-iMg](https://lh4.googleusercontent.com/-kw-iMgD)j34/AAAAAAAAAAI/AAAAAAAAAAc/P1YY91tzesU/photo.jpg", "email": "aaron.parecki@okta.com", "email\_verified": true, "locale": "en", "hd": "okta.com"} |

```


Auth url google endpoint - https://accounts.google.com/o/oauth2/v2/auth.
```

Oauth2 token generation endpoint - https://oauth2.googleapis.com/token

```
Oauth2 fetch user information endpoint - https://www.googleapis.com/oauth2/v2/userinfo
```

References -&#x20;

* &#x20;[GooglePlus Api Shutdown](https://developers.google.com/+/mobile/android/api-deprecation)
* &#x20;[Google Auth Setup](https://developers.google.com/identity/protocols/OAuth2)&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

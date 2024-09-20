
## Kong Token Test Scenarios:

* The behavior of the mobile devices when kong registration fails.



 **Expected Behaviour:**  The mobile devices fail with a 401 unauthorized status code.

 **Actual Behaviour:**  The mobile device fails with 401 unauthorized status code and on the next API call for telemetry Sync or any other user API call device_register is called again and mobile device registers again.  


* Impact Analysis on the mobile device jwt when Kong mobile device consumer ACL\[Permissions] are updated.



 **Expected Behaviour:** We should get the 403\[Forbidden] from kong and API should not be accessible.

 **Actual Behaviour:** Actual behavior is the same as expected behavior, the API fails with 403 Forbidden request, and the device register is called as part of the API failure.


* What happens when we get a 401 or 403 from Kong token: Device register will happen and the bearer token will be reregistered if not exists.  




## Keycloak token Test Scenarios:

* Rotate the keycloak RSA public key and test the token with any API which uses user token



 **Expected Behaviour:**  The mobile APIs should throw 401 unauthorized error code and the mobile app should handle the error code and the tokens should be invalidated.

 **Actual Behavior:**  Same as expected


* What response comes when you try to exchange refresh token for access token after the keycloak offline tokens are cleared.



 **Expected Behaviour:**  The refresh AUTH should throw 400  error code and the user should be logged out from the existing session.

 **Actual Behavior:**  Same as expected


* What happens when we get a 401  from keycloak token



 **Expected Behaviour:**  The mobile app should handle the error code and the tokens should be invalidated.

 **Actual Behavior:**  Same as expected





 **Difference between 401s from Kong and Keycloack** 

Kong 401 response just have a message in its response like following


```
{"message":"Unauthorized"}
```
Keycloack 401 response will have a complete response like following


```
{"id":"api.user.read","ver":"v1","ts":"2020-05-20 13:54:45:443+0000","params":{"resmsgid":null,"msgid":"eaf2a316-cab5-4407-b623-8f906f0c0d5d","err":"UNAUTHORI
ZED_USER","status":"SERVER_ERROR","errmsg":"You are not authorized."},"responseCode":"CLIENT_ERROR","result":{}
```
 **Scenarios when mobile app refreshes the auth token** 


* When mobile-app gets a response code 401 and message “Unauthorized“ 


* When response code is 403




```
if ((response.responseCode === 401 && response.body.message === 'Unauthorized')
            || response.responseCode === 403)
```


*****

[[category.storage-team]] 
[[category.confluence]] 

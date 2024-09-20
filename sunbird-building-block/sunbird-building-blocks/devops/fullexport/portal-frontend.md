This page contains issues related to Portal


* Refresh Token Timed out Error:

    


```
{"msg":"refresh token api error","error":"{\"code\":\"ETIMEDOUT\",\"errno\":\"ETIMEDOUT\",\"syscall\":\"connect\",\"address\":\"x.x.x.x\",\"port\":443}"}
```


    This is because the portal service is not able to connect to the upstream keycloak service via

    https://domain.name/auth. 

     **Solution** : Restart the portal pods one by one







*****

[[category.storage-team]] 
[[category.confluence]] 

# Resend-Otp

* [Background:](resend-otp.md#background:)
* [Problem Statement:](resend-otp.md#problem-statement:)
* [Solution 1:](resend-otp.md#solution-1:)
* [Solution 2 :](resend-otp.md#solution-2-:)
* [Solution 3:](resend-otp.md#solution-3:)

### Background:

There is a need to resend otp from forgot password page. This workflow is handled by keycloak and there is no configuration in keyclaok to enable resend opt button. As of now user has to come back and againg click on forgot password.

### Problem Statement:

Password is completely handled by Keycloak and there no configuration or endpoint provided by keycloak to do reset password.

### Solution 1:

&#x20;Expose a new end point that will allow user to do resend OTP.

```js
URL : {BaseUrl}/realms/{realmsName}/resendopt

 Request body :
 {
  "userName":"value can be userName,email,phone"
 }

Resposne :
 {

  "Success" or "failure" 
}

// Failure message will be if provided userName not found.



```

### Solution 2 :

&#x20;From keycloak we are not getting more benifit  and it has scale issues as well  and every time for a small changes it's taking more time to complete integration. So we can remove this layer and build auth functionality inside user-org service as well.

| Pros | Cons​ |
| ---- | ----- |
|      |       |

1. Will have complete control and changes will be very easy
2. Reduce one external component dependency

|

1. Initial development cost will be high
2. Initial integration cost

|

### Solution 3:

Forgot password can be done via user-org service /sunbird-lms service. Workflow can be like this.

&#x20;Case 1:&#x20;

&#x20;           Click on forgot password link →  open a form to enter (userName/email/phone) → System will verify user based on provided details&#x20;

&#x20;                Scenario 1:  if user found then send OTP and UI will show enter OTP page

&#x20;               Scenario 2: if user not found then show proper error message

&#x20;           Once OTP is verified by user then aks them to rest password → send user details and new password to sunbird-lms service  → this service will update user password inside keycloak→ on success ask user to login with updated password.

***

\[\[category.storage-team]] \[\[category.confluence]]

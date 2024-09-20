# TNC-flow

**Overview:** Currently, the system enforces the acceptance of T\&C \* after the user registers (submits all their information), and logs in. This acceptance of T\&C has to happen before/ alongside the submission of the users information (on the registration form).

**Current Flow**

* User logs in to the portal
* Portal calls user/read API learner/user/v2/read/{user\_Id}?fields=organisations,roles,locations
*   if promptTnC is true show TNC popup.

    NOTE - Data of tnc is coming from blob sample in userprofile-  [https://preprodall.blob.core.windows.net/termsandcond/terms-and-conditions-v4.html](https://preprodall.blob.core.windows.net/termsandcond/terms-and-conditions-v4.html)Once tnc is accepted portal calls an api to update tnc learner/user/v1/tnc/accept

**Approach :**

###

A) Self sign-up

* After user enters required details for registeration.&#x20;
*   Once user registers send TNC details like accepted time stamp, TNC version, and user details in create-user API.

    OR
* Create a user once successfully created that only call TNC accepted API.

### B) SSO &#x20;

* After the user verifies OTP.
*   Once user registers send TNC details like accepted time stamp, TNC version, and user details in create-user API.

    OR
* Create user once successfully created call after that only TNC accepted API.

### C) Google

* No changes google sign up/in will remain the way it is now. ([Current Google Flow](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1121320977/Google+Sign+in+Flow+in+Portal))

### **Conclusion.**

A) Self sign-up

* User opens the registration page.
* Fetch TNC based on /api/data/v1/system/settings/get/tncConfig API.
* After user enters required details for registeration.&#x20;
* Create new user and then call tnc acceptance API.

### B) SSO &#x20;

* After the user verifies OTP.
* Fetch TNC based on /api/data/v1/system/settings/get/tncConfig API.
* After user enters required details for registeration.&#x20;
* Create a new user and then call tnc acceptance API.

### C) Google

* No changes google sign up/in will remain the way it is now. ([Current Google Flow](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1121320977/Google+Sign+in+Flow+in+Portal))

**Telemetry** Interact event will be there

{

```
"edata": {

"type": "click","subtype": "selected/unselected", "id": "user:tnc:accept", "pageid": "self-signup/sso-signup",

  }

}
```

Note - As TNC accept API requires user-auth-token Portal will first generate token for the user and than call accept tnc api &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

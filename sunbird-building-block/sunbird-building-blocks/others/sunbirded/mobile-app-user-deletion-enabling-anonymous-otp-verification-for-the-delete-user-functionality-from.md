
## Introduction
This guide offers a step-by-step instructions for Sunbird Portal adopters. It outlines how to include anonymous OTP verification for user deletion functionality on the mobile app, and explains the specific changes required to verify OTP from the portal after clicking the delete button on the app. By following the step-by-step instructions, you can easily add this feature to your existing Angular codebase.

To send the query-parameters via the mobile app, Portal requires them to be in the following format.


```
<host>/guest-profile/delete-user?deeplink=<deeplink>&userId=<userId>&type=<contactType>&value=<contactValue>
```
Where


*  **host** : Host of the portal


*  **deeplink** : Deeplink that needs to be sent back to the mobile app once OTP verification is successful


*  **userId** : User ID of the user


*  **type** : Contact type of the user


*  **value** : Masked contact value of the user



Eg:


```
http://test.com/guest-profile/delete-user?deeplink=test.com&userId=1234&type=email&value=te**************@yopmail.com
```

### [Reference PR](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/9153)

### 1. Copy the Components



Components to Add

1.  **Anonymous-delete-user.component** : [anonymous-delete-user](https://github.com/Sunbird-Ed/SunbirdEd-portal/tree/release-7.0.0/src/app/client/src/app/modules/public/module/guest-profile/components/delete-user).


1.  **Anonymous-delete-account.component** : [anonymous-delete-account](https://github.com/Sunbird-Ed/SunbirdEd-portal/tree/release-7.0.0/src/app/client/src/app/modules/public/module/guest-profile/components/delete-account).


1.  **Modified otp-popup.component** : [otp-popup.component.ts](https://github.com/Sunbird-Ed/SunbirdEd-portal/tree/release-7.0.0/src/app/client/src/app/modules/shared-feature/components/otp-popup)




### 2. Code changes

* [Add an anonymous OTP url in UrlConfig.json](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/modules/shared/services/config/url.config.json#L268)


* [Add a new method to generate anonymous OTP in otp.service.ts](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/modules/core/services/otp/otp.service.ts#L20C2-L26C4)


* [Add a new route in guest-profile-routing.module.ts](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/9153/files#diff-5c9f15ab565160ffd38571bdc4e29d09eb5001a8c03be8820d95e1fe087769b8)


* [Import the new components in guest-profile.module.ts](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/modules/public/module/guest-profile/guest-profile.module.ts#L13)


* [Whitelist the anonymous OTP generation API in the portal backend](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/helpers/whitelistApis.js#L694-L700)


* [Allowing the URL in backend](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/9153/files#diff-72a20f4f6f571b002357057ace28d385ded8964df3831f43255a3f9213936d16)


* [Adding route in clientroutes](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/9153/files#diff-f517210041dc0dd4dca9c3c60268e9ee8002b576378d675bd5c420ac5116b7be)


* [Converting anonymous OTP generation API into OTP generation API](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/routes/learnerRoutes.js#L116)


* [Adding route in desktop](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/9153/files#diff-df5e45fccce4e9dde7d8c190162b6cb906061f6387d1033c9ffb9eff260dc066)


* [Add required resources in resource-bundles](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/8997/files#diff-44f7518aac54b66a38e1aaacf8a77cdddc71d360da11d34525fefa453ed4fae3)




### 3. Testing

1. Test the newly added components by navigating to their respective routes in the portal.


1. Test the OTP verification functionality thoroughly to ensure it works as expected after clicking the delete button on the mobile side.




## Conclusion
By following these steps, you should be able to successfully add delete user functionality to the Sunbird Portal Angular codebase and implement the necessary changes to verify OTP from the portal side after clicking the delete button on the mobile side. If you encounter any issues, refer to the Angular documentation or reach out to the development team for assistance.



Reference:

[[Deep Link Implementation for Delete User Functionality|Deep-Link-Implementation-for-Delete-User-Functionality]]

[[Delete User functionality for adopters|Delete-User-functionality-for-adapters]]



*****

[[category.storage-team]] 
[[category.confluence]] 

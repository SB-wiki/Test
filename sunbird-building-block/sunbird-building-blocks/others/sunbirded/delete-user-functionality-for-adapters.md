
## Introduction:
This document provides a step-by-step guide for adopting the delete user functionality in the mobile app. 

[Reference PR 1](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/pull/3566) (Sunbird Mobile App)[Reference PR 2](https://github.com/Sunbird-Ed/sunbird-mobile-sdk/pull/824) (Sunbird Mobile SDK)
## Code changes (Mobile App)

1. [Add code changes to profile-page.ts](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/blob/release-7.0.0/src/app/profile/profile.page.ts)


1. [Add customtabs plugin changes to setup.js](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app/blob/release-7.0.0/src/__tests__/setup.js)



Refer [https://project-sunbird.atlassian.net/wiki/x/MYCxyg](https://project-sunbird.atlassian.net/wiki/x/MYCxyg)  for deeplink implementation details.


## Code changes (Sunbird Mobile SDK)
  1. [Create a new file called delete-profile-data.handler.ts and add the code changes](https://github.com/Sunbird-Ed/sunbird-mobile-sdk/blob/release-7.0.0/src/profile/handler/delete-profile-data.handler.ts).

   2. [Create a new file called delete-account-handler.ts and add the code changes](https://github.com/Sunbird-Ed/sunbird-mobile-sdk/blob/release-7.0.0_bmgs/src/profile/handler/delete-account-handler.ts)

   3. [Create new file called delete-user-request.ts and add the changes.](https://github.com/Sunbird-Ed/sunbird-mobile-sdk/blob/release-7.0.0_bmgs/src/profile/def/delete-user-request.ts)

   4. [Declare deleteUser method in profile-service.ts](https://github.com/Sunbird-Ed/sunbird-mobile-sdk/blob/release-7.0.0_bmgs/src/profile/def/profile-service.ts).

   5. [Add the deleteUser method implementation in profile-service.impl.ts](https://github.com/Sunbird-Ed/sunbird-mobile-sdk/blob/release-7.0.0_bmgs/src/profile/impl/profile-service-impl.ts)

Check [[\[Mobile app user deletion] : Enabling anonymous OTP verification for the Delete User Functionality from mobile in the Portal|[Mobile-app-user-deletion]---Enabling-anonymous-OTP-verification-for-the-Delete-User-Functionality-from-mobile-in-the-Portal]]


## Integration and Testing:

1. Integrate the changes into the mobile app codebase.


1. Ensure that the necessary imports and dependencies are resolved.


1. Run the application on a test environment or device.


1. Click on the "Delete Your Account" button in the profile page.


1. Verify that the app redirects to a Chrome webpage for the deletion process.


1. Complete the required actions, such as entering OTP, on the webpage.


1. After successful deletion, ensure that the user is redirected back to the mobile app.





 **_IMPORTANT:-_** [ **_To see instructions for Sunbird Portal adapters on how to add anonymous OTP verification related to delete user functionality from mobile app in portal to the existing Angular codebase, refer_** ](https://project-sunbird.atlassian.net/browse/ED-4261)[[\[Mobile app user deletion] : Enabling anonymous OTP verification for the Delete User Functionality from mobile in the Portal|[Mobile-app-user-deletion]---Enabling-anonymous-OTP-verification-for-the-Delete-User-Functionality-from-mobile-in-the-Portal]][](https://project-sunbird.atlassian.net/browse/ED-4261)





*****

[[category.storage-team]] 
[[category.confluence]] 

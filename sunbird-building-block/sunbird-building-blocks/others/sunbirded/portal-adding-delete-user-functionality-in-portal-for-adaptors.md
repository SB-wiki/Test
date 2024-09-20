
## Introduction
This document contains detailed instructions for Sunbird Portal adapters on how to integrate the delete user functionality into the current Angular codebase in Angular@14. Additionally, it outlines the steps needed to implement the changes required for verifying the OTP after the delete button is clicked on the portal.

 **_NOTE: Ensure that the backend changes are completed before making changes in the portal._** 

[ **Reference PR-1** ](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/8997)[ **Reference PR-2** ](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/9047)
## Steps to add the front-end changes in the portal

1. Copy the components


1. Code Changes (Front-end)


1. Testing




### 1. Copy the Components
The following components need to be added to the codebase:


1.  **delete-user.component** : [delete-user.component](https://github.com/Sunbird-Ed/SunbirdEd-portal/tree/release-7.0.0/src/app/client/src/app/plugins/profile/components/delete-user)


1.  **delete-account.component** : [delete-account.component](https://github.com/Sunbird-Ed/SunbirdEd-portal/tree/release-7.0.0/src/app/client/src/app/plugins/profile/components/delete-account)


1.  **Modified otp-popup.component** : [otp-popup.component](https://github.com/Sunbird-Ed/SunbirdEd-portal/tree/release-7.0.0/src/app/client/src/app/modules/shared-feature/components/otp-popup)




### 2. Code changes

* [Add user delete url in UrlConfig.json](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/modules/shared/services/config/url.config.json#L121)


* [Add a new template for delete user in app.config.json](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/modules/shared/services/config/app.config.json#L1481)


* [Add a new button in profile-page.component for delete user](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/plugins/profile/components/profile-page/profile-page.component.html#L245-L275)


* [Do code changes in profile.page.component for authorisation and telemetry](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/8997/files#diff-733253522d69f3a6c24def21f81e490f9fab176b6e580a6f04cf8270369ddfe2)


* [Add a new method to delete user in user.service.ts](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/modules/core/services/user/user.service.ts#L340-L353)


* [Add a new route in profile-routing.module.ts](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/plugins/profile/profile-routing.module.ts#L38-L48)


* [Import the new components in profile.module.ts](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/client/src/app/plugins/profile/profile.module.ts#L63-L64)


* [Whitelist the delete-user API in the portal backend](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/helpers/whitelistApis.js#L437-L440)


    * [Add in URL Pattern](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/helpers/whitelistApis.js#L2075)



    
* [Creating delete user API in portal backend](https://github.com/Sunbird-Ed/SunbirdEd-portal/blob/release-7.0.0/src/app/routes/learnerRoutes.js#L48-L74)


* [Add required resources in resource-bundles](https://github.com/Sunbird-Ed/SunbirdEd-portal/pull/8997/files#diff-44f7518aac54b66a38e1aaacf8a77cdddc71d360da11d34525fefa453ed4fae3)




### 3. Testing

1. Test the newly added components by navigating to their respective routes in the portal.


1. Test the delete user functionality thoroughly to ensure it works as expected after clicking the delete button on the profile page



Refer:[[\[Portal] Flow of Delete User Account|[Portal]-Flow-of-Delete-User-Account]]


## Conclusion
By following these steps, you should be able to successfully make code changes for the  **delete-user**  functionality to the  **Sunbird Portal**  Angular codebase. If you encounter any issues, refer to the Angular documentation or reach out to the development team for assistance.



*****

[[category.storage-team]] 
[[category.confluence]] 

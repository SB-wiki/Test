# \[PRD]-Delete-Account-functionality

* [Overview](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/3351969808/PRD+Delete+Account+functionality#Overview%3A)
* [Proposed System Requirements](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/3351969808/PRD+Delete+Account+functionality#%5BhardBreak%5DProposed-System-Requirements%3A)
* [Phase 1 : Allow deletion of account only by Public users](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/3351969808/PRD+Delete+Account+functionality#Phase-1-%3A-Allow-deletion-of-account-only-by-Public-users)
* [Phase 2 : Allow deletion of account only by all users](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/3351969808/PRD+Delete+Account+functionality#Phase-2-%3A-Allow-deletion-of-user-account-by-all-users)
  * [Finalised Approach](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/3351969808/PRD+Delete+Account+functionality#Approach-2%3A)
  * [Ownership transfer](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/3351969808/PRD+Delete+Account+functionality#Script-for-Transfer-of-ownership-of-assets)

**Overview:** **Feature Description: Account Deletion Functionality** The primary objective of the Account Deletion Functionality is to empower registered users with the autonomy to seamlessly delete their accounts from the platform. This functionality encompasses the complete removal of user credentials and personal information from the system.

**Impact on Adoption: iOS & Android Versions** The integration of the iOS and Android versions of the application faces a direct challenge due to the stringent policy mandates established by the App Store and Google Play Store. Adherence to these policies mandates the inclusion of the account deletion functionality within the application.

**Recent Platform Requirements: App Store and Google Play Store** The recent updates from major platforms such as the App Store and Google Play Store necessitate the mandatory inclusion of the account deletion functionality in all applications. The specific policy mandates can be found using the following links:

* [App Store Data Collection and Storage Guidelines](https://developer.apple.com/app-store/review/guidelines/#data-collection-and-storage)
* [App Store Offering Account Deletion in Your App](https://developer.apple.com/support/offering-account-deletion-in-your-app)
* [Google Play Store Account Deletion Policy](https://support.google.com/googleplay/android-developer/answer/13327111?hl=en)

**Proposed System Requirements:** **Delete Account Option for Registered Users** Registered users must have access to a "Delete Account" option on both the app and the portal. This option will allow them to initiate the account deletion process themselves.

**Clear Information on Deletion Consequences** Users selecting the "Delete Account" option should receive comprehensive information detailing the outcomes and impacts of the account deletion process. This ensures users are fully aware of what data will be removed.

**Minimum Deletion Functionality Requirements:** The minimum requirements for the account deletion functionality are as follows:

1. Deletion of login credentials to prevent future logins.
2. Deletion of any Personally Identifiable Information (PII) associated with the user, such as name, email, and phone number.
3. Retention of anonymous/anonymised transactional data and user-created content ( _usage,_ _rating etc_ ).
4. Certificates issued to the deleted users will not be accessible, but will be verifiable ( _needs more clarity on deletion_ )

**Deletion Process Flexibility:** The deletion process can occur asynchronously, and users should be provided with an estimated time frame within which their account will be fully deleted.

* Backend will have the capability to allow org admin to delete user accounts

**Backward Compatibility:** The deletion feature must maintain compatibility with previous versions. This feature should be provided as a patch that can be applied to versions prior to 7.0.0.

**Steps Involved :** **User Interface for Account Deletion** A user interface should be implemented to guide users through the account deletion process. Users should receive clear information regarding the implications of account deletion ( _and also the data that will be removed ?_ )

**Data Removal from the Platform:** Upon successful account deletion, the following data should be removed from the platform:

1. User credentials used for signing in.
2. Personally Identifiable Information (PII) including masked data like phone numbers and email addresses.
3. Consent to data usage, including PII, should be reset with a notice of account deletion.
   1. isdeleted flat will be made true and status as 0
   2. Email, phone number.. will be emptied. Consent provided will be 'No'
   3. User entry will not be removed from the reports. User Phone and User Email Id columns will be marked as User account deleted.
   4. OR
   5. User entry will not be removed from the reports.User Phone and User Email Id columns will be deleted/cleared. The report will contain another column which will have the status of the user account - Deleted / Active / Inactive.

**Data Retention Post Deletion:** Certain data will not be deleted after a user's account is removed:

1. Anonymous usage and consumption data in an anonymous form, linked via UUID.
2. For certificate verification, only the user's name will be stored.
3. Usage reports' location data declared by the user.

**Consequences and Considerations:**

* Account deletion **does not affect resource consumption** on the platform.
* Deleted users will be logged out and treated as guest user.
* Account deletion requires proof of ownership via OTP.
* There might be a lead time for account deletion completion (need to specify).
* After the completion of account deletion, the same credentials can be used to register again as a new user.
* Only active user accounts can be deleted. Incase of inactive/blocked users the Org Admin will have to change the account status to active, to be able to delete the account. _However, the backend will have the capability to allow Org Admin to delete user accounts._
* Incase of SSO user if the account is deleted, during the next sign-in, a new account will be created which will not have any historic information.
* If a user who deletes his account has created a thread in the discussion forum, posted comments, after deletion, the name will be displayed as Deleted User
* If a group admin/owner deletes his account, no action required if there is another group admin.If not, another user (random) can be assigned as the default group owner
* Incase of a user having multiple profiles in one account, all the profiles will be deleted.
* ECAR used for offline use will have the creator’s name in the index file, which may still exist after the creator(user) has deleted their account since we will not be re-publishing.
* Any personally identifiable information (PII) present within content metadata properties or direct properties will be deleted. PII information stored in JSON format or any other files will not be handled (deleted).

Phase 1 : Allow deletion of account only by Public users **Account Deletion User Flow :**

1. User logs in.
2. User opens the menu (commonly referred to as the "burger menu").
3. User navigates to the settings or profile section.
4. User initiates the account deletion process by clicking/selecting the "Delete Account" button.
5. User receives comprehensive information about the impact of deletion based on the user role and the steps they need to complete or consider before proceeding with the deletion (eg. download certificates). Along with this, the user will be informed on what data will be retained after deletion
   1. Users check off a checklist

```
 Personal Information: Your personal account information, including your profile and login details, your activity history, will be permanently deleted. This information cannot be recovered.
* Certificates: For certificate verification purposes, only your name will be stored.
* Access Loss: You will lose access to all features and services associated with this account, and any subscriptions or memberships may be terminated.
* Single Sign-On (SSO): If you use Single Sign-On (SSO) to sign in, be aware that a new account will be created the next time you sign in. This new account will not have any historical information.
* Resource Retention: Even after your account is deleted, any contributions, content, or resources you have created within the portal will not be deleted. These will remain accessible to other users as part of the collective content.You will no longer have control or management rights over them.
* Usage Reports: Usage reports will retain location data declared by you.
* Make sure you have backed up any important data and have considered the consequences before confirming account deletion and downloaded your certificates.
```

```
1. Users gain the ability to finalise the account deletion


1. \[Phase 2] Org Admin will be notified incase of transfer of user roles or resource ownership.



```

1. User confirms their intention to delete the account.
2. User validates the deletion request using an OTP (One-Time Password) via SMS & email.
3. After successful validation, the user is automatically logged out of the platform.

**Backend Flow**

_This will be required to identify users who may have contributed resources through coKreat and are public users in Ed_

* Once the deletion of user is triggered from the UI, check if the deleted user owns any resources / content
* If yes, _the creator name will be changed to `Deleted User`, (which is configurable_ ) and Org admin/support team has to be notified in the feed via email, showing the list of collections & content owned by the deleted user.
* Support team will have to trigger transfer of ownership of the resources, to another user using the script provided for ownership transfer (with the help of support/implementation team).
  * Incase of contributor/creator who is part of an organisation, the org admin/support team can assign creator role to the sourcing org admin and transfer the resource to him/her
  * Or the support team can transfer the resources to another user in the org, who has creator access. The decision will be made by the Org admin.

## Phase 2 : Allow deletion of user account by all users

[Approach 2](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/3351969808/PRD+Delete+Account+functionality#Approach-2%3A) is Finalised

Approach 1: Allow Creator Role / Program designer Role & Course Mentors to delete their account (apart from public users) and reallocate the content / resources owned by these deleted users.

**User Flows for Different Platform Roles Before Deletion:**

1. **Creator Role / Program designer Role:**
   1. User will be informed that the assets created, transactional data (etc.,) will be retained and the ownership of content resources will be transferred. The Org admin will be notified in the feed and also via email.
   2. _Org Admin will be able to assign the ownership to any other user with the required user role._
2. **Course Mentors :**
   1. User will be informed that the assets created, transactional data (etc.,) will be retained and the ownership of resources will be transferred. The Org admin will be notified in the feed and also via email.
   2. _Org Admin will be able to assign the ownership to any other user with the required user role._
3. **Org Admin** (Program Managers in cokreat) **:** If there is no other user in the Org Admin role, then the user must dissociate from the role before deletion, and transfer admin rights and assets/ resources.
   1. _The Org admin will be able assign any other user with the Org admin role._
4. **Report Admin:** If there is no other user in the Report Admin role and if there is at-least one Org admin, he/she will be notified
   1. _Org Admin will be able to assign any other user with the required user role._

**Platform Role-Specific Impact of Account Deletion:** Detailed impacts for each platform role upon account deletion:

1. **Creator Role / Program designer Role:** No resource creation or editing; no access to resource/program data.
2. **Manager/Mentor:** No management or mentorship; no access to program/resource data.
3. **Org Admin** (Program Managers in cokreat) **:** Loss of admin rights and PII data access.
4. **Report Admin:** Will not be able to access or publish reports.
5. **Report Viewer:** Will lose access to dashboards post-deletion.
6. **Reviewer:** Will not be able to review, reject, or publish resources.
7. **Users Consuming Resources:** Will lose access to certain features post-deletion; for eg, once the account is deleted, users will not be able to take any actions on the app except the ones that are available to the guest users.

**Admin User Flow:** All the Org Admin(s) for that particular organisation will be notified (user feed & email) regarding the account deletion along with their respective user roles and list of resources to be re-allocated.

1. All the Org Admins will receive an email notifying the deletion of the user account along with their user roles and
   1. The instruction to re-assign ownership of assets, previously owned by the deleted user (if any).
2. The Org Admin will receive a notification in the SunbirdEd portal/App with the same message.
3. Upon opening the notification, the user will be redirected to a page where the assets to be re-assigned are listed.
4. The org admin can multi-select the resources to be re-assigned.
5. Select the action to be performed from the kebab menu (more actions menu)
6. Based on the selection, the admin can assign it to a selected user.
   1. Admin selects 'Assign / transfer ownership'
   2. A pop-up is displayed with and he/she will be able to search for users in required roles and assign ownership. (also filter based on the user roles from a drop-down)
   3. The assigned user needs to have the corresponding role assigned to them, this will be validated For eg, if the resource is assigned to a user, the user should have either creator or course mentor role.
   4. If not, an alert will be shown mentioning the same and the admin will have to find another user with the permission or assign the required user role to the user
   5. If not, the transfer of ownership will be successful
7. The admin will be shown the confirmation of ownership transfer

Deletion EventThe event will be triggered upon deletion of a user and will generate a list of suggested

* For each of the role assigned to the deleted users, list of 5 suggested users should be generated
* 5 random users can be selected from each user role

## Approach 2:

Creator / Program designer Role & Course Mentors will not be allowed to delete their account directly. Upon clicking on `Delete Account`, they will notified about their unique role and the restriction on account deletion. And also informing them to contact support.

The support/admin will be provided with a script to transfer resources from one user to another. Upon finishing this transfer, the admin can dissociate the creator role from the user and make them a public user hence allowing them to delete thier account.

**Account Deletion User Flow :** For all the special users - who are not public user

1. User logs in.
2. User navigates to the settings or profile section.
3. User initiates the account deletion process by clicking/selecting the "Delete Account" button.
4.  The user is provided with information about their assigned user roles and the necessity to disassociate from these roles to gain permission for account deletion.

    1. The user sees a pop-up on the restriction on account deletion.

    Attaching the suggested message here

    1. Creator / Mentor / Program Designer / Program Manager / Report Viewer (any special user except org admin)

    As a result of your unique permissions, the ability to delete your account is currently restricted. If you wish to proceed with the account deletion process, we kindly request that you contact your support team to request disassociation from any special user roles and the transfer of ownership of any resources owned by you.

    1. _Automation of triggering an email request for the same should be optional. If this is enabled,_
    2. The pop will have a button to Email Support to initiate a request to revoke access.
    3. The user confirms the email trigger using a One-Time Password (OTP) sent via SMS and email

![Email Support.png](<../../../../Design/FullExport/images/storage/Email Support.png>)

```
1. Upon confirmation, an email preview will be displayed to the user which the user can edit, and upon confirming which, the email is sent to the support team, indicating the deletion request.


1.  _Email will have the list of assets owned by the user ?_ 






1. Org Admin / Report Admin

As the sole Organization / Report admin within the organization, you will not have the ability to delete your account. Kindly get in touch with our support team for further assistance.


1.  _Automation of triggering an email request for the same should be optional. If this is enabled,_ 


1. The pop will have a button to Email Support to initiate a request to revoke access.


1. User validates the triggering of email using an OTP (One-Time Password) via SMS & email.




1. An email is sent to the support team, indicating the deletion request.






1. The support will perform the necessary activities (disassociation from special roles, transfer of ownership) and inform the user.





```

1. The user will now be a public user and will go through the standard deletion flow.

**Admin User Flow:**

1. Org admin will be informed of the request for user account deletion..
2. The Org Admin will utilise a designated standalone script to transfer the user's resources to another user (identified by their user ID).
3. After completing the resource transfer, the Org Admin will remove any special user roles assigned to the user via the portal/app.
4. A confirmation email will then be sent by the Org Admin to the user, giving the confirmation to proceed with the deletion process.

Script for Transfer of ownership of assets

* The script will be taking two Sunbird ID (user ids) as input.
* One id belonging to the user who created assets in the platform and own them
* One id belonging to a user who has the required permission of user role assigned to them, to whom the resources ownership id going to be re-assigned
* The script should transfer ownership of all the assets owned by first user id to the second user id.
* \[Question] Can we easily modify this to give the list of contents/assets to be transferred?

#### Assumptions :

* The user to which the resources are transferred to, will belong the user group who has the permission to take over the ownership.

#### Descoped

**Role change User Flow:**

1. If a user role which has permission to create assets creator is removed from the particular user role,
   1. If the user owns assets.
   2. Content Creator & book Creator- Notify the Org Admin, to transfer the ownership to another user who has the permission / role.

### Disclaimer

* Live questions will have the PIA displayed if the assets owned by the deleted users are not republished. The admin is notified on this and informed that he/she should publish the assets again after transferring the ownership to another user.

FeatureID is DeleteUser

***

\[\[category.storage-team]] \[\[category.confluence]]

# Default-Profile-Visibility-Configuration

### Introduction

This wiki explains the background, problem statement and design to make **default profile visibility settings** configurable in sunbird

### Background

Default profile visibility settings is set for all users at the time of user creation. The fields which are marked as private will not show up in search by other users.

As of now, email and phone are the only default private fields. These fields are marked as private at code-level in user creation flow.

The users can change the visibility settings(public/private) of their data fields, any time.

Profile visibility usecase design link - [https://github.com/ekstep/Common-Design/wiki/%5BSunbird%5D-%5BDesign%5D-Profile-Visibility](https://github.com/ekstep/Common-Design/wiki/\[Sunbird]-\[Design]-Profile-Visibility)

### Problem Statement

Default profile visibility settings are not configurable in sunbird. Email and phone are marked as private fields at code-level.

The default profile visibility settings should be configurable at instance level so that each adopter can configure their own set of private and public fields.

During user creation, data fields should be marked as private based on the configuration.

Jira task link - [https://project-sunbird.atlassian.net/browse/SB-4726](https://project-sunbird.atlassian.net/browse/SB-4726)

### Design

Approach 1Introduce new environment variable,  **sunbird\_default\_private\_fields** , to hold default private fields(separated by comma), with a fallback option in a properties file.

| Pros                                                                                                   | Cons                                                                                                                                                                               |
| ------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <ul><li>Inline with existing design for similar scenarios</li><li>Minimal development effort</li></ul> | <ul><li>Absence of persistence and trackability of the configuration values set in the environment variable</li><li>Server restart is needed to change the configuration</li></ul> |

Approach 2Create an entry, **defaultPrivateFields** , in system\_settings table to hold the configuration values(list type).The user can update the configuration in system\_settings table using APIs.

| Pros                                                                                                                                                                                                                                                                | Cons                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| <ul><li>Persistance of the configuration values</li><li>Configuration is accessible and modifiable using system settings APIs</li><li>Server restart is not needed to change the configuration</li><li>Easier to integrate with admin application, if any</li></ul> | <ul><li>At present, Audit History of system_settings table is not available rendering the configurations untrackable</li></ul> |

Approach 3A new configuration file(json format) should be introduced outside of the sunbird deployables and the path of the configuration file should be set in an environment variable, **sunbird\_private\_fields\_config\_file** , using which the configured data can be read during user creation flow.

| Pros                                                                                                                                                                                                           | Cons                                                                                                                                                                                                  |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <ul><li>More flexibility for the adopter to maintain and track the configurations</li><li>The configuration file can be enhanced later, to hold all adopter specific configurations in a single file</li></ul> | <ul><li>Added dependency on a file outside of sunbird repository</li><li>Increased complexity in deployment, since the configuration file has to be copied over to all nodes in the cluster</li></ul> |

Approach 4A new configuration file(json format) should be introduced outside of the sunbird deployables. Deployment job should be modified to unpack the docker image, place the configuration file in a pre-determined path, repack the docker image and deploy it

| Pros                                                                                                                                                                                                           | Cons                                                                                                                                                                                                                                                  |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <ul><li>More flexibility for the adopter to maintain and track the configurations</li><li>The configuration file can be enhanced later, to hold all adopter specific configurations in a single file</li></ul> | <ul><li>Added complexity in deployment to handle unpack and repack of the docker images</li><li>Added dependency on a file outside of sunbird repository</li><li>More development effort is needed to handle the complexities in deployment</li></ul> |

Approach 5Use config service to store the configuration and have a configuration file, in the same format as data returned by config service, in learner service as fallback option. The fallback configuration file would be adopter specific and hence there's need for custom docker images(unpack and repack image with the fallback config file) in this approach.

| Pros                                                                                                                                                      | Cons                                                                                                                 |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| <ul><li>Adopters have an option to use config service with a fallback mechanism</li><li>Access to current and future features of config service</li></ul> | <ul><li>Single node deployment of config service</li><li>Added complexity in creating custom docker images</li></ul> |

### Selected Approach

On discussion with the design council and the product manager, following approach has been chosen

**Changes in configuration**

1. New environment variable( **sunbird\_enable\_profile\_visibility\_max\_restrictions** ) to be introduced to toggle on/off the profile visibility max restrictions
2. Two types of default profile visibility settings to be stored in system\_settings table.
   1. **profileVisibilityMaxRestrictions** - All data fields, except firstname, lastname and profileSummary, should be marked as private
   2. **profileVisibilityMinRestrictions** - only email and phone should be marked as private
3. When max restrictions are enabled( **sunbird\_enable\_profile\_visibility\_max\_restrictions** **=true** ),  \*\*profileVisibilityMaxRestrictions \*\* would be applied for all new users created henceforth
4. When max restrictions are disabled( **sunbird\_enable\_profile\_visibility\_max\_restrictions=false** ),  \*\*profileVisibilityMinRestrictions \*\* would be applied for all new users created henceforth
5. The adopter can opt for either of the two default settings mentioned above by setting appropriate value(true/false) to sunbird\_enable\_profile\_visibility\_max\_restrictions environment variable which will be defaulted to false
6. JSON format to be used to store values in system\_settings table to support portability, if we choose to move this configuration to registry or config service later

```js
{
	"email":"private",
	"phone":"private",
	"firstname":"public",
	"lastname":"public",
	"address":"public"
}
```

**Changes in existing profile visibility implementation**

At present, the default global settings are being copied over to each user in user table - profileVisibility map at the time of user creation.

Henceforth, the default global settings will not be copied over to each user record. The profileVisibility map will only hold the delta changes done by the user to his profile through front end.

Whenever user data is synced to elastic search, default global settings would be fetched from system\_settings table and would be overwritten with user preferences from user table - profileVisibility map, if it's available. By following this approach, we avoid the need to update all users records in cassandra database when the adopter choose to change the global settings.

**Support to existing users**

A batch job to be built to reset the user preferences( _delete the profileVisibility map_ ) for all users in cassandra database - user table.

If the adopter wish to reset the current visibility settings across users and enforce new visibility settings, they can run this batch. Post successful reset, sync API/batch job needs to be called to sync all the user data again from cassandra to elastic search

### User fields in Sunbird

Data fields     - Fields to hold PII data of the user

Internal fields - Fields that are internal to sunbird to support user maintenance

| Data fields     | Internal fields   |
| --------------- | ----------------- |
| avatar          | id                |
| countryCode     | channel           |
| dob             | createdBy         |
| email           | createdDate       |
| firstName       | currentLoginTime  |
| gender          | emailVerified     |
| grade           | isDeleted         |
| language        | lastLoginTime     |
| lastName        | loginId           |
| location        | password          |
| phone           | profileVisibility |
| profileSummary  | phoneVerified     |
| subject         | roles             |
| userName        | rootOrgId         |
| webPages        | status            |
| jobProfile      | tcStatus          |
| address         | tcUpdatedDate     |
| education       | tempPassword      |
| skills          | updatedBy         |
| organisations   | updatedDate       |
| badgeAssertions | userId            |
|                 | registryId        |

### Default Configuration

|

```java
{
	"firstName": "public",
	"lastName": "public",
	"profileSummary": "public",
	"avatar": "private",
	"countryCode": "private",
	"dob": "private",
	"email": "private",
	"gender": "private",
	"grade": "private",
	"language": "private",
	"location": "private",
	"phone": "private",
	"subject": "private",
	"userName": "private",
	"webPages": "private",
	"jobProfile": "private",
	"address": "private",
	"education": "private",
	"skills": "private",
	"organisations": "private",
	"badgeAssertions": "private"
}
```

|

```java
{
	"email": "private",
	"phone": "private",
	"firstName": "public",
	"lastName": "public",
	"profileSummary": "public",
	"avatar": "public",
	"countryCode": "public",
	"dob": "public",
	"gender": "public",
	"grade": "public",
	"language": "public",
	"location": "public",
	"subject": "public",
	"userName": "public",
	"webPages": "public",
	"jobProfile": "public",
	"address": "public",
	"education": "public",
	"skills": "public",
	"organisations": "public",
	"badgeAssertions": "public"
}
```

|

***

\[\[category.storage-team]] \[\[category.confluence]]

# SB-14445---Visual-identifier-for-validated-state-teachers

### \*

* [Solution ](sb-14445-visual-identifier-for-validated-state-teachers.md#solution )
  * [Approach 1:](sb-14445-visual-identifier-for-validated-state-teachers.md#approach-1:)
  * [Approach 2:](sb-14445-visual-identifier-for-validated-state-teachers.md#approach-2:)
  * [Approach 3](sb-14445-visual-identifier-for-validated-state-teachers.md#approach-3)
  * [Conclusion   ](sb-14445-visual-identifier-for-validated-state-teachers.md#conclusion - )
  * [Updates](sb-14445-visual-identifier-for-validated-state-teachers.md#updates) Problem Statement: As a user, I want to know if I have been validated by my state administrator. In the present form, this information can be derived from the attribute - rootOrgId. If the user's rootOrgId is not a custodian org id, then it is derived that the user is a state validated user.

Ref: [SB-14445 System JIRA](https://browse/SB-14445)

### Solution&#x20;

Since this attribute of state validated is a core user and admin related piece, we would like to make this flag in the backend services only. So, our vote is for Approach 1 in this document. Other approaches are written for discussion purposes.

#### Approach 1:

&#x20;Learner service will add a new identifier "stateValidated" in user request. Below changes required for this approach.

* Filed "stateValidated" is not going to be added as a column in the user table, the value for this filed is converted to binary-value format which is converted to decimal and saved in fiagsValue column in user table.
* During user create , based on associated rootOrg this value will be set as true/false
* Add this field in ES as searchable ,so that admin can get reports
* Write a migration job for old user data , stateValidated field value(boolean flag to decimal value) is updated in fiagsValue column in user table
* Write a job that will take userId and do user Sync (We already have Talend job to do that)

| Pros                                                                              | Cons​                               |
| --------------------------------------------------------------------------------- | ----------------------------------- |
| As business logic to mark user validate in one place , it's easy to manage/update | Required migration job for old user |
| Report can be easily generated using user search api call.                        |                                     |

#### Approach 2:

&#x20;Consumer can add business logic for showing user as state validated or not. As of now this can be done based on user rootOrgId/channel

| Pros​                                      | Cons                                                                                                                        |
| ------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| There is no code change in learner-service | Business logic is expose to client , later it would be difficult to update business logic, specifically for mobile device.  |
|                                            | It's not best practise to expose business intelligence on client.                                                           |
|                                            | Report can not be generated                                                                                                 |

API changesget-user APIOne additional boolean field "stateValidated" is added to response. True indicates that the user is indeed a state validated user, false otherwise.

#### Approach 3

This approach suggests instead of storing individual boolean fields in table, we can store them in a single column - sum and store the flags values as a base10. This change is only in the primary database; shows&#x20;

Notes:

* Each and every individual boolean field is considered as bit and it's value true or false is considered as bit value 1 or 0
* Enums are going to be defined such that flags become enum names and their values are left shifted by 1.&#x20;
* Let's say, there are 3 boolean fields emailVerified, phoneVerified, tncAccepted. emailVerified will be given a value 1, phoneVerified will be given a value 2, tncAccepted will be given a value 4.
* The decimal value is saved into the table(user), creating a new column "flagAttribs" in user table and save into it.
* Existing boolean flags will be removed, only isDeleted flag remains as usual considering its criticality.
* Instead of that boolean flags their respective bit location values are calculated and updated into the "flagAttribs" filed.

| Name                            | Value |
| ------------------------------- | ----- |
| emailVerified                   | 1     |
| phoneVerified                   | 2     |
| tncAccepted                     | 4     |
| emailVerified and phoneVerified | 3     |
| emailVerified and tncAccepted   | 5     |
| phoneVerified and tncAccepted   | 6     |

API changes:get-user API :One additional boolean field "stateValidated" is added to response. True indicates that the user is indeed a state validated user, false otherwise. The other boolean flags continue to be served.

Create-user API/ Update-user API :

* From now boolean flags will not be saved as boolean column in user table, all their cumulative value is saved in "flagsValue" column
* In ES individual boolean fields will be saved and searching can be done these fields.

Bulk-user creation/update API :

* From now boolean flags will not be saved as boolean column in user table, all their cumulative value is saved in "flagsValue" column
* In ES individual boolean fields will be saved and searching can be done these fields.

#### Conclusion  &#x20;

Approach 3 is favoured to be picked up for the following reasons:

1. There are already 3-4 existing flags that can be unified into a single column.
2. Cassandra can work with multi-columns easily, but we have plans to migrate this data into a SQL store. So, a write can be efficient.
3. The Analytics team might want to deposit some flags as well against the user. So these can scale well to a good set of flags we want in future.

#### Updates

tncAccepted = 4 was not done; instead stateValidated = 4 was assigned. Please refer to this code for flag values - [https://github.com/project-sunbird/sunbird-lms-service/blob/release-3.3.0/actors/sunbird-lms-mw/actors/common/src/main/java/org/sunbird/learner/util/UserFlagEnum.java](https://github.com/project-sunbird/sunbird-lms-service/blob/release-3.3.0/actors/sunbird-lms-mw/actors/common/src/main/java/org/sunbird/learner/util/UserFlagEnum.java)

***

\[\[category.storage-team]] \[\[category.confluence]]

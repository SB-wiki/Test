# Telemetry-Event-Validation

**Jira Link :**  [https://project-sunbird.atlassian.net/browse/SB-10786](https://project-sunbird.atlassian.net/browse/SB-10786)

\*\*Overview: \*\*

Need to validate all the telemetry events of LMS service.

**Points to be validate:**

1. Following headers will be sent in all API calls and they should be added to the telemetry for all LOG events of type “api\_access” and SEARCH event
2. x-device-id
3. x-channel-id
4. x-app-id

x-channel-id is already being stored under context as channel.

Following values are not stored currently and needs to be fixed:

* x-app-id header is currently being read as X-app-id. As such, this value is currently being sent as null. This needs to be fixed. We are planning to store this in 'pdata.id'.
* x-device-id header is currently NOT being read. This needs to be fixed. We are planning to store this in 'did'.

2. AUDIT events are required to be generated for all objects - For ex: User, Course, CourseBatch, Badge etc

Verified that AUDIT events are generated all objects.

3. Object or actor types should be in upper camel case. For ex: User, Content, Resource, Collection, Group, UserLocation etc. Distinct object types are listed in this sheet [https://docs.google.com/spreadsheets/d/1se19XYQf7gxb3ZuPQL-ZcmWTn2utIKiBdNg2XMXMXAc/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1se19XYQf7gxb3ZuPQL-ZcmWTn2utIKiBdNg2XMXMXAc/edit?usp=sharing) and should one of the entry in the above sheet. (Reach out to me if any new type needs to be added)

Following object types need to be added.

* BadgeClass
* Location
* SystemSetting
* Note
* Role
* PageSection

We are currently using Batch. Should we change this to CourseBatch or the excel sheet can be updated? (Answer: Use CourseBatch)

Code changes are need to ensure object types are in upper camel cases. At some places object type is currently being sent in lower case.

4. Object type should be there when [object.id](http://object.id) is not null.

Add validation check to ensure object.id and object.type are NOT null. Currently, some events e.g. create batch event is missing object.id.

5. Object rollups are mandatory whenever collection type objects are interacted with like Course, Textbook, Teacher aid etc
6. object.rollup.l1 → should be root level id. For ex: textbook id, course id etc
7. object.rollup.l2 → should be level 1 unit id
8. object.rollup.l3 → should be level 2 unit/sub-unit id
9. object.rollup.l4 → should be level 3 unit/sub-unit/topic id
10. object.rollup.l1 is mandatory whenever events are generated in context of content objects. For ex: in ETB, any interactions in textbook view the [object.id](http://object.id) will be textbook id and object.rollup.l1 would also be textbook id. When a leaf content is opened, or downloaded or played, the [object.id](http://object.id) will be the resource id and object.rollup.l1 would be textbook id

We will ensure context.rollup has organisation hierarchy and object rollup has course / textbook hierarchy.

In create / update batch, create / update note APIs organisation hierarchy needs to be updated in context.rollup.

Add validation check to ensure no rollup value is ever null. This needs to be fixed in the note events currently being generated. \*\* \*\*

If any validation error then use a generic log message string for easy troubleshooting.

e.g. "Learner service telemetry validation error: %s"

6. SEARCH events needs to be generated for all searches generated within lms

a) edata.type needs to be the type of search performed. for ex: location, user, org etc

Working as expected.

b) edata.size is mandatory - this should be the size of search results returned

Working as expected (i.e. size set is the total documents matched as per given filter criteria and not the total documents returned in response as per limit).

c) edata.topn should contain the top n (default configuration as 5) object ids returned by the search

Default configuration to be changed from 2 to 5. This should be configurable property.

7. Correlation data needs to be passed wherever applicable in all audit events. For ex: If a user is enrolled into a course batch and an AUDIT event is generated with [object.id](http://object.id) as UserEnrollment, CourseId and CourseBatchId should be added as “cdata” for the same.

Should type in cdata be upper camel case? (Answer: Yes)

Can we use 'batch' or do we need to specify cdata.type as 'CourseBatchId'? (Answer: CourseBatchId)

Can we use 'user' instead of 'UserEnrollment'?

8. Each batch created for sync should not have more than 200 events

Default configuration needs to be changed from 100 to 200.

***

\[\[category.storage-team]] \[\[category.confluence]]

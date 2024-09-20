# Open-batch-un-enrollment-design

**Overview:**    As of now open batch is allowing user to do the enrollment , but there is no option for un-enrollment.

**Problem Statement:**    Allow user to do the un-enrollment from open batch , if batch is not closed or user haven't completed it.

**Proposed Solution 1 :**      Provide a new api for un-enrollment of open batch. This api call will be allowed for open batch only. Api request structure will be as follow.

Url : /api/course/v1/unenroll

&#x20;{

"request": {

"userId": "string",

"batchId": "string",

"courseId": "string"

}

}

**Solution 2 :** Once user will un-enroll his/her data will be mark as deleted and won't be visible.   Sunbird will provide a new api for un-enrollment for course batch. It will support un-enrollment for open batch and invite only batch both. Participant removal will be decided based on batch type.Request structure will be as follow. Url : /api/course/v1/unenroll   {

"request": {

"userIds": \["user1", "user2"],

"batchId": "batch identifier",

"courseId": "course identifier"

}

}

&#x20;Business Logic:  Check batch type if batch type is open then caller userId (which we get from x-authenticated-user-token) should be same as passed userIds. If batch type is invite-only then call userId should have role of course-mentors.

### Accepted solution:&#x20;

&#x20;     **solution 1 is accepted and dev team is going to implement it.**

&#x20;&#x20;

Task Ref : [SB-7024 System JIRA](https://browse/SB-7024)           [SB-2204 System JIRA](https://browse/SB-2204)   &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

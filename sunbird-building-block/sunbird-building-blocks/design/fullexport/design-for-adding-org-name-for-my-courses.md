# Design-for-adding-org-name-for-'my-courses'

#### Problem Statement

User in sunbird system can see the courses he is enrolled into however it does not reflect the organisation name in the list. There should be enhancement to enable for showing the org name with the courses.

#### Proposed Solution 1

Currently the API to get user enrolled courses are  **/v1/user/enrollment/list/{userId}.**  This API gets the data from ES and returns it to UI, This API needs to be modified in a way that it can additionally find all the organisation for the courses and adds the org name into the response.

UI needs to pass the value required as query param for ex. **orgDeatils=orgName,orgId**

the API will parse all the courseId for user courses and make a call to ContentSearchUtil with param fields to get the org values for all the courses.

corollary 1API will parse and merge the data for each user course to include required details to add the field in original response.

corollary 2API adds the org details for each courses as a separate field like **courseOrgs**

| pros                                                   | cons                                                | remarks |
| ------------------------------------------------------ | --------------------------------------------------- | ------- |
| minimum changes on UI sidestraightforward to implement | Additional sync logic in the API to get the details |         |

Solution 1.1The fetched org details for courses can be stored in Redis for fast retrieval.&#x20;

In this flow before calling Content Service, API would look up into the redis store for org details of user courses, in case the details are missing it would make a call and put it in redis before sending it back to user..

Proposed Solution 2There could be an additional API call where UI can pass all the courseIds for the user to content service and it returns the respective org details for each course in the metadata.

[Content Service search API](http://docs.sunbird.org/latest/apis/content/#operation/Search%20Content)

| pros                                                                                                                   | cons                                                              | remarks |
| ---------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ------- |
| seperate api requires no change in existing APIEven if the new API fails for some reason original flow is not affected | additional work on UIthere might be lag due to extra network call |         |

Proposed Solution 3At the time of storing the user course info in the ES, orgId (and hashtagid) can be added when the user enrolls for the course. The additional detail is used to fetch org details for the user courses.

| pros                                           | cons                                             | remarks |
| ---------------------------------------------- | ------------------------------------------------ | ------- |
| no overhead on the API to call content service | would not work for legacy data without migration |         |

&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

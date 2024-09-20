# SB-29870---Lag-on-User-Enrollment-List-sorting-by-lastAccessdate-on-the-continue-learning-section

**Overview:** Currently Lag on sorting by lastAccessdate on the continue learning section appears in the portal. The reason behind it is that the enrollment list API uses default cache. This cache only updates with the same API when enrollment data is empty.  Hence after a few mins the cache gets cleared and reloads while the API is consumed

**Pr-requisites:**

1. User is a logged in user and has enrolled into at-least one traceable collection

**Linked Issue:**

[SB-29083 System JIRA](https://browse/SB-29083)

**Solutions:**

1. Consuming the user enrollment list API with disabling cache only when after consuming content state API Or Disabling cache from course service&#x20;
2. On updating user content state API update the existing cache&#x20;

**Option 1: Disabling cache for User’s enrollment :** Disabling cache needs to be done from course service by setting below statement in CourseEnrolmentActor as false

```
if (isCacheEnabled && request.getContext.get("cache").asInstanceOf[Boolean])
```

Steps to follow:

```
Set user_enrolments_response_cache_enable to false
portal to send request.getContext.get("cache").asInstanceOf[Boolean] as false
```

**Pros** :

* Faster implementation with only configuration changes&#x20;

**Cons** :

* The API performance can go down&#x20;

**Option 2: On updating user content state API update the existing cache** Current cache implementation reloads the cache whenever the cache is cleared. Now the cache will be required to update/reloaded when the update content state API is triggered..

Steps to follow :

\*\*Update cache \*\*

```
Prepare the map to add in cache:
1. Add enrolment record all fields  from user_enrolments table 
                by userId, courseId, batchId, contentId from the request
2. Add batch details all fields  by CourseId, batchId from CourseBatch index 
               as batch object 
3. Add course details fields from response of  composite search with courseId
       Details : COURSE_NAME,DESCRIPTION,LEAF_NODE_COUNT,COURSE_LOGO_URL,
       CONTENT_ID,COLLECTION_ID,CONTENT
4. Update completionPercentage and status     
Update this map to cache for key request UserId first index 
```

**Reload Cache**

```
Call the getEnrolmentList from CourseEnrolmentActor
Replace the request userId value in cache by getEnrolmentList
```

**Pros** :

* Permanent solution, no portal changes
* No performance degradation, as the operation can be performed asynchronously

**Cons** :

* Complexity in implementation

***

\[\[category.storage-team]] \[\[category.confluence]]

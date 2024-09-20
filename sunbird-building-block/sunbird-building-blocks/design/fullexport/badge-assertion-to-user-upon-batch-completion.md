 **Problem Statement:-** 

Whenever a participant completes a course-batch, active badge associated with the course at the time of completion should be asserted to the user. As a sunbird system, how would we achieve that?



 **Proposed Solution**  :-

We already have badge assertion functionality for the user/content in sunbird. So it will be invoked in background("createBadgeAssertion") putting all the required data in request map.The trigger point for the invocation will be when user has completed the course-batch.

The request body for badge assertion to user is :-


```
{
  "request": {
    "recipientId": "${userId}",
    "recipientType": "user",
    "badgeId": "${badgeId}"
  }
}
```




 **Open Question:-** 


1. Since the badge association is at the course level, there can be a possibility that upon completion of two different batch corresponding to the same course, a user is rewarded the same badge multiple times. Is this the expected behaviour or should we put unique user-badge assertion constraint?



*****

[[category.storage-team]] 
[[category.confluence]] 

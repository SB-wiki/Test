


## Overview 
To organise the any order of tractable collection w.r.t user’s last access date and time on the user enrolment list . We have two solution approach.

Referenced ticket: [https://project-sunbird.atlassian.net/browse/SB-26283](https://project-sunbird.atlassian.net/browse/SB-26283)

 **Pre-requisites:** 


1. User is a logged in user and has enrolled into at-least one trackable collection



 **Solutions:** 


1. Adding new metadata to User’s enrolment 


1. Re-using last access time from User content consumption 






##  Option 1: Adding new metadata to User’s enrolment : 


Adding a metadata to User’s enrollment component as last access timestamp. This metadata needs to  updated while updating **last accessed content id**  for a user. Also for the old records for this metadata requires a migration.



 **Steps to follow** 


1. Add new column  to user_enrolments table 




```
ALTER TABLE sunbird_courses.user_enrolments  ADD last_content_access_time timestamp
```
2. Update the metadata by user content state update Api

3. Migration on old user_enrolments records data migration for  new column needed using user_content_comsumption table 

4. Order the records for list enrolment api to get the expected response 



 **Pros** :


* The ordering process is cleaner and easier



 **Cons** :


* Duplicate data in multiple tables


* Migration is required for existing enrolments.




## Option 2: Re-using last access time from User content consumption:  


While fetch list of user enrolments join user content consumption by the  **last access content id**  to get the  **last access timestamp**  filter by the user id, course id, batch id and last access content id and formulate the response accordingly. This approach would not require the migration steps



 **Steps to follow:** 


1. List enrolment Api for a given user id , make a new DB call for  user_content_comsumption based on user id, batch id, course id and last content id lastreadcontentid  from each records of user_enrolments


1. Merge the response with user_content_comsumption.last_access_time. Order the records 





 **Pros** :


* No migration required.


* Backward compatibility is handled



 **Cons** :


* API might become slower as we connect to multiple tables.






## Conclusion
The last time access collection to be implemented by adding a new column (option 1). No migration is required as update user content state API is frequently called. 







*****

[[category.storage-team]] 
[[category.confluence]] 

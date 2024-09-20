Consumer are the entities which call our API’s.


# CONSUMER CATEGORIZATION
We have categorized our consumers in 3 types.


* Application Consumer - It is our Application itself which uses the consumer JWT key to access the API’s. 


* External Consumers - Users/Applications which are external/Third Party.


* Internal Consumers - Users which are working as part of organization.




# Fork the sunbird repo and edit kong-api/defaults/main.yml file and raise a PR.

```
git clone https://github.com/YourGitId/sunbird-devops.git
vi kong-consumer/defaults/main.yml
# Raise a PR to latest release branch in sunbird-devops
```

# CONSUMER ACL\[ACCESS CONTROL LISTS]
These play a vital role in providing permissions for the consumers and they need to be taken special care. We have categorized ACLs in entities and roles. Each entity will have SuperAdmin, Admin, Create, Update, Access roles.  **Like for instance org API’s the below permissions** .



|  **ENTITY**  |  **Reason For ACL Creation**  |  **ROLE**  | 
| app | application configuration related APIS | SuperAdmin - \[ Super Natural Powers ] Often given to users internal to organisation and never given to machines. | 
| content | content related apis | Admin - \[ Audit, vaildate, flag, retires, block ] | 
| course | course and batch related apis | Update - \[ Update, Sync ] | 
| data | data related apis | Access - \[ Get, List, Read, Enroll ] | 
| dialcode | dial related apis | Create - \[ Create ] | 
| channel | channel related apis | Temp - \[temporary ACL for API's which are kept for legacy purpose and will be removed in a period of 6 months] | 
| sso  | echo api for sso authentication |  | 
| kongConsumer | onboard consumers, kong consumer apis |  | 
| location | location apis |  | 
| mobile | mobile app, mobile device apis |  | 
| mobileOpenRAP | openrap apis |  | 
| mobileTeacherAid | teacheraid apis |  | 
| note | note related apis |  | 
| org | org, tenants related apis |  | 
| experiment | experiment related apis |  | 
| user | user related APIs |  | 
| framework | used for framework and master category and term apis  |  | 
| page | page section related apis |  | 
| announcement | announcement related apis |  | 
| device | device profile or device register apis  |  | 
| badge | badge related apis |  | 
| telemetry | telemetry related apis |  | 
| assertion | assertion related apis |  | 
| license | neo4j license and other license related apis |  | 
| object | object related apis |  | 
| form | forms related apis |  | 
| plugin | plugin related apis |  | 
| certificate | certificate related apis |  | 
| itemSet | itemset related apis |  | 
| desktop | desktop app, desktop device apis |  | 

 **For instance org API’s will have the below Entity and role mapping as described in the below table.** 



|  **ORG APIS**  |  **PERMISSIONS**  | 
| orgSuperAdmin | Bulk Upload/Delete of organisations | 
| orgAdmin | Add/Remove member from organisation | 
| orgCreate | create organisation | 
| orgUpdate | Update organisation details | 
| orgAccess | read organisation details | 

 **CREATING CONSUMERS:** As mentioned Above we have 3 types of consumers, we can create new consumers by updating the variable in the private inventory as mentioned below.


```
# Consumer groups with ACL mapping
username1_acls:
  - orgCreate
  
username2_acls:
  - orgAccess

# Consumers to be on-boarded with consumer group
kong_consumers:
  - username: kong_username1
    groups: "{{ username1_acls }}"
    state: present
    
  - username: kong_username2
    groups: "{{ username2_acls }}"
    state: absent
```

*  Line 1 describes how you can add a  **consumer group**  where you provide  **list of ACL’s** which consumer will get access to.


* Line 9 This block contains the consumers to acl definition, here we provide the consumer name  **username** as  **kong_username** and the  **groups**   the user needs access to, which was defined in the line 1.  




# 


*****

[[category.storage-team]] 
[[category.confluence]] 

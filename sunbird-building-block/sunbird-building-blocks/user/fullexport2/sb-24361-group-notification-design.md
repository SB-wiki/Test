Currently, there is no notifications are sent to user for any operation. From release-4.2.0 it is planned to send notifications to the users of the group whenever there is an important event or activity happening in the group.




# Notifications
[https://docs.google.com/spreadsheets/d/17M7peaM1TbFa7kYx0FhAIWnPDrMajlES1mPTnq2IFss/edit#gid=0](https://docs.google.com/spreadsheets/d/17M7peaM1TbFa7kYx0FhAIWnPDrMajlES1mPTnq2IFss/edit#gid=0) The following notifications will be send based on different actions in the group.

Group Notification will use the new notification create api to create notifications as defined in the document [https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2632613972/SB-24321+Group+Notification+Design+Discussion](https://project-sunbird.atlassian.net/wiki/spaces/UM/pages/2632613972/SB-24321+Group+Notification+Design+Discussion) .




### Notification Create : 
The new notification create API will be used to create a new notifications for the members:


```
curl --location --request POST 'https://dev.sunbirded.org/api/user/notification/create' \
--header 'Content-Type: text/plain' \
--data-raw '{
  "request": {
   "notificatios":[
    { 
    "ids": ["37634e84-70db-421e-898e-06e6554c4483"],    //userId
    "priority":1,                                        
    "type":"FEED",     
    "action": {                                         
          "type": "add-member",                        
          "category": "group-feed",                    
          "template":{
              "type":"JSON",                      //HTML, STRING, XML or JSON
              "params":{
                  "param1":"Math's Activity",
                  "param2": "Test"
                }
           }
          "createdBy":{
		"id":"f10d5216-6b96-404c-8d1c-cc1f720d910d",
		"name":"John",
		"type": "User"				 //User or System
	    },    
          "additionalInfo":{
                "group":{
                    "id":"123434"
                     "name":"Test"
	   	 },
		"groupRole":"admin",                     // Role of the users in the Ids field.
	  	"activity":{
                     "id":"do_12443",
                     "type": "Course",
                     "name":"Math's Activity"  
	    	}		     
           }
     }
   }
   }
   ]
}'
```



### Notification Read : 
notification read api will be used by the client to read the notifications.


```json
{
    "id": "api.notification.feed.read.e79ee6a4-d79c-4236-9e05-f754010932d6",
    "ver": "v1",
    "ts": "2021-05-10 05:54:35:649+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8470ecb7fa05d7d22313a30c9a16927d",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "userFeed": [
                {
                    "id": "ddab7b78-5978-4a11-b7f8-6594c7a6e7b8",
                    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",                    
                    "priority": 1,
                    "createdBy": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "status": "unread",                                        
                    "action": {
                            "type": "add-member",
                            "category": "groups",
                            "template": {
                              "data": "{"title": "आपको Test group में जोड़ दिया गया है"}",
                              "type": "JSON",
                               "ver":  "4.2.0"
                            }, 
                            "createdBy":{
				    "id":"e79ee6a4-d79c-4236-9e05-f754010932d6",
				    "name":"John",
				    "type": "User"
			     },
                           "additionalInfo":{
                               "group":{
                                   "id":"123434"
                                   "name":"Test"
				},
			        "groupRole":"admin",
			       "activity":{
                                   "id":"do_12443",
                                   "type": "Course",
                                   "name":"Math's Activity"  
				}
		   	 }
                            
                    },
                    "createdOn": 1620626043127
                }
            ]
        }
    }
}
```

### Sample Notifications :  
 The following are example response for different notifications

 When member leave the groupAll admins will get the notifications. Key  **_groupRole_**  in the additional info will help to identify the user role in the group who has been notified.


```json
{
    "id": "api.notification.feed.read.e79ee6a4-d79c-4236-9e05-f754010932d6",
    "ver": "v1",
    "ts": "2021-05-10 05:54:35:649+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8470ecb7fa05d7d22313a30c9a16927d",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "userFeed": [
                {
                    "id": "ddab7b78-5978-4a11-b7f8-6594c7a6e7b8",
                    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",                    
                    "priority": 1,
                    "createdBy": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "status": "unread",                                        
                    "action": {
                            "type": "member-exit",
                            "category": "groups",
                            "template": {
                              "data": "{"title": "Mohan has left the Test"}",
                              "type": "JSON",
                               "ver":  "4.2.0"
                            }, 
                            "createdBy":{
				    "id":"e79ee6a4-d79c-4236-9e05-f754010932d6",
				    "name":"John",
				    "type": "User"
			     },
                           "additionalInfo":{
                               "group":{
                                   "id":"123434"
                                   "name":"Test"
				},
			        "groupRole":"ADMIN"
			        
		   	 }
                            
                    },
                    "createdOn": 1620626043127
                }
            ]
        }
    }
}
```


when member is added to the groupWhen member is added to the group only that member will get the notifications.


```
{
    "id": "api.notification.feed.read.e79ee6a4-d79c-4236-9e05-f754010932d6",
    "ver": "v1",
    "ts": "2021-05-10 05:54:35:649+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8470ecb7fa05d7d22313a30c9a16927d",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "userFeed": [
                {
                    "id": "ddab7b78-5978-4a11-b7f8-6594c7a6e7b8",
                    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",                    
                    "priority": 1,
                    "createdBy": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "status": "unread",                                        
                    "action": {
                            "type": "member-added",
                            "category": "groups",
                            "template": {
                              "data": "{"title": "you have been added to Test by John"}",
                              "type": "JSON",
                              "ver":  "4.2.0"
                            }, 
                            "createdBy":{
				    "id":"e79ee6a4-d79c-4236-9e05-f754010932d6",
				    "name":"John",
				    "type": "User"
			     },
                           "additionalInfo":{
                               "group":{
                                   "id":"123434"
                                   "name":"Test"
				},
			        "groupRole":"MEMBER"   
			        
		   	 }
                            
                    },
                    "createdOn": 1620626043127
                }
            ]
        }
    }
}
```
When member is removed from the groupwhen member is removed from the group, only the member who got removed will get the notifications.




```
{
    "id": "api.notification.feed.read.e79ee6a4-d79c-4236-9e05-f754010932d6",
    "ver": "v1",
    "ts": "2021-05-10 05:54:35:649+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8470ecb7fa05d7d22313a30c9a16927d",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "userFeed": [
                {
                    "id": "ddab7b78-5978-4a11-b7f8-6594c7a6e7b8",
                    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",                    
                    "priority": 1,
                    "createdBy": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "status": "unread",                                        
                    "action": {
                            "type": "member-removed",
                            "category": "groups",
                            "template": {
                              "data": "{"title": "you have been removed from Test by John"}",
                              "type": "JSON",
                               "ver":  "4.2.0"
                            }, 
                            "createdBy":{
				    "id":"e79ee6a4-d79c-4236-9e05-f754010932d6",
				    "name":"John",
				    "type": "User"
			     },
                           "additionalInfo":{
                               "group":{
                                   "id":"123434"
                                   "name":"Test"
				},
			        "groupRole":"member"   //MEMBER or ADMIN
			        
		   	 }
                            
                    },
                    "createdOn": 1620626043127
                }
            ]
        }
    }
}
```
when group is deletedWhen group is deleted , all members of the group will get the notifications


```
{
    "id": "api.notification.feed.read.e79ee6a4-d79c-4236-9e05-f754010932d6",
    "ver": "v1",
    "ts": "2021-05-10 05:54:35:649+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8470ecb7fa05d7d22313a30c9a16927d",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "userFeed": [
                {
                    "id": "ddab7b78-5978-4a11-b7f8-6594c7a6e7b8",
                    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",                    
                    "priority": 1,
                    "createdBy": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "status": "unread",                                        
                    "action": {
                            "type": "group-deleted",
                            "category": "groups",
                            "template": {
                              "data": "{"title": ""}",
                              "type": "JSON",
                               "ver":  "4.2.0"
                            }, 
                            "createdBy":{
				    "id":"e79ee6a4-d79c-4236-9e05-f754010932d6",
				    "name":"John",
				    "type": "User"
			     },
                           "additionalInfo":{
                               "group":{
                                   "id":"123434"
                                   "name":"Test"
				},
			        "groupRole":"member"     //MEMBER or ADMIN
			        
		   	 }
                            
                    },
                    "createdOn": 1620626043127
                }
            ]
        }
    }
}
```


when activity is assigned to the groupWhen activity is assigned to the group , all members of the group will get the notifications


```json
{
    "id": "api.notification.feed.read.e79ee6a4-d79c-4236-9e05-f754010932d6",
    "ver": "v1",
    "ts": "2021-05-10 05:54:35:649+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8470ecb7fa05d7d22313a30c9a16927d",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "userFeed": [
                {
                    "id": "ddab7b78-5978-4a11-b7f8-6594c7a6e7b8",
                    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",                    
                    "priority": 1,
                    "createdBy": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "status": "unread",                                        
                    "action": {
                            "type": "group-activity-added",
                            "category": "groups",
                            "template": {
                              "data": "{"title": "Math's has been assigned to the Test by John"}",
                              "type": "JSON",
                               "ver":  "4.2.0"
                            }, 
                            "createdBy":{
				    "id":"e79ee6a4-d79c-4236-9e05-f754010932d6",
				    "name":"John",
				    "type": "User"
			     },
                           "additionalInfo":{
                               "group":{
                                   "id":"123434"
                                   "name":"Test"
				},
			        "groupRole":"member",     //MEMBER or ADMIN
			        "activity":{
			            "id":"do-123243",
			            "type": "COURSE",
			             "name":"Math's"
			         }
			        
		   	 }
                            
                    },
                    "createdOn": 1620626043127
                }
            ]
        }
    }
}
```
when activity is unassigned from groupwhen activity is unassigned to the group whole member will get the notifications.


```
{
    "id": "api.notification.feed.read.e79ee6a4-d79c-4236-9e05-f754010932d6",
    "ver": "v1",
    "ts": "2021-05-10 05:54:35:649+0000",
    "params": {
        "resmsgid": null,
        "msgid": "8470ecb7fa05d7d22313a30c9a16927d",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "userFeed": [
                {
                    "id": "ddab7b78-5978-4a11-b7f8-6594c7a6e7b8",
                    "userId": "e79ee6a4-d79c-4236-9e05-f754010932d6",                    
                    "priority": 1,
                    "createdBy": "e79ee6a4-d79c-4236-9e05-f754010932d6",
                    "status": "unread",                                        
                    "action": {
                            "type": "group-activity-removed",
                            "category": "groups",
                            "template": {
                              "data": "{"title": "Math's has been unassigned to the Test by John"}",
                              "type": "JSON",
                               "ver":  "4.2.0"
                            }, 
                            "createdBy":{
				    "id":"e79ee6a4-d79c-4236-9e05-f754010932d6",
				    "name":"John",
				    "type": "User"
			     },
                           "additionalInfo":{
                               "group":{
                                   "id":"123434"
                                   "name":"Test"
				},
			        "groupRole":"member",     //MEMBER or ADMIN
			        "activity":{
			            "id":"do-123243",
			            "type": "COURSE",
			             "name":"Math's"
			         }
			        
		   	 }
                            
                    },
                    "createdOn": 1620626043127
                }
            ]
        }
    }
}
```


*****

[[category.storage-team]] 
[[category.confluence]] 

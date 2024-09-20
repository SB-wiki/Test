
## Background
Until release 3.1.0, the self declared fields for a custodian org were maintained in the usr_external_identity table but from 3.2.0 the self declared info of the diksha users will be maintened at user_declarations. Hence, as a part of optimization a new update api  _v1/user/declarations_  and  _v3/user/read_ is created.

Please refer the doc for more explanation on this context.

Link: [[SC-1848 Refactor user self-declaration implementation|SC-1848-and-SC--1942-Refactor-user-self-declaration-implementation]]


### Update Api: v1/user/declarations
URL: [http://localhost:9000/v1/user/declarations](http://localhost:9000/v1/user/declarations)

Request:  PATCH: v1/user/declarations
```json
{
    "params": {},
    "request": {     
       
        "declarations": [
            {
                "operation":"<Operations>",      //Mandatory
                "userId": "<userid>",            //Mandatory
                "orgId":  "<orgId>",               //Mandatory
                "persona": "<persona>",          //Mandatory
                "info":{
                    "declared-school-name":"mgm21",
                    "declared-email":"abc@gmail.com",
                    "declared-phone":"99999999",
                    "declared-school-udise-code":"190923"
                },
                "status": "<status>",
                "errorType":"<errorType>"
            }
           
        ]
    }
}
```



*  **operations** : It will have value add, edit or remove.


    * add : when first time user self declare informations.


    * edit: when user wants to edit the declared informations.


    * remove: when user want to delete the self declared informations.



    
*  **userId** : Add ,edit or remove operation of self declarations  will happen against this user id.


*  **orgId:** OrgId is the organization identifier information against which user will submit the self declarations.


*  **persona:** Person is the role of a user who will submit the self declarations such as teacher, volunteer etc.


*  **info:** Info is the self declared value which contains all the self declared  details submitted by user.


*  **status** : status will verify the status of the self declared information. when a users submit their declarations it will be default  **PENDING**  state which can be changed on discretion of admin.


*  **errorType:** It will hold the reason of status changed such as  **REJECTION** .



 **Response** :


```json
{
    "id": "api.user.declarations",
    "ver": "v1",
    "ts": "2020-08-05 12:42:26:751+0530",
    "params": {
        "resmsgid": null,
        "msgid": "ddd15e34-bb20-4c92-b55d-9b5c6f3ebec2",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS"
    }
}
```



### Read: v3/user/read
URL: [http://localhost:9000/v3/user/read/7e78de23-035b-4d12-a284-227d8bbf0d4c?fields=declarations,externalIds](http://localhost:9000/v3/user/read/7e78de23-035b-4d12-a284-227d8bbf0d4c?fields=declarations,externalIds)

 **Response** :


```json
{
    "id": "api.user.read",
    "ver": "v3",
    "ts": "2020-08-05 13:06:58:877+0530",
    "params": {
        "resmsgid": null,
        "msgid": "bbe48220-5422-4971-b79d-672663c324c7",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
            "webPages": [],
            "tcStatus": null,
            "maskedPhone": "******1554",
             ...........
            "userName": "test919",
            "userId": "75cb63c2-7107-415b-9206-b7588dd68cd2",
            "declarations": [
                {
                    "persona": "teacher",
                    "errorType": null,
                    "orgId": "1234",
                    "status": "PENDING",
                    "info": {
                        "declared-email": "abc@gmail.com",
                        "declared-phone": "99999999",
                        "declared-school-name": "mgm21",
                        "declared-school-udise-code": "190923"
                    }
                }
            ],
             "externalIds": [
                {
                    "idType": "channel1235",
                    "provider": "channe12345",
                    "id": "2822"
                },
               // v1, v2 user read was giving declared- attributes here. Note that this is now moved to declarations.
            ],
            "emailVerified": true,
            "framework": {},
            "createdDate": "2020-07-06 14:05:41:579+0530",
            "createdBy": null,
            "location": null,
            "tncAcceptedVersion": null
        }
    }
}
```


*****

[[category.storage-team]] 
[[category.confluence]] 

 **Editor:** 


1. Update Object category definition through postman Add new field under the framework details include the new field called evaluable




```
                     {
                           "code":"mode",
                           "name":"mode",
                           "label":"Select Evaluation Mode",
                           "placeholder":"Select Evaluation Mode",
                           "description":"Select Evaluation Mode client",
                           "dataType":"text",
                           "default":"",
                           "inputType":"select",
                           "editable":true,
                           "required":false,
                           "visible":true,
                           "depends":[
                               "primaryCategory"
                           ],
                           "renderingHints":{
                              "class":"sb-g-col-lg-1"
                           },
                           "range":[
                              "server",
                              "client"
                           ]
                        },
```


2.   Code changes

a. Add question type you want to set  { mode: ‘server’ } in the  editor.config.json

Example 


```
 "evaluableQuestionSet": "PIAA Question Set",
    "server":{"mode":"server"},
    "client":{"mode":"client"},
    "editorModeCheck":"server",
```


b. Depends on type of question set user select from the dropdown  \[“PIAA Question set“, “Practice Question set“ …] set eval mode to { mode: 'server' } or { mode: 'client' }

c. If the selected question set matches to configured question set the eval will be set to { mode: ‘server' }  otherwise { mode: 'client’ }  in node update api.

d.  Override the evaluation feature using evaluation mode field by choosing client or server.



Reference branch:

[https://github.com/sohailamjad12/editor/tree/upsmf-collection-editor](https://github.com/sohailamjad12/editor/tree/upsmf-collection-editor)

sunbird local setup Editor:

[https://inquiry.sunbird.org/use/developer-installation/question-set-editor](https://inquiry.sunbird.org/use/developer-installation/question-set-editor)

 **Player:** 


1. questionSetEvaluable field differentiates between server or client evaluation in quml player code. From questionset hierarchy api and list api consists below object that decides evaluation should happen at server or client.



eval: {mode: "client"} or eval: {mode: "server"}

  2. If mode is server, then make POST questionset hierarchy api call and if mode is client, then make

      GET questionset hierarchy api call (Existing functionality will be same).

For POST api call send below payload

{

    "request": {

        "questionset": {

            "contentID": "do_1138311682110832641171",

            "collectionID": "do_1138311782530826241173",

            "userID": "bb47f19b-15e4-4efa-9709-b061fc060f8a",

            "attemptID": "fd57cc465d6a199323e0cd76b81667e4"

        }

    }

}

   3. If mode is server, then answers will not be available in list api response and score calculation should be  

       happen at server. And for mode is client, existing functionality will be same.

   4. If mode is server, then ASSESS events should not contain score and pass fields in the event. This will 

       be sent as part of content state update api. Along with this change in the content state update payload

       we need to append serverEvaluable: true and questionSetToken, captured as part of POST hierarchy api      

       call.

questionSetToken: "eyJrZXlJZCI6ImRldmljZTAiLCJ0eXBlIjoiand0IiwiYWxnIjoiUlMyNTYifQ.eyJkYXRhIjoie1wiY29udGVudElEXCI6XCJkb18xMTM4MzExNjgyMTEwODMyNjQxMTcxXCIsXCJldmFsLW1vZGVcIjpcInNlcnZlclwiLFwiY29sbGVjdGlvbklEXCI6XCJkb18xMTM4MzExNzgyNTMwODI2MjQxMTczXCIsXCJ1c2VySURcIjpcImJiNDdmMTliLTE1ZTQtNGVmYS05NzA5LWIwNjFmYzA2MGY4YVwiLFwicXVlc3Rpb25MaXN0XCI6XCJkb18xMTM4MzExNzA0ODIwNTMxMjAxMTgxLGRvXzExMzgxOTIyNjY3MTcyNjU5MjEzMjUsZG9fMTEzODEyMjExODUxMTQxMTIwMTQ4LGRvXzExMzgxNDA2MTgxNTU0NTg1NjE2OVwiLFwiYXR0ZW1wdElEXCI6XCJmZDU3Y2M0NjVkNmExOTkzMjNlMGNkNzZiODE2NjdlNFwifSIsImlhdCI6MTY4ODM3ODYyM30.YppB3lrH_DUZU0vM7QXMeQpccPFcLa9woW68H_LU6n1vQuo5O3V-a0kLh2U7nX0auIMSsZkjJyYC8ZxI9TidjsxNa2O7z0a6yrOYz4rqdW1cxRSjMe0gyrOHDlU9rnivGvZgQl7k8MKp_-Pt8a38_ZybR9eQ1YZVO-wSS4BwfpJDWjrPmHvtCsW1_91SXQSj7xMQYOBC9JXBQu1a8uBYxVlNvdNtnzRzZLTglOdr8iNn9adNWwddVUU8sbKLR440umhPmLfP6DS-angDR4FSYo3Th-lMSzUqDYP6xQlB37Y9GY0PdpbvYKre6gbOW1O1sSgz_KsbR9c_EAXA-WznPg"

serverEvaluable: true

      5. If mode is server, score should not be shown in end page of the quml player.



Localsetup: [https://inquiry.sunbird.org/use/developer-installation/question-set-player](https://inquiry.sunbird.org/use/developer-installation/question-set-player)



*****

[[category.storage-team]] 
[[category.confluence]] 

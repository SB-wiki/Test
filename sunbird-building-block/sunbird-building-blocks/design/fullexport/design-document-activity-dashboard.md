# Design-document--Activity-dashboard

This document will help us to implement the activity dash board for groups

**Background**

As per ticket [https://project-sunbird.atlassian.net/browse/SB-24224](https://project-sunbird.atlassian.net/browse/SB-24224) we need to show the activity dashboard to the admin of the group

**Problem statement**

How to use dashlets library for showing group specific activity report.

**Solution**

**Aggregation API**

#### \[\[Scores in Group aggregate - SC-2218|Scores-in-Group-aggregate---SC-2218]]

End point

```
POST: data/v1/group/activity/agg
```

Request body

```
{
  "request": {
    "groupId": "b85d488d-637a-484d-9c2c-405d565dca55",
    "activityId": "do_2129767578773995521545",
    "activityType": "Course"
  }
}
```

Response

```
{
    "id": "api.group.activity.agg",
    "ver": "v1",
    "ts": "2021-05-17 04:08:40:926+0000",
    "params": {
        "resmsgid": null,
        "msgid": "a6a78ec6-7005-4089-b125-c32088ca4382",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "activity": {
            "id": "do_2129767578773995521545",
            "type": "Course",
            "agg": [
                {
                    "metric": "enrolmentCount",
                    "lastUpdatedOn": 1620813324281,
                    "value": 2
                }
            ]
        },
        "groupId": "b85d488d-637a-484d-9c2c-405d565dca55",
        "members": [
            {
                "agg": [
                    {
                        "metric": "completedCount",
                        "value": 2,
                        "lastUpdatedOn": 1620813324281
                    },
                    {
                        "metric": "score:do_2129493337594429441162",
                        "value": 1,
                        "lastUpdatedOn": 1620642987500
                    }
                ],
                "name": "Balakrishna M",
                "role": "member",
                "status": "active",
                "createdBy": "9d079666-ac84-41e7-bed1-343744548f90",
                "userId": "56bdaa45-0b81-4d46-81b3-a820b150ff63"
            },
            {
                "agg": [
                    {
                        "metric": "completedCount",
                        "value": 2,
                        "lastUpdatedOn": 1620813324224
                    },
                    {
                        "metric": "score:do_2129493337594429441162",
                        "value": 2,
                        "lastUpdatedOn": 1620641871592
                    }
                ],
                "name": "Balakrishna M",
                "role": "admin",
                "status": "active",
                "createdBy": "9d079666-ac84-41e7-bed1-343744548f90",
                "userId": "9d079666-ac84-41e7-bed1-343744548f90"
            }
        ]
    }
}
```

**Hierarchy API**

End point

```
GET: course/v1/hierarchy/do_2129767578773995521545?orgdetails=orgName,email&licenseDetails=name,description,url
```

Response

```
{"id":"api.course.hierarchy","ver":"1.0","ts":"2021-05-17T04:05:18.712Z","params":{"resmsgid":"17af7780-b6c5-11eb-beda-f91d28ef7717","msgid":"d99e22d6-68c4-d0a9-4be3-f57164616873","status":"successful","err":null,"errmsg":null},"responseCode":"OK","result":{"content":{"ownershipType":["createdBy"],"copyright":"KirubaOrg2.1","keywords":["2.0","EGADXN"],"c_diksha_preprod_private_batch_count":0,"subject":["Chemistry"],"channel":"01269878797503692810","downloadUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar","organisation":["Tamil Nadu"],"language":["English"],"mimeType":"application/vnd.ekstep.content-collection","variants":{"online":{"ecarUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000745_do_2129767578773995521545_1.0_online.ecar","size":8033},"spine":{"ecarUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar","size":87475}},"leafNodes":["do_2129505877663989761263","do_31277365926529433615491","do_2129493337594429441162"],"objectType":"Content","gradeLevel":["Class 2"],"appIcon":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2129753394372198401551/artifact/images_1580986881942.thumb.png","children":[{"parent":"do_2129767578773995521545","identifier":"do_2129767578779320321547","copyright":"KirubaOrg2.1","lastStatusChangedOn":"2020-03-13T05:21:29.396+0000","code":"do_2129767578779320321547","visibility":"Parent","index":1,"mimeType":"application/vnd.ekstep.content-collection","createdOn":"2020-03-13T05:21:29.396+0000","versionKey":"1584076889396","framework":"TPD","depth":1,"children":[{"ownershipType":["createdFor"],"copyright":"Tamilnadu","previewUrl":"https://ntpproductionall.blob.core.windows.net/ntp-content-production/content/assets/do_31277365926529433615491/b369u4p93as-egadxn-tirrnnn-arrivoom-ilkknnm-potu.pdf","keywords":["EGADXN","2.0"],"subject":["Tamil"],"downloadUrl":"https://ntpproductionall.blob.core.windows.net/ntp-content-production/ecar_files/do_31277365926529433615491/tirrnnn-arrivoom-ilkknnm-potu_1572421341178_do_31277365926529433615491_2.0.ecar","channel":"01235953109336064029450","questions":[],"organisation":["Tamilnadu"],"showNotification":true,"language":["English"],"variants":{"spine":{"ecarUrl":"https://ntpproductionall.blob.core.windows.net/ntp-content-production/ecar_files/do_31277365926529433615491/tirrnnn-arrivoom-ilkknnm-potu_1572421341304_do_31277365926529433615491_2.0_spine.ecar","size":12376}},"mimeType":"application/pdf","appIcon":"https://ntpproductionall.blob.core.windows.net/ntp-content-production/content/do_31277365926529433615491/artifact/b369u4p93as-egadxn-ararar-arca-arar-ararua-arra-arar2ara-ararpsarra-araa-ara-_1559284616577.thumb.png","gradeLevel":["Class 10"],"appId":"prod.diksha.app","usesContent":[],"artifactUrl":"https://ntpproductionall.blob.core.windows.net/ntp-content-production/content/assets/do_31277365926529433615491/b369u4p93as-egadxn-tirrnnn-arrivoom-ilkknnm-potu.pdf","contentEncoding":"identity","lockKey":"199bf85c-0c88-4975-bbc3-96d78e4eb8eb","contentType":"Resource","lastUpdatedBy":"032b9b66-5faa-4391-8090-ffe3c97a0811","identifier":"do_31277365926529433615491","audience":["Learner"],"visibility":"Default","author":"Tamilnadu","consumerId":"e85bcfb5-a8c2-4e65-87a2-0ebb43b45f01","mediaType":"content","itemSets":[],"osId":"org.ekstep.quiz.app","lastPublishedBy":"50eda819-a9ca-431e-874c-cdebc60cf64e","version":1,"pragma":["external"],"license":"CC BY 4.0","prevState":"Review","size":775675,"lastPublishedOn":"2019-10-30T07:42:21.173+0000","concepts":[],"name":"திறன் அறிவோம் இலக்கணம்-பொது","status":"Live","code":"84c17c44-ead4-46ce-a64b-2ab4013796a5","methods":[],"description":"B369U4P93AS","medium":["Tamil"],"streamingUrl":"https://ntpproductionall.blob.core.windows.net/ntp-content-production/content/assets/do_31277365926529433615491/b369u4p93as-egadxn-tirrnnn-arrivoom-ilkknnm-potu.pdf","posterImage":"https://ntpproductionall.blob.core.windows.net/ntp-content-production/content/do_31277365957720473615492/artifact/b369u4p93as-egadxn-ararar-arca-arar-ararua-arra-arar2ara-ararpsarra-araa-ara-_1559284616577.png","idealScreenSize":"normal","createdOn":"2019-10-09T10:00:00.000+0000","copyrightYear":2019,"contentDisposition":"inline","lastUpdatedOn":"2019-10-30T07:42:20.741+0000","SYS_INTERNAL_LAST_UPDATED_ON":"2019-12-10T01:17:08.256+0000","dialcodeRequired":"No","owner":"Tamilnadu","createdFor":["01235953109336064029450"],"creator":"TN SCERT SCERT","lastStatusChangedOn":"2019-10-30T07:42:20.733+0000","os":["All"],"libraries":[],"pkgVersion":2,"versionKey":"1572421340982","idealScreenDensity":"hdpi","framework":"tn_k-12_5","s3Key":"ecar_files/do_31277365926529433615491/tirrnnn-arrivoom-ilkknnm-potu_1572421341178_do_31277365926529433615491_2.0.ecar","me_averageRating":4,"lastSubmittedOn":"2019-10-30T07:36:03.266+0000","createdBy":"032b9b66-5faa-4391-8090-ffe3c97a0811","compatibilityLevel":4,"ownedBy":"01235953109336064029450","board":"State (Tamil Nadu)","resourceType":"Learn","index":1,"depth":2,"parent":"do_2129767578779320321547","primaryCategory":"Learning Resource"}],"name":"Unit 1","lastUpdatedOn":"2020-03-13T05:23:20.149+0000","contentType":"CourseUnit","status":"Live","compatibilityLevel":1,"lastPublishedOn":"2020-03-13T05:23:20.256+0000","pkgVersion":1,"leafNodesCount":1,"downloadUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar","variants":"{\"online\":{\"ecarUrl\":\"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000745_do_2129767578773995521545_1.0_online.ecar\",\"size\":8033.0},\"spine\":{\"ecarUrl\":\"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar\",\"size\":87475.0}}","primaryCategory":"Course Unit","audience":["Teacher"]},{"parent":"do_2129767578773995521545","identifier":"do_2129767578779402241548","copyright":"KirubaOrg2.1","lastStatusChangedOn":"2020-03-13T05:21:29.397+0000","code":"831f00dc-d8ae-4e81-88db-5e0074707f57","visibility":"Parent","index":2,"mimeType":"application/vnd.ekstep.content-collection","createdOn":"2020-03-13T05:21:29.397+0000","versionKey":"1584076889397","framework":"TPD","depth":1,"children":[{"ownershipType":["createdBy"],"previewUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/ecml/do_2129493337594429441162-latest","plugins":[{"identifier":"org.ekstep.stage","semanticVersion":"1.0"},{"identifier":"org.ekstep.text","semanticVersion":"1.2"},{"identifier":"org.ekstep.questionset","semanticVersion":"1.0"},{"identifier":"org.ekstep.summary","semanticVersion":"1.0"},{"identifier":"org.ekstep.navigation","semanticVersion":"1.0"},{"identifier":"org.ekstep.questionset.quiz","semanticVersion":"1.0"},{"identifier":"org.ekstep.iterator","semanticVersion":"1.0"},{"identifier":"org.ekstep.questionunit","semanticVersion":"1.1"},{"identifier":"org.ekstep.questionunit.mcq","semanticVersion":"1.3"}],"downloadUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129493337594429441162/kiruba-self-assess_1580729454951_do_2129493337594429441162_1.0.ecar","channel":"01275678925675724817","questions":[{"identifier":"do_2129174021075271681233","name":"Explore Question 4","objectType":"AssessmentItem","relation":"associatedTo","description":"By kiruba","status":"Live"},{"identifier":"do_2129174008785797121231","name":"Explore Question 2","objectType":"AssessmentItem","relation":"associatedTo","description":"By kiruba","status":"Live"},{"identifier":"do_2129173993575219201147","name":"Explore Question 1","objectType":"AssessmentItem","relation":"associatedTo","description":"By kiruba","status":"Live"},{"identifier":"do_2129174037204910081236","name":"Explore Question 6","objectType":"AssessmentItem","relation":"associatedTo","description":"By kiruba","status":"Live"},{"identifier":"do_2129195303901757441628","name":"Question 7","objectType":"AssessmentItem","relation":"associatedTo","description":"By kiruba","status":"Live"},{"identifier":"do_2129195314499747841629","name":"Question 8","objectType":"AssessmentItem","relation":"associatedTo","description":"By kiruba","status":"Live"},{"identifier":"do_2129174014605885441232","name":"Explore Question 3","objectType":"AssessmentItem","relation":"associatedTo","description":"By kiruba","status":"Live"},{"identifier":"do_2129174030324285441235","name":"Explore Question 5","objectType":"AssessmentItem","relation":"associatedTo","description":"By kiruba","status":"Live"}],"organisation":["preprod-sso"],"language":["English"],"variants":{"spine":{"ecarUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129493337594429441162/kiruba-self-assess_1580729455024_do_2129493337594429441162_1.0_spine.ecar","size":1162}},"mimeType":"application/vnd.ekstep.ecml-archive","editorState":"{\"plugin\":{\"noOfExtPlugins\":13,\"extPlugins\":[{\"plugin\":\"org.ekstep.contenteditorfunctions\",\"version\":\"1.2\"},{\"plugin\":\"org.ekstep.keyboardshortcuts\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.richtext\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.iterator\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.navigation\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.reviewercomments\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.questionunit.mtf\",\"version\":\"1.2\"},{\"plugin\":\"org.ekstep.questionunit.mcq\",\"version\":\"1.3\"},{\"plugin\":\"org.ekstep.keyboard\",\"version\":\"1.1\"},{\"plugin\":\"org.ekstep.questionunit.reorder\",\"version\":\"1.1\"},{\"plugin\":\"org.ekstep.questionunit.sequence\",\"version\":\"1.1\"},{\"plugin\":\"org.ekstep.questionunit.ftb\",\"version\":\"1.1\"},{\"plugin\":\"org.ekstep.summary\",\"version\":\"1.0\"}]},\"stage\":{\"noOfStages\":3,\"currentStage\":\"c37e17de-72dd-40ae-9578-ee2db02d1c55\",\"selectedPluginObject\":\"d901e2e9-67d3-4537-a326-432d5d921e87\"},\"sidebar\":{\"selectedMenu\":\"settings\"}}","appId":"preprod.diksha.portal","artifactUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2129493337594429441162/artifact/1580729454852_do_2129493337594429441162.zip","contentEncoding":"gzip","lockKey":"fc25ffac-91b7-4445-aa23-bd56f50099e7","contentType":"SelfAssess","lastUpdatedBy":"9e64cc1b-f9f0-4642-8cb3-4fb4afcb5c77","identifier":"do_2129493337594429441162","audience":["Learner"],"visibility":"Default","consumerId":"69810204-163b-4dc1-ac2a-c954eb202457","mediaType":"content","osId":"org.ekstep.quiz.app","lastPublishedBy":"Ekstep","version":2,"prevState":"Draft","license":"CC BY 4.0","size":414972,"lastPublishedOn":"2020-02-03T11:30:54.948+0000","name":"kiruba self assess","status":"Live","totalQuestions":8,"code":"org.sunbird.cQFPpi","description":"Enter description for Resource","streamingUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/ecml/do_2129493337594429441162-latest","idealScreenSize":"normal","createdOn":"2020-02-03T11:26:58.688+0000","contentDisposition":"inline","lastUpdatedOn":"2020-02-03T11:30:53.124+0000","SYS_INTERNAL_LAST_UPDATED_ON":"2020-02-03T11:30:56.499+0000","dialcodeRequired":"No","createdFor":["01275678925675724817"],"creator":"K13 Content Creator","lastStatusChangedOn":"2020-02-03T11:30:56.491+0000","os":["All"],"totalScore":8,"pkgVersion":1,"versionKey":"1580729453124","idealScreenDensity":"hdpi","s3Key":"ecar_files/do_2129493337594429441162/kiruba-self-assess_1580729454951_do_2129493337594429441162_1.0.ecar","framework":"ncert_k-12","createdBy":"9e64cc1b-f9f0-4642-8cb3-4fb4afcb5c77","compatibilityLevel":2,"resourceType":"Practice","index":1,"depth":2,"parent":"do_2129767578779402241548","primaryCategory":"Course Assessment"}],"name":"Test 1","lastUpdatedOn":"2020-03-13T05:23:20.149+0000","contentType":"CourseUnit","status":"Live","compatibilityLevel":1,"lastPublishedOn":"2020-03-13T05:23:20.256+0000","pkgVersion":1,"leafNodesCount":1,"downloadUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar","variants":"{\"online\":{\"ecarUrl\":\"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000745_do_2129767578773995521545_1.0_online.ecar\",\"size\":8033.0},\"spine\":{\"ecarUrl\":\"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar\",\"size\":87475.0}}","primaryCategory":"Course Unit","audience":["Teacher"]},{"parent":"do_2129767578773995521545","identifier":"do_2129767578779320321546","copyright":"KirubaOrg2.1","lastStatusChangedOn":"2020-03-13T05:21:29.396+0000","code":"29392b5e-cf73-4886-9f8f-2e297f7eea80","visibility":"Parent","index":3,"mimeType":"application/vnd.ekstep.content-collection","createdOn":"2020-03-13T05:21:29.396+0000","versionKey":"1584076889396","framework":"TPD","depth":1,"children":[{"ownershipType":["createdBy"],"copyright":"KirubaOrg2.1","previewUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/ecml/do_2129505877663989761263-latest","plugins":[{"identifier":"org.ekstep.stage","semanticVersion":"1.0"},{"identifier":"org.ekstep.text","semanticVersion":"1.2"},{"identifier":"org.ekstep.questionset","semanticVersion":"1.0"},{"identifier":"org.ekstep.summary","semanticVersion":"1.0"},{"identifier":"org.ekstep.navigation","semanticVersion":"1.0"},{"identifier":"org.ekstep.questionunit","semanticVersion":"1.1"},{"identifier":"org.ekstep.questionunit.mcq","semanticVersion":"1.3"},{"identifier":"org.ekstep.questionset.quiz","semanticVersion":"1.0"},{"identifier":"org.ekstep.iterator","semanticVersion":"1.0"}],"downloadUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129505877663989761263/feb-05-self-assess_1580883684747_do_2129505877663989761263_3.0.ecar","channel":"0127920475840593920","questions":[],"organisation":["KirubaOrg2.1"],"language":["English"],"variants":{"spine":{"ecarUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129505877663989761263/feb-05-self-assess_1580883684871_do_2129505877663989761263_3.0_spine.ecar","size":45946}},"mimeType":"application/vnd.ekstep.ecml-archive","editorState":"{\"plugin\":{\"noOfExtPlugins\":13,\"extPlugins\":[{\"plugin\":\"org.ekstep.contenteditorfunctions\",\"version\":\"1.2\"},{\"plugin\":\"org.ekstep.keyboardshortcuts\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.richtext\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.iterator\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.navigation\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.reviewercomments\",\"version\":\"1.0\"},{\"plugin\":\"org.ekstep.questionunit.mtf\",\"version\":\"1.2\"},{\"plugin\":\"org.ekstep.questionunit.mcq\",\"version\":\"1.3\"},{\"plugin\":\"org.ekstep.keyboard\",\"version\":\"1.1\"},{\"plugin\":\"org.ekstep.questionunit.reorder\",\"version\":\"1.1\"},{\"plugin\":\"org.ekstep.questionunit.sequence\",\"version\":\"1.1\"},{\"plugin\":\"org.ekstep.questionunit.ftb\",\"version\":\"1.1\"},{\"plugin\":\"org.ekstep.summary\",\"version\":\"1.0\"}]},\"stage\":{\"noOfStages\":3,\"currentStage\":\"ce156437-cc87-4de1-989e-ba8d2d9ed040\",\"selectedPluginObject\":\"23c1e8e6-8dc6-4b3a-badb-d800127035dd\"},\"sidebar\":{\"selectedMenu\":\"settings\"}}","appIcon":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2129505877663989761263/artifact/download-1_1580877495193.thumb.jpg","appId":"preprod.diksha.portal","usesContent":[],"artifactUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2129505877663989761263/artifact/1580883377371_do_2129505877663989761263.zip","contentEncoding":"gzip","lockKey":"add4fb4c-7d0c-4b54-be32-2bbb522a2827","contentType":"SelfAssess","lastUpdatedBy":"7e726898-0635-44cf-81ff-3b3a889c8dba","identifier":"do_2129505877663989761263","audience":["Learner"],"visibility":"Default","consumerId":"2eaff3db-cdd1-42e5-a611-bebbf906e6cf","mediaType":"content","itemSets":[],"osId":"org.ekstep.quiz.app","lastPublishedBy":"Ekstep","version":2,"prevState":"Draft","license":"CC BY 4.0","size":458458,"lastPublishedOn":"2020-02-05T06:21:24.744+0000","concepts":[],"name":"Feb-05 self assess","status":"Live","totalQuestions":6,"code":"org.sunbird.wVQ7Qc","prevStatus":"Draft","methods":[],"description":"By kiruba","streamingUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/ecml/do_2129505877663989761263-latest","posterImage":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2129505484397527041246/artifact/download-1_1580877495193.jpg","idealScreenSize":"normal","createdOn":"2020-02-05T05:58:15.708+0000","contentDisposition":"inline","lastUpdatedOn":"2020-02-05T06:21:24.401+0000","SYS_INTERNAL_LAST_UPDATED_ON":"2020-02-05T06:21:26.086+0000","dialcodeRequired":"No","createdFor":["0127920475840593920"],"creator":"Batch Mentor2","lastStatusChangedOn":"2020-02-05T06:21:24.386+0000","os":["All"],"libraries":[],"totalScore":6,"pkgVersion":3,"versionKey":"1580883684543","idealScreenDensity":"hdpi","s3Key":"ecar_files/do_2129505877663989761263/feb-05-self-assess_1580883684747_do_2129505877663989761263_3.0.ecar","framework":"NCF","createdBy":"7e726898-0635-44cf-81ff-3b3a889c8dba","compatibilityLevel":2,"resourceType":"Learn","index":1,"depth":2,"parent":"do_2129767578779320321546","primaryCategory":"Course Assessment"}],"name":"Test 2","lastUpdatedOn":"2020-03-13T05:23:20.149+0000","contentType":"CourseUnit","status":"Live","compatibilityLevel":1,"lastPublishedOn":"2020-03-13T05:23:20.256+0000","pkgVersion":1,"leafNodesCount":1,"downloadUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar","variants":"{\"online\":{\"ecarUrl\":\"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000745_do_2129767578773995521545_1.0_online.ecar\",\"size\":8033.0},\"spine\":{\"ecarUrl\":\"https://preprodall.blob.core.windows.net/ntp-content-preprod/ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar\",\"size\":87475.0}}","primaryCategory":"Course Unit","audience":["Teacher"]}],"collections":[],"primaryCategory":"Course","appId":"preprod.diksha.portal","contentEncoding":"gzip","lockKey":"9f7fc44f-4bfd-497d-90b9-02a3791c821d","totalCompressedSize":1649105,"mimeTypesCount":"{\"application/pdf\":1,\"application/vnd.ekstep.content-collection\":3,\"application/vnd.ekstep.ecml-archive\":2}","contentType":"Course","identifier":"do_2129767578773995521545","audience":["Teacher"],"toc_url":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2129767578773995521545/artifact/do_2129767578773995521545_toc.json","visibility":"Default","contentTypesCount":"{\"CourseUnit\":3,\"Resource\":1,\"SelfAssess\":2}","author":"kiruba","consumerId":"2eaff3db-cdd1-42e5-a611-bebbf906e6cf","childNodes":["do_2129767578779320321546","do_2129767578779320321547","do_2129767578779402241548","do_2129505877663989761263","do_31277365926529433615491","do_2129493337594429441162"],"mediaType":"content","osId":"org.ekstep.quiz.app","lastPublishedBy":"08631a74-4b94-4cf7-a818-831135248a4a","version":2,"license":"CC BY 4.0","prevState":"Review","size":87475,"lastPublishedOn":"2020-03-13T05:23:20.256+0000","name":"vk-2.8CourseWithAssessment5","topic":["Teaching and Classroom Management"],"status":"Live","code":"org.sunbird.qdQpaJ.copy.copy.copy.copy","prevStatus":"Processing","origin":"do_2129760324172267521517","description":"By kiruba","medium":["Telugu"],"posterImage":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2129514445339033601158/artifact/images_1580986881942.png","idealScreenSize":"normal","createdOn":"2020-03-13T05:21:29.332+0000","reservedDialcodes":{"P7T4D6":0},"copyrightYear":2020,"contentDisposition":"inline","licenseterms":"By creating any type of content (resources, books, courses etc.) on DIKSHA, you consent to publish it under the Creative Commons License Framework. Please choose the applicable creative commons license you wish to apply to your content.","lastUpdatedOn":"2020-03-13T05:23:20.149+0000","originData":{"license":"CC BY 4.0","author":"kiruba","name":"vk-2.8CourseWithAssessment4","organisation":["Tamil Nadu"]},"SYS_INTERNAL_LAST_UPDATED_ON":"2020-03-13T05:23:20.823+0000","dialcodeRequired":"No","lastStatusChangedOn":"2020-03-13T05:23:20.815+0000","createdFor":["01269878797503692810"],"creator":"Content_creator_TN","os":["All"],"c_diksha_preprod_open_batch_count":1,"pkgVersion":1,"versionKey":"1584077000149","idealScreenDensity":"hdpi","framework":"TPD","depth":0,"s3Key":"ecar_files/do_2129767578773995521545/vk-2.8coursewithassessment5_1584077000623_do_2129767578773995521545_1.0_spine.ecar","lastSubmittedOn":"2020-03-13T05:22:35.815+0000","createdBy":"4cd4c690-eab6-4938-855a-447c7b1b8ea9","compatibilityLevel":4,"leafNodesCount":3,"usedByContent":[],"resourceType":"Course"}}}
```

1. Get page Config from form API

```
```

1. Get the assessment score from data aggregation API
2. Get course/assessment details using hierarchy API
3. Expose a method in CSL which uses the hierarchy response and replace the do\_id of assessment with name

```
activity-service.ts
/** 
 * @param {object} hierarchyData - hierarchy api response
 * @param {object} aggregateData - aggregate api response
 **/
getDasletsData(hierarchyData, aggregateData) {
    var assessments = getAssessments(hierarchyData);
    return getFlatJson(aggregateData, assessments);
}
/** 
 * @param {object} aggregateData - aggregate API response
 * @param {object} assessments - assessments from hierarchy API
 **/
getFlatJson(aggregateData, assessments) {
    // metric: { score: do_123, value: 5}
    var dashletsColumns = []
    var dashletsData = [];
    forEach() {
        //if dashletsColumns is not having the object.key then append
        dashletsData.push({Name: Bala, progress: 60, Assessment1: 5}),
    }
    var dashletsConfig = {
        data: dashletsData
        columns: dashletsColumns
    }
    retun dashletsData;
}
/** 
 * @param {object} hierarchyData - hierarchy api response
 **// this method can be written in util service
getAssessments(hierarchyData) {
    //returns only assessment in the course hierarchyData
    return {
        do_123: Assessment1,
        do_567: Assessment2,
    }
}
```

1. use the dash lets library to populate the table as per the documentation [https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/2312110137/Dashlets+Design+Doc?focusedCommentId=2394980376#comment-2394980376](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/2312110137/Dashlets+Design+Doc?focusedCommentId=2394980376#comment-2394980376)

```
<sb-dashlet [type]="string" [config]="config" [data]="data" , [id]="string | uuid" [height]="string"
    [width]="string" (...anyOtherEvent)="eventListener($event)">
</sb-dashlet>
```

| **Name** | **Progress** | **Assessment1** | **Assessment2** |
| -------- | ------------ | --------------- | --------------- |
| Bala     | 60           | 9               | NA              |
| Vinu     | 97           | 5               | 6               |

**Solution 2**

Create a NPM package which can be used any where

![](../../../../Design/FullExport/images/storage/dashlets.png)

***

\[\[category.storage-team]] \[\[category.confluence]]

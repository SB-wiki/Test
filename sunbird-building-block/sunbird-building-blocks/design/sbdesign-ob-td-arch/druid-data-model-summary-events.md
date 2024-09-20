# Data Model:

|     | Dimension in Druid                  | Field in Summary event                | Description                                                            | Data Type            |
| --- | ----------------------------------- | ------------------------------------- | ---------------------------------------------------------------------- | -------------------- |
| 1   | ets                                 | ets                                   | Event timestamp                                                        | Long                 |
| 2   | eid                                 | eid                                   | Event Id                                                               | String               |
| 3   | ver                                 | ver                                   | Version                                                                | String               |
| 4   | syncts                              | syncts                                | Sync timestamp                                                         | Long                 |
| 5   | uid                                 | uid                                   | User Id                                                                | String               |
| 6   | context\_date\_range\_from          | context.date\_range.from              | Start Date for the summary                                             | Long (Epoch)         |
| 7   | context\_date\_range\_to            | context.date\_range.to                | End Date for the summary                                               | Long (Epoch)         |
| 8   | context\_rollup\_l1                 | context.rollup.l1                     | Context level1 rollup                                                  | String               |
| 9   | context\_rollup\_l2                 | context.rollup.l2                     | Context level2 rollup                                                  | String               |
| 10  | context\_rollup\_l3                 | context.rollup.l3                     | Context level3 rollup                                                  | String               |
| 11  | context\_rollup\_l4                 | context.rollup.l4                     | Context level4 rollup                                                  | String               |
| 12  | dimension\_channel                  | dimensions.channel                    | Channel Id as dimension from raw telemetry                             | String               |
| 13  | dimensions\_did                     | dimensions.did                        | Device Id as dimension from raw telemetry                              | String               |
| 14  | dimensions\_pdata\_id               | dimensions.pdata.id                   | Producer Id as dimension from raw telemetry                            | String               |
| 15  | dimensions\_pdata\_pid              | dimensions.pdata.pid                  | Producer Process Id as dimension from raw telemetry                    | String               |
| 16  | dimensions\_pdata\_ver              | dimensions.pdata.ver                  | Producer Process Ver as dimension from raw telemetry                   | String               |
| 17  | dimensions\_sid                     | dimensions.sid                        | Session Id as dimension                                                | String               |
| 18  | dimensions\_type                    | dimensions.type                       | Type of summary                                                        | String               |
| 19  | dimensions\_mode                    | dimensions.mode                       | Mode of action in the session                                          | String               |
| 20  | object\_id                          | object.id                             | Content Id                                                             | String               |
| 21  | object\_type                        | object.type                           | Content Type                                                           | String               |
| 22  | object\_version                     | object.ver                            | Content version                                                        | String               |
| 23  | object\_rollup\_l1                  | object.rollup.l1                      | Object level1 rollup                                                   | String               |
| 24  | object\_rollup\_l2                  | object.rollup.l2                      | Object level2 rollup                                                   | String               |
| 25  | object\_rollup\_l3                  | object.rollup.l3                      | Object level3 rollup                                                   | String               |
| 26  | object\_rollup\_l4                  | object.rollup.l4                      | Object level4 rollup                                                   | String               |
| 27  | tags                                | tags                                  | Tags attached to a summary event                                       | Array\[\[\[String    |
| 28  | edata\_time\_spent                  | edata.eks.time\_spent                 | Time spent in the session excluding idle time                          | Double               |
| 29  | edata\_time\_difference             | edata.eks.time\_diff                  | Total time in a session including idle time                            | Double               |
| 30  | edata\_interaction\_count           | edata.eks.interact\_events\_count     | Total count of interact events in a session                            | Long                 |
| 31  | edata\_env\_summary\_env            | edata.eks.env\_summary.env            | High level env within the app(content, domain, resources, community)   | Array\[String]       |
| 32  | edata\_env\_summary\_count          | edata.eks.env\_summary.count          | Count of times the environment has been visited                        | Array\[Integer]      |
| 33  | edata\_env\_summary\_time\_spent    | edata.eks.env\_summary.time\_spent    | Time spent per env                                                     | Array\[Double]       |
| 34  | edata\_page\_summary\_id            | edata.eks.page\_summary.id            | Page id                                                                | Array\[String]       |
| 35  | edata\_page\_summary\_type          | edata.eks.page\_summary.type          | Type of page e.g. view/edit                                            | Array\[String]       |
| 36  | edata\_page\_summary\_env           | edata.eks.page\_summary.env           | Env of page                                                            | Array\[String]       |
| 37  | edata\_page\_summary\_visit\_count  | edata.eks.page\_summary.visit\_count  | Number of times each page was visited                                  | Array\[Integer]      |
| 38  | edata\_page\_summary\_time\_spent   | edata.eks.page\_summary.time\_spent   | Time taken per page                                                    | Array\[Double]       |
| 39  | edata\_item\_responses\_item\_id    | edata.eks.item\_responses.itemId      | Question Id passed in the ASSESS event                                 | Array\[String]       |
| 40  | edata\_item\_responses\_time\_spent | edata.eks.item\_responses.timeSpent   | Time spent in seconds from ASSESS event                                | Array\[Double]       |
| 41  | edata\_item\_responses\_pass        | edata.eks.item\_responses.pass        | Pass response for a question from ASSESS event                         | Array\[String]       |
| 42  | edata\_item\_responses\_score       | edata.eks.item\_responses.score       | Score from ASSESS event                                                | Array\[\[\[Integer   |
| 43  | edata\_item\_responses\_max\_score  | edata.eks.item\_responses.maxScore    | Max Score from ASSESS event                                            | Array\[\[\[Integer   |
| 44  | edata\_item\_responses\_timestamp   | edata.eks.item\_responses.time\_stamp | Timestamp for each response from ASSESS event                          | Array\[Long (Epoch)] |
| 45  | device\_loc\_state                  | devicedata.state                      | State location information for the device                              | String               |
| 46  | device\_loc\_state\_code            | devicedata.statecode                  | State ISO code information for the device                              | String               |
| 47  | device\_loc\_iso\_state\_code       | devicedata.iso3166statecode           | State ISO-3166 code information for the device                         | String               |
| 48  | device\_loc\_city                   | devicedata.city                       | City location information for the device                               | String               |
| 49  | device\_loc\_country\_code          | devicedata.countrycode                | Country ISO code information for the device                            | String               |
| 50  | device\_loc\_country                | devicedata.country                    | Country location information for the device                            | String               |
| 51  | device\_loc\_state\_custom\_code    | devicedata.statecustomcode            | State custom code information for the device                           | String               |
| 52  | device\_loc\_state\_custom\_name    | devicedata.statecustomname            | State custom name information for the device                           | String               |
| 53  | device\_loc\_district               | devicedata.districtcustom             | District custom information for the device                             | String               |
| 54  | device\_os                          | devicedata.devicespec.os              | Device OS name                                                         | String               |
| 55  | device\_make                        | devicedata.devicespec.make            | Device make and model                                                  | String               |
| 56  | device\_id                          | devicedata.devicespec.id              | Physical device id if available from OS                                | String               |
| 57  | device\_mem                         | devicedata.devicespec.mem             | Total memory in mb                                                     | Integer              |
| 58  | device\_idisk                       | devicedata.devicespec.idisk           | Total interanl disk                                                    | Integer              |
| 59  | device\_edisk                       | devicedata.devicespec.edisk           | Total external disk                                                    | Integer              |
| 60  | device\_scrn                        | devicedata.devicespec.scrn            | Screen size in inches                                                  | Integer              |
| 61  | device\_camera                      | devicedata.devicespec.camera          | Primary & secondary camera spec                                        | String               |
| 62  | device\_cpu                         | devicedata.devicespec.cpu             | Processor name                                                         | String               |
| 63  | device\_sims                        | devicedata.devicespec.sims            | Number of sim cards                                                    | Integer              |
| 64  | device\_uaspec\_agent               | devicedata.uaspec.agent               | User agent of the browser                                              | String               |
| 65  | device\_uaspec\_ver                 | devicedata.uaspec.ver                 | User agent version of the browser                                      | String               |
| 66  | device\_uaspec\_system              | devicedata.uaspec.system              | User agent system identification of the browser                        | String               |
| 67  | device\_uaspec\_platform            | devicedata.uaspec.platform            | User agent client platform of the browser                              | String               |
| 68  | device\_uaspec\_raw                 | devicedata.uaspec.raw                 | Raw user agent of the browser                                          | String               |
| 69  | device\_first\_access               | devicedata.firstaccess                | First access of the device                                             | Long (Epoch)         |
| 70  | content\_name                       | contentdata.name                      | Name of the content                                                    | String               |
| 71  | content\_object\_type               | contentdata.objecttype                | Type of the content                                                    | String               |
| 72  | content\_type                       | contentdata.contenttype               | Type of the resource                                                   | String               |
| 73  | content\_media\_type                | contentdata.mediatype                 | Type of the media of the resource                                      | String               |
| 74  | content\_language                   | contentdata.language                  | List of languages in the content                                       | Array\[String]       |
| 75  | content\_medium                     | contentdata.medium                    | Language medium of the board                                           | Array\[String]       |
| 76  | content\_gradelevel                 | contentdata.gradelevel                | List of grade levels in the content                                    | Array\[String]       |
| 77  | content\_subjects                   | contentdata.subject                   | List of subjects in the content                                        | Array\[String]       |
| 78  | content\_mimetype                   | contentdata.mimetype                  | Mimetype of the resource in the content                                | String               |
| 79  | content\_created\_by                | contentdata.createdby                 | Content created by                                                     | String               |
| 80  | content\_created\_for               | contentdata.createdfor                | List of orgs for whom the content is created                           | Array\[String]       |
| 81  | content\_framework                  | contentdata.framework                 |                                                                        | String               |
| 82  | content\_board                      | contentdata.board                     | Board of affiliation                                                   | String               |
| 83  | content\_status                     | contentdata.status                    | Status of the content - Draft, Published etc.                          | String               |
| 84  | content\_version                    | contentdata.pkgversion                | Version of the content                                                 | Double               |
| 85  | content\_last\_submitted\_on        | contentdata.lastsubmittedon           | Last submitted date of the content                                     | Long (Epoch)         |
| 86  | content\_last\_published\_on        | contentdata.lastpublishedon           | Last submitted date of the content                                     | Long (Epoch)         |
| 87  | content\_last\_updated\_on          | contentdata.lastupdatedon             | Last updated date of the content                                       | Long (Epoch)         |
| 88  | user\_grade\_list                   | userdata.gradelist                    | List of grades taught                                                  | Array\[String]       |
| 89  | user\_language\_list                | userdata.languagelist                 | List of languages known                                                | Array\[String]       |
| 90  | user\_subject\_list                 | userdata.subjectlist                  | List of subjects taught                                                | Array\[String]       |
| 91  | user\_type                          | userdata.type                         | Type of user                                                           | String               |
| 92  | user\_loc\_state                    | userdata.state                        | State info of the user                                                 | String               |
| 93  | user\_loc\_district                 | userdata.district                     | District info of the user                                              | String               |
| 94  | user\_loc\_block                    | userdata.block                        | Block info of the user                                                 | String               |
| 95  | user\_roles                         | userdata.roles                        | List of user roles                                                     | Array\[String]       |
| 96  | user\_signin\_type                  | userdata.usersignintype               | User sign-in type info                                                 | String               |
| 97  | user\_login\_type                   | userdata.userlogintype                | User login type info                                                   | String               |
| 98  | collection\_name                    | collectiondata.name                   | Name of the collection (Denormalised for  **object.rollup.l1**  field) | String               |
| 99  | collection\_object\_type            | collectiondata.objecttype             | Type of the collection                                                 | String               |
| 100 | collection\_type                    | collectiondata.contenttype            | Type of the resource                                                   | String               |
| 101 | collection\_media\_type             | collectiondata.mediatype              | Type of the media of resource                                          | String               |
| 102 | collection\_language                | collectiondata.language               | List of languages in the collection                                    | Array\[String]       |
| 103 | collection\_medium                  | collectiondata.medium                 | Language medium of the board                                           | Array\[String]       |
| 104 | collection\_gradelevel              | collectiondata.gradelevel             | List of grade levels in the collection                                 | Array\[String]       |
| 105 | collection\_subjects                | collectiondata.subjects               | List of subjects in the collection                                     | Array\[String]       |
| 106 | collection\_mimetype                | collectiondata.mimetype               | Mimetype of the resource in the collection                             | String               |
| 107 | collection\_created\_by             | collectiondata.createdby              | Resourse created By                                                    | String               |
| 108 | collection\_created\_for            | collectiondata.createdfor             | List of orgs for whom the resource is created                          | Array\[String]       |
| 109 | collection\_framework               | collectiondata.framework              |                                                                        | String               |
| 110 | collection\_board                   | collectiondata.board                  | Board of affiliation                                                   | String               |
| 111 | collection\_status                  | collectiondata.status                 | Status of the collection - Draft, Published etc.                       | String               |
| 112 | collection\_version                 | collectiondata.pkgversion             | Version of the collection                                              | Double               |
| 113 | collection\_last\_published\_on     | collectiondata.lastpublishedon        | Last published date of the collection                                  | Long(Epoch)          |
| 114 | collection\_last\_updated\_on       | collectiondata.lastupdatedon          | Last updated date of the collection                                    | Long(Epoch)          |
| 115 | collection\_last\_submitted\_on     | collectiondata.lastsubmittedon        | Last submitted date of the collection                                  | Long(Epoch)          |

&#x20;    &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

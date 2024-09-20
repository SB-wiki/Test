# Data Model:

|     | Dimension in Druid               | Field in Telemetry               | Description                                                          | Data Type       |
| --- | -------------------------------- | -------------------------------- | -------------------------------------------------------------------- | --------------- |
| 1   | ets                              | ets                              | Event timestamp                                                      | Long            |
| 2   | eid                              | eid                              | Event Id                                                             | String          |
| 3   | syncts                           | syncts                           | Sync Timestamp                                                       | Long            |
| 4   | @timstamp                        | @timstamp                        | Sync Timestamp in String                                             | String          |
| 5   | actor\_id                        | actor.id                         | Actor Id of the event                                                | String          |
| 6   | actor\_type                      | actor.type                       | Type of the actor                                                    | String          |
| 7   | context\_channel                 | context.channel                  | Channel Id                                                           | String          |
| 8   | context\_pdata\_id               | context.pdata.id                 | Producer Id                                                          | String          |
| 9   | context\_pdata\_pid              | context.pdata.pid                | Producer Process Id                                                  | String          |
| 10  | context\_pdata\_ver              | context.pdata.ver                | Producer version number                                              | String          |
| 11  | context\_env                     | context.env                      | Context Environment                                                  | String          |
| 12  | context\_sid                     | context.sid                      | Session Id                                                           | String          |
| 13  | context\_did                     | context.did                      | Device Id                                                            | String          |
| 14  | context\_cdata\_type             | context.cdata.type               | Correlation Data Type                                                | Array\[String]  |
| 15  | context\_cdata\_id               | context.cdata.id                 | Correlation Data Id                                                  | Array\[String]  |
| 16  | context\_rollup\_l1              | context.rollup.l1                | Context level 1 rollup                                               | String          |
| 17  | context\_rollup\_l2              | context.rollup.l2                | Context level 2 rollup                                               | String          |
| 18  | context\_rollup\_l3              | context.rollup.l3                | Context level 3 rollup                                               | String          |
| 19  | context\_rollup\_l4              | context.rollup.l4                | Context level 4 rollup                                               | String          |
| 20  | object\_id                       | object.id                        | Content Id                                                           | String          |
| 21  | object\_type                     | object.type                      | Content Type                                                         | String          |
| 22  | object\_version                  | object.ver                       | Content Version                                                      | String          |
| 23  | object\_rollup\_l1               | object.rollup.l1                 | Content level 1 rollup                                               | String          |
| 24  | object\_rollup\_l2               | object.rollup.l2                 | Content level 2 rollup                                               | String          |
| 25  | object\_rollup\_l3               | object.rollup.l3                 | Content level 3 rollup                                               | String          |
| 26  | object\_rollup\_l4               | object.rollup.l4                 | Content level 4 rollup                                               | String          |
| 27  | tags                             | tags                             | Tags                                                                 | Array\[String]  |
| 28  | edata\_type                      | edata.type                       | Event type                                                           | String          |
| 29  | edata\_subtype                   | edata.subtype                    | Event subtype                                                        | String          |
| 30  | edata\_mode                      | edata.mode                       | START event Mode of start                                            | String          |
| 31  | edata\_pageid                    | edata.pageid                     | Unique pageid                                                        | String          |
| 32  | edata\_uri                       | edata.uri                        | IMPRESSION event Relative URI of the content                         | String          |
| 33  | edata\_id                        | edata.id                         | Event data Id                                                        | String          |
| 34  | edata\_duration                  | edata.duration                   | Duration of the event                                                | Double          |
| 35  | edata\_index                     | edata.index                      | ASSESS event Index of the question within a content                  | Integer         |
| 36  | edata\_pass                      | edata.pass                       | ASSESS event Field to identify pass or fail for assessments          | String          |
| 37  | edata\_score                     | edata.score                      | ASSESS event Assessment score                                        | Double          |
| 38  | edata\_resvalues                 | edata.resvalues                  | ASSESS event Assessment results                                      | Array\[Object]  |
| 39  | edata\_item\_id                  | edata.item.id                    | ASSESS event Assessment item id                                      | String          |
| 40  | edata\_item\_title               | edata.item.title                 | ASSESS event Assessment item title                                   | String          |
| 41  | edata\_item\_maxscore            | edata.item.maxscore              | ASSESS event Assessment item max score                               | Double          |
| 42  | edata\_target\_id                | edata.target.id                  | ASSESS event Assessment item target id                               | String          |
| 43  | edata\_target\_type              | edata.target.type                | ASSESS event Assessment item target type                             | String          |
| 44  | edata\_rating                    | edata.rating                     | FEEDBACK event Ratings                                               | Integer         |
| 45  | edata\_comments                  | edata.comments                   | FEEDBACK event Comments                                              | String          |
| 46  | edata\_dir                       | edata.dir                        | SHARE event direction                                                | String          |
| 47  | edata\_items\_id                 | edata.items.id                   | SHARE event shared item ids                                          | Array\[String]  |
| 48  | edata\_items\_type               | edata.items.type                 | SHARE item types                                                     | Array\[String]  |
| 49  | edata\_items\_origin\_id         | edata.items.origin.id            | SHARE event source id                                                | Array\[String]  |
| 50  | edata\_items\_origin\_type       | edata.items.origin.type          | SHARE event source type                                              | Array\[String]  |
| 51  | edata\_items\_to\_id             | edata.items.to.id                | SHARE event destination id                                           | Array\[String]  |
| 52  | edata\_items\_to\_type           | edata.items.to.type              | SHARE event destination type                                         | Array\[String]  |
| 53  | edata\_plugin\_id                | edata.plugin.id                  | INTERACT event plugin id on which the interaction has happened       | String          |
| 54  | edata\_plugin\_ver               | edata.plugin.ver                 | INTERACT  event plugin version                                       | String          |
| 55  | edata\_plugin\_category          | edata.plugin.category            | INTERACT  event plugin category                                      | String          |
| 56  | edata\_props                     | edata.props                      | AUDIT event updated properties                                       | Array\[String]  |
| 57  | edata\_state                     | edata.state                      | AUDIT event current state                                            | String          |
| 58  | edata\_prevstate                 | edata.prevstate                  | AUDIT event previous state                                           | String          |
| 59  | edata\_size                      | edata.size                       | SEARCH event result size                                             | Integer         |
| 60  | edata\_filters\_dialcodes        | edata.filters.dialcodes          | SEARCH event List of dialcodes                                       | Array\[String]  |
| 61  | edata\_topn\_identifier          | edata.topn.identifier            | SEARCH event topn results                                            | Array\[String]  |
| 62  | edata\_visits\_objid             | edata.visits.objid               | IMPRESSION event unique id for object visited                        | Array\[String]  |
| 63  | edata\_visits\_objtype           | edata.visits.objtype             | IMPRESSION event type of object visited                              | Array\[String]  |
| 64  | edata\_visits\_objver            | edata.visits.objver              | IMPRESSION event version of object visited                           | Array\[String]  |
| 65  | edata\_visits\_index             | edata.visits.index               | IMPRESSION event index of object within list                         | Array\[Integer] |
| 66  | device\_loc\_state               | devicedata.state                 | State location information for the device                            | String          |
| 67  | device\_loc\_state\_code         | devicedata.statecode             | State ISO code information for the device                            | String          |
| 68  | device\_loc\_iso\_state\_code    | devicedata.iso3166statecode      | State ISO-3166 code information for the device                       | String          |
| 69  | device\_loc\_city                | devicedata.city                  | City location information for the device                             | String          |
| 70  | device\_loc\_country\_code       | devicedata.countrycode           | Country ISO code information for the device                          | String          |
| 71  | device\_loc\_country             | devicedata.country               | Country location information for the device                          | String          |
| 72  | device\_loc\_state\_custom\_code | devicedata.statecustomcode       | State custom code information for the device                         | String          |
| 73  | device\_loc\_state\_custom\_name | devicedata.statecustomname       | State custom name information for the device                         | String          |
| 74  | device\_loc\_district            | devicedata.districtcustom        | District custom information for the device                           | String          |
| 75  | user\_declared\_state            | devicedata.userdeclared.state    | State declared by the user                                           | String          |
| 76  | user\_declared\_district         | devicedata.userdeclared.district | District declared by the user                                        | String          |
| 77  | device\_os                       | devicedata.devicespec.os         | Device OS name                                                       | String          |
| 78  | device\_make                     | devicedata.devicespec.make       | Device make and model                                                | String          |
| 79  | device\_id                       | devicedata.devicespec.id         | Physical device id if available from OS                              | String          |
| 80  | device\_mem                      | devicedata.devicespec.mem        | Total memory in mb                                                   | Integer         |
| 81  | device\_idisk                    | devicedata.devicespec.idisk      | Total interanl disk                                                  | Integer         |
| 82  | device\_edisk                    | devicedata.devicespec.edisk      | Total external disk                                                  | Integer         |
| 83  | device\_scrn                     | devicedata.devicespec.scrn       | Screen size in inches                                                | Integer         |
| 84  | device\_camera                   | devicedata.devicespec.camera     | Primary & secondary camera spec                                      | String          |
| 85  | device\_cpu                      | devicedata.devicespec.cpu        | Processor name                                                       | String          |
| 86  | device\_sims                     | devicedata.devicespec.sims       | Number of sim cards                                                  | Integer         |
| 87  | device\_uaspec\_agent            | devicedata.uaspec.agent          | User agent of the browser                                            | String          |
| 88  | device\_uaspec\_ver              | devicedata.uaspec.ver            | User agent version of the browser                                    | String          |
| 89  | device\_uaspec\_system           | devicedata.uaspec.system         | User agent system identification of the browser                      | String          |
| 90  | device\_uaspec\_platform         | devicedata.uaspec.platform       | User agent client platform of the browser                            | String          |
| 91  | device\_uaspec\_raw              | devicedata.uaspec.raw            | Raw user agent of the browser                                        | String          |
| 92  | device\_first\_access            | devicedata.firstaccess           | First access of the device                                           | Long (Epoch)    |
| 93  | content\_name                    | contentdata.name                 | Name of the content                                                  | String          |
| 94  | content\_object\_type            | contentdata.objecttype           | Type of the content                                                  | String          |
| 95  | content\_type                    | contentdata.contenttype          | Type of the resource                                                 | String          |
| 96  | content\_media\_type             | contentdata.mediatype            | Type of the media of the resource                                    | String          |
| 97  | content\_language                | contentdata.language             | List of languages in the content                                     | Array\[String]  |
| 98  | content\_medium                  | contentdata.medium               | Language medium of the board                                         | Array\[String]  |
| 99  | content\_gradelevel              | contentdata.gradelevel           | List of grade levels in the content                                  | Array\[String]  |
| 100 | content\_subjects                | contentdata.subject              | List of subjects in the content                                      | Array\[String]  |
| 101 | content\_mimetype                | contentdata.mimetype             | Mimetype of the resource in the content                              | String          |
| 102 | content\_created\_by             | contentdata.createdby            | Content created by                                                   | String          |
| 103 | content\_created\_for            | contentdata.createdfor           | List of orgs for whom the content is created                         | Array\[String]  |
| 104 | content\_framework               | contentdata.framework            |                                                                      | String          |
| 105 | content\_board                   | contentdata.board                | Board of affiliation                                                 | String          |
| 106 | content\_status                  | contentdata.status               | Status of the content - Draft, Published etc.                        | String          |
| 107 | content\_version                 | contentdata.pkgversion           | Version of the content                                               | Double          |
| 108 | content\_last\_submitted\_on     | contentdata.lastsubmittedon      | Last submitted date of the content                                   | Long (Epoch)    |
| 109 | content\_last\_published\_on     | contentdata.lastpublishedon      | Last published date of the content                                   | Long (Epoch)    |
| 110 | content\_last\_updated\_on       | contentdata.lastupdatedon        | Last updated date of the content                                     | Long (Epoch)    |
| 111 | user\_grade\_list                | userdata.gradelist               | List of grades taught                                                | Array\[String]  |
| 112 | user\_language\_list             | userdata.languagelist            | List of languages known                                              | Array\[String]  |
| 113 | user\_subject\_list              | userdata.subjectlist             | List of subjects taught                                              | Array\[String]  |
| 114 | user\_type                       | userdata.type                    | Type of user                                                         | String          |
| 115 | user\_loc\_state                 | userdata.state                   | State info of the user                                               | String          |
| 116 | user\_loc\_district              | userdata.district                | District info of the user                                            | String          |
| 117 | user\_loc\_block                 | userdata.block                   | Block info of the user                                               | String          |
| 118 | user\_roles                      | userdata.roles                   | List of user roles                                                   | Array\[String]  |
| 119 | user\_signin\_type               | userdata.usersignintype          | User sign-in type info                                               | String          |
| 120 | user\_login\_type                | userdata.userlogintype           | User login type info                                                 | String          |
| 121 | dialcode\_channel                | dialcodedata.channel             | Channel for which dialcode is generated                              | String          |
| 122 | dialcode\_batchcode              | dialcodedata.batchcode           | Batch for which dialcode belongs to                                  | String          |
| 123 | dialcode\_publisher              | dialcodedata.publisher           | Publisher of the dialcode                                            | String          |
| 124 | dialcode\_generated\_on          | dialcodedata.generatedon         | Dialcode generated on                                                | Long (Epoch)    |
| 125 | dialcode\_published\_on          | dialcodedata.publishedon         | Dialcode published on                                                | Long (Epoch)    |
| 126 | dialcode\_status                 | dialcodedata.status              | Status of the dialcode                                               | String          |
| 127 | dialcode\_object\_type           | dialcodedata.objecttype          | Object type - DialCode as a value                                    | String          |
| 128 | collection\_name                 | collectiondata.name              | Name of the collection (Denormalised for **object.rollup.l1** field) | String          |
| 129 | collection\_object\_type         | collectiondata.objecttype        | Type of the collection                                               | String          |
| 130 | collection\_type                 | collectiondata.contenttype       | Type of the resource                                                 | String          |
| 131 | collection\_media\_type          | collectiondata.mediatype         | Type of the media of resource                                        | String          |
| 132 | collection\_language             | collectiondata.language          | List of languages in the collection                                  | Array\[String]  |
| 133 | collection\_medium               | collectiondata.medium            | Language medium of the board                                         | Array\[String]  |
| 134 | collection\_gradelevel           | collectiondata.gradelevel        | List of grade levels in the collection                               | Array\[String]  |
| 135 | collection\_subjects             | collectiondata.subjects          | List of subjects in the collection                                   | Array\[String]  |
| 136 | collection\_mimetype             | collectiondata.mimetype          | Mimetype of the resource in the collection                           | String          |
| 137 | collection\_created\_by          | collectiondata.createdby         | Resourse created By                                                  | String          |
| 138 | collection\_created\_for         | collectiondata.createdfor        | List of orgs for whom the resource is created                        | Array\[String]  |
| 139 | collection\_framework            | collectiondata.framework         |                                                                      | String          |
| 140 | collection\_board                | collectiondata.board             | Board of affiliation                                                 | String          |
| 141 | collection\_status               | collectiondata.status            | Status of the collection - Draft, Published etc.                     | String          |
| 142 | collection\_version              | collectiondata.pkgversion        | Version of the collection                                            | Double          |
| 143 | collection\_last\_published\_on  | collectiondata.lastpublishedon   | Last published date of the collection                                | Long(Epoch)     |
| 144 | collection\_last\_updated\_on    | collectiondata.lastupdatedon     | Last updated date of the collection                                  | Long(Epoch)     |
| 145 | collection\_last\_submitted\_on  | collectiondata.lastsubmittedon   | Last submitted date of the collection                                | Long(Epoch)     |
| 146 | derived\_loc\_state              | derivedlocationdata.state        | Derived location state of the user                                   | String          |
| 147 | derived\_loc\_district           | derivedlocationdata.district     | Derived location district of the user                                | String          |
| 148 | derived\_loc\_from               | derivedlocationdata.from         | Derived location                                                     | String          |
| 149 | user\_declared\_state            | userdeclared.state               | User Declared State                                                  | String          |
| 150 | user\_declared\_district         | userdeclared.district            | User Declared District                                               | String          |

***

\[\[category.storage-team]] \[\[category.confluence]]

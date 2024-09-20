# Reports@Scale

### Introduction

This wiki details the architecture of enabling reporting framework to operate at scale. It discusses the high level design problems to be solved and introduces the proposed architecture for the same.&#x20;

#### Key Design Problems

TBA

### Reporting Architecture

![](../../../../Design/sbdesign-ob-td-arch/images/storage/reports.png)

### Druid Architecture

![](../../../../Design/sbdesign-ob-td-arch/images/storage/druid-architecture.png)

### Druid Data Model

#### Raw Telemetry

|     | Dimension in Druid            | Field in Telemetry          | Description                                                 | Data Type       |
| --- | ----------------------------- | --------------------------- | ----------------------------------------------------------- | --------------- |
| 1   | ets                           | ets                         | Event timestamp                                             | Long            |
| 2   | eid                           | eid                         | Event Id                                                    | String          |
| 3   | syncts                        | syncts                      | Sync Timestamp                                              | Long            |
| 4   | @timstamp                     | @timstamp                   | Sync Timestamp in String                                    | String          |
| 5   | actor\_id                     | actor.id                    | Actor Id of the event                                       | String          |
| 6   | actor\_type                   | actor.type                  | Type of the actor                                           | String          |
| 7   | context\_channel              | context.channel             | Channel Id                                                  | String          |
| 8   | context\_pdata\_id            | context.pdata.id            | Producer Id                                                 | String          |
| 9   | context\_pdata\_pid           | context.pdata.pid           | Producer Process Id                                         | String          |
| 10  | context\_pdata\_ver           | context.pdata.ver           | Producer version number                                     | String          |
| 11  | context\_env                  | context.env                 | Context Environment                                         | String          |
| 12  | context\_sid                  | context.sid                 | Session Id                                                  | String          |
| 13  | context\_did                  | context.did                 | Device Id                                                   | String          |
| 14  | context\_cdata\_type          | context.cdata.type          | Correlation Data Type                                       | Array\[String]  |
| 15  | context\_cdata\_id            | context.cdata.id            | Correlation Data Id                                         | Array\[String]  |
| 16  | context\_rollup\_l1           | context.rollup.l1           | Context level 1 rollup                                      | String          |
| 17  | context\_rollup\_l2           | context.rollup.l2           | Context level 2 rollup                                      | String          |
| 18  | context\_rollup\_l3           | context.rollup.l3           | Context level 3 rollup                                      | String          |
| 19  | context\_rollup\_l4           | context.rollup.l4           | Context level 4 rollup                                      | String          |
| 20  | object\_id                    | object.id                   | Content Id                                                  | String          |
| 21  | object\_type                  | object.type                 | Content Type                                                | String          |
| 22  | object\_version               | object.ver                  | Content Version                                             | String          |
| 23  | object\_rollup\_l1            | object.rollup.l1            | Content level 1 rollup                                      | String          |
| 24  | object\_rollup\_l2            | object.rollup.l2            | Content level 2 rollup                                      | String          |
| 25  | object\_rollup\_l3            | object.rollup.l3            | Content level 3 rollup                                      | String          |
| 26  | object\_rollup\_l4            | object.rollup.l4            | Content level 4 rollup                                      | String          |
| 27  | tags                          | tags                        | Tags                                                        | Array\[String]  |
| 28  | edata\_type                   | edata.type                  | Event type                                                  | String          |
| 29  | edata\_subtype                | edata.subtype               | Event subtype                                               | String          |
| 30  | edata\_mode                   | edata.mode                  | START event Mode of start                                   | String          |
| 31  | edata\_pageid                 | edata.pageid                | Unique pageid                                               | String          |
| 32  | edata\_uri                    | edata.uri                   | IMPRESSION event Relative URI of the content                | String          |
| 33  | edata\_id                     | edata.id                    | Event data Id                                               | String          |
| 34  | edata\_duration               | edata.duration              | Duration of the event                                       | Double          |
| 35  | edata\_index                  | edata.index                 | ASSESS event Index of the question within a content         | Integer         |
| 36  | edata\_pass                   | edata.pass                  | ASSESS event Field to identify pass or fail for assessments | String          |
| 37  | edata\_score                  | edata.score                 | ASSESS event Assessment score                               | Double          |
| 38  | edata\_resvalues              | edata.resvalues             | ASSESS event Assessment results                             | Array\[Object]  |
| 39  | edata\_item\_id               | edata.item.id               | ASSESS event Assessment item id                             | String          |
| 40  | edata\_item\_title            | edata.item.title            | ASSESS event Assessment item title                          | String          |
| 41  | edata\_item\_maxscore         | edata.item.maxscore         | ASSESS event Assessment item max score                      | Double          |
| 42  | edata\_target\_id             | edata.target.id             | ASSESS event Assessment item target id                      | String          |
| 43  | edata\_target\_type           | edata.target.type           | ASSESS event Assessment item target type                    | String          |
| 44  | edata\_rating                 | edata.rating                | FEEDBACK event Ratings                                      | Integer         |
| 45  | edata\_comments               | edata.comments              | FEEDBACK event Comments                                     | String          |
| 46  | edata\_dir                    | edata.dir                   | SHARE event direction                                       | String          |
| 47  | edata\_items\_id              | edata.items.id              | SHARE event shared item ids                                 | Array\[String]  |
| 48  | edata\_items\_type            | edata.items.type            | SHARE item types                                            | Array\[String]  |
| 49  | edata\_items\_origin\_id      | edata.items.origin.id       | SHARE event source id                                       | Array\[String]  |
| 50  | edata\_items\_origin\_type    | edata.items.origin.type     | SHARE event source type                                     | Array\[String]  |
| 51  | edata\_items\_to\_id          | edata.items.to.id           | SHARE event destination id                                  | Array\[String]  |
| 52  | edata\_items\_to\_type        | edata.items.to.type         | SHARE event destination type                                | Array\[String]  |
| 53  | edata\_state                  | edata.state                 | AUDIT event current state                                   | String          |
| 54  | edata\_prevstate              | edata.prevstate             | AUDIT event previous state                                  | String          |
| 55  | edata\_size                   | edata.size                  | SEARCH event result size                                    | Integer         |
| 56  | edata\_filters\_dialcodes     | edata.filters.dialcodes     | SEARCH event List of dialcodes                              | Array\[String]  |
| 57  | edata\_topn\_identifier       | edata.topn.identifier       | SEARCH event topn results                                   | Array\[String]  |
| 58  | edata\_visits\_objid          | edata.visits.objid          | IMPRESSION event unique id for object visited               | Array\[String]  |
| 59  | edata\_visits\_objtype        | edata.visits.objtype        | IMPRESSION event type of object visited                     | Array\[String]  |
| 60  | edata\_visits\_objver         | edata.visits.objver         | IMPRESSION event version of object visited                  | Array\[String]  |
| 61  | edata\_visits\_index          | edata.visits.index          | IMPRESSION event index of object within list                | Array\[Integer] |
| 62  | device\_loc\_state            | devicedata.state            | State location information for the device                   | String          |
| 63  | device\_loc\_state\_code      | devicedata.statecode        | State ISO code information for the device                   | String          |
| 64  | device\_loc\_iso\_state\_code | devicedata.iso3166statecode | State ISO-3166 code information for the device              | String          |
| 65  | device\_loc\_city             | devicedata.city             | City location information for the device                    | String          |
| 66  | device\_loc\_country\_code    | devicedata.countrycode      | Country ISO code information for the device                 | String          |
| 67  | device\_loc\_country          | devicedata.country          | Country location information for the device                 | String          |
| 68  | device\_os                    | devicedata.os               | Device OS name                                              | String          |
| 69  | device\_make                  | devicedata.make             | Device make and model                                       | String          |
| 70  | device\_id                    | devicedata.id               | Physical device id if available from OS                     | String          |
| 71  | device\_mem                   | devicedata.mem              | Total memory in mb                                          | Integer         |
| 72  | device\_idisk                 | devicedata.idisk            | Total interanl disk                                         | Integer         |
| 73  | device\_edisk                 | devicedata.edisk            | Total external disk                                         | Integer         |
| 74  | device\_scrn                  | devicedata.scrn             | Screen size in inches                                       | Integer         |
| 75  | device\_camera                | devicedata.camera           | Primary & secondary camera spec                             | String          |
| 76  | device\_cpu                   | devicedata.cpu              | Processor name                                              | String          |
| 77  | device\_sims                  | devicedata.sims             | Number of sim cards                                         | Integer         |
| 78  | device\_uaspec\_agent         | devicedata.uaspec.agent     | User agent of the browser                                   | String          |
| 79  | device\_uaspec\_ver           | devicedata.uaspec.ver       | User agent version of the browser                           | String          |
| 80  | device\_uaspec\_system        | devicedata.uaspec.system    | User agent system identification of the browser             | String          |
| 81  | device\_uaspec\_platform      | devicedata.uaspec.platform  | User agent client platform of the browser                   | String          |
| 82  | device\_uaspec\_raw           | devicedata.uaspec.raw       | Raw user agent of the browser                               | String          |
| 83  | device\_first\_access         | devicedata.firstaccess      | First access of the device                                  | Long (Epoch)    |
| 84  | content\_name                 | contentdata.name            | Name of the content                                         | String          |
| 85  | content\_object\_type         | contentdata.objecttype      | Type of the content                                         | String          |
| 86  | content\_type                 | contentdata.contenttype     | Type of the resource                                        | String          |
| 87  | content\_media\_type          | contentdata.mediatype       | Type of the media of the resource                           | String          |
| 88  | content\_language             | contentdata.language        | List of languages in the content                            | Array\[String]  |
| 89  | content\_medium               | contentdata.medium          | Language medium of the board                                | Array\[String]  |
| 90  | content\_mimetype             | contentdata.mimetype        | Mimetype of the resource in the content                     | String          |
| 91  | content\_framework            | contentdata.framework       |                                                             | String          |
| 92  | content\_board                | contentdata.board           | Board of affiliation                                        | String          |
| 93  | content\_status               | contentdata.status          | Status of the content - Draft, Published etc.               | String          |
| 94  | content\_version              | contentdata.pkgversion      | Version of the content                                      | Double          |
| 95  | content\_last\_submitted\_on  | contentdata.lastsubmittedon | Last submitted date of the content                          | Long (Epoch)    |
| 96  | content\_last\_published\_on  | contentdata.lastpublishedon | Last submitted date of the content                          | Long (Epoch)    |
| 97  | content\_last\_updated\_on    | contentdata.lastupdatedon   | Last updated date of the content                            | Long (Epoch)    |
| 98  | user\_grade\_list             | userdata.gradelist          | List of grades taught                                       | Array\[String]  |
| 99  | user\_language\_list          | userdata.languagelist       | List of languages known                                     | Array\[String]  |
| 100 | user\_subject\_list           | userdata.subjectlist        | List of subjects taught                                     | Array\[String]  |
| 101 | user\_type                    | userdata.type               | Type of user                                                | String          |
| 102 | user\_loc\_state              | userdata.state              | State info of the user                                      | String          |
| 103 | user\_loc\_district           | userdata.district           | District info of the user                                   | String          |
| 104 | user\_loc\_block              | userdata.block              | Block info of the user                                      | String          |
| 105 | dialcode\_channel             | dialcodedata.channel        | Channel for which dialcode is generated                     | String          |
| 106 | dialcode\_batchcode           | dialcodedata.batchcode      | Batch for which dialcode belongs to                         | String          |
| 107 | dialcode\_publisher           | dialcodedata.publisher      | Publisher of the dialcode                                   | String          |
| 108 | dialcode\_generated\_on       | dialcodedata.generatedon    | Dialcode generated on                                       | Long (Epoch)    |
| 109 | dialcode\_published\_on       | dialcodedata.publishedon    | Dialcode published on                                       | Long (Epoch)    |
| 110 | dialcode\_status              | dialcodedata.status         | Status of the dialcode                                      | String          |
| 111 | dialcode\_object\_type        | dialcodedata.objecttype     | Object type - DialCode as a value                           | String          |

#### Summary Events

|    | Dimension in Druid                  | Field in Summary event                | Description                                                          | Data Type            |
| -- | ----------------------------------- | ------------------------------------- | -------------------------------------------------------------------- | -------------------- |
| 1  | ets                                 | ets                                   | Event timestamp                                                      | Long                 |
| 2  | eid                                 | eid                                   | Event Id                                                             | String               |
| 3  | ver                                 | ver                                   | Version                                                              | String               |
| 4  | syncts                              | syncts                                | Sync timestamp                                                       | Long                 |
| 5  | uid                                 | uid                                   | User Id                                                              | String               |
| 6  | context\_date\_range\_from          | context.date\_range.from              | Start Date for the summary                                           | Long (Epoch)         |
| 7  | context\_date\_range\_to            | context.date\_range.to                | End Date for the summary                                             | Long (Epoch)         |
| 8  | context\_rollup\_l1                 | context.rollup.l1                     | Context level1 rollup                                                | String               |
| 9  | context\_rollup\_l2                 | context.rollup.l2                     | Context level2 rollup                                                | String               |
| 10 | context\_rollup\_l3                 | context.rollup.l3                     | Context level3 rollup                                                | String               |
| 11 | context\_rollup\_l4                 | context.rollup.l4                     | Context level4 rollup                                                | String               |
| 12 | dimension\_channel                  | dimensions.channel                    | Channel Id as dimension from raw telemetry                           | String               |
| 13 | dimensions\_did                     | dimensions.did                        | Device Id as dimension from raw telemetry                            | String               |
| 14 | dimensions\_pdata\_id               | dimensions.pdata.id                   | Producer Id as dimension from raw telemetry                          | String               |
| 15 | dimensions\_pdata\_pid              | dimensions.pdata.pid                  | Producer Process Id as dimension from raw telemetry                  | String               |
| 16 | dimensions\_pdata\_ver              | dimensions.pdata.ver                  | Producer Process Ver as dimension from raw telemetry                 | String               |
| 17 | dimensions\_sid                     | dimensions.sid                        | Session Id as dimension                                              | String               |
| 18 | dimensions\_type                    | dimensions.type                       | Type of summary                                                      | String               |
| 19 | dimensions\_mode                    | dimensions.mode                       | Mode of action in the session                                        | String               |
| 20 | object\_id                          | object.id                             | Content Id                                                           | String               |
| 21 | object\_type                        | object.type                           | Content Type                                                         | String               |
| 22 | object\_version                     | object.ver                            | Content version                                                      | String               |
| 23 | object\_rollup\_l1                  | object.rollup.l1                      | Object level1 rollup                                                 | String               |
| 24 | object\_rollup\_l2                  | object.rollup.l2                      | Object level2 rollup                                                 | String               |
| 25 | object\_rollup\_l3                  | object.rollup.l3                      | Object level3 rollup                                                 | String               |
| 26 | object\_rollup\_l4                  | object.rollup.l4                      | Object level4 rollup                                                 | String               |
| 27 | tags                                | tags                                  | Tags attached to a summary event                                     | Array\[\[\[String    |
| 28 | edata\_time\_spent                  | edata.eks.time\_spent                 | Time spent in the session excluding idle time                        | Double               |
| 29 | edata\_time\_difference             | edata.eks.time\_diff                  | Total time in a session including idle time                          | Double               |
| 30 | edata\_interaction\_count           | edata.eks.interact\_events\_count     | Total count of interact events in a session                          | Long                 |
| 31 | edata\_env\_summary\_env            | edata.eks.env\_summary.env            | High level env within the app(content, domain, resources, community) | Array\[String]       |
| 32 | edata\_env\_summary\_count          | edata.eks.env\_summary.count          | Count of times the environment has been visited                      | Array\[Integer]      |
| 33 | edata\_env\_summary\_time\_spent    | edata.eks.env\_summary.time\_spent    | Time spent per env                                                   | Array\[Double]       |
| 34 | edata\_page\_summary\_id            | edata.eks.page\_summary.id            | Page id                                                              | Array\[String]       |
| 35 | edata\_page\_summary\_type          | edata.eks.page\_summary.type          | Type of page e.g. view/edit                                          | Array\[String]       |
| 36 | edata\_page\_summary\_env           | edata.eks.page\_summary.env           | Env of page                                                          | Array\[String]       |
| 37 | edata\_page\_summary\_visit\_count  | edata.eks.page\_summary.visit\_count  | Number of times each page was visited                                | Array\[Integer]      |
| 38 | edata\_page\_summary\_time\_spent   | edata.eks.page\_summary.time\_spent   | Time taken per page                                                  | Array\[Double]       |
| 39 | edata\_item\_responses\_item\_id    | edata.eks.item\_responses.itemId      | Question Id passed in the ASSESS event                               | Array\[String]       |
| 40 | edata\_item\_responses\_time\_spent | edata.eks.item\_responses.timeSpent   | Time spent in seconds from ASSESS event                              | Array\[Double]       |
| 41 | edata\_item\_responses\_pass        | edata.eks.item\_responses.pass        | Pass response for a question from ASSESS event                       | Array\[String]       |
| 42 | edata\_item\_responses\_score       | edata.eks.item\_responses.score       | Score from ASSESS event                                              | Array\[\[\[Integer   |
| 43 | edata\_item\_responses\_max\_score  | edata.eks.item\_responses.maxScore    | Max Score from ASSESS event                                          | Array\[\[\[Integer   |
| 44 | edata\_item\_responses\_timestamp   | edata.eks.item\_responses.time\_stamp | Timestamp for each response from ASSESS event                        | Array\[Long (Epoch)] |
| 45 | device\_loc\_state                  | devicedata.state                      | State location information for the device                            | String               |
| 46 | device\_loc\_state\_code            | devicedata.statecode                  | State ISO code information for the device                            | String               |
| 47 | device\_loc\_iso\_state\_code       | devicedata.iso3166statecode           | State ISO-3166 code information for the device                       | String               |
| 48 | device\_loc\_city                   | devicedata.city                       | City location information for the device                             | String               |
| 49 | device\_loc\_country\_code          | devicedata.countrycode                | Country ISO code information for the device                          | String               |
| 50 | device\_loc\_country                | devicedata.country                    | Country location information for the device                          | String               |
| 51 | device\_os                          | devicedata.os                         | Device OS name                                                       | String               |
| 52 | device\_make                        | devicedata.make                       | Device make and model                                                | String               |
| 53 | device\_id                          | devicedata.id                         | Physical device id if available from OS                              | String               |
| 54 | device\_mem                         | devicedata.mem                        | Total memory in mb                                                   | Integer              |
| 55 | device\_idisk                       | devicedata.idisk                      | Total interanl disk                                                  | Integer              |
| 56 | device\_edisk                       | devicedata.edisk                      | Total external disk                                                  | Integer              |
| 57 | device\_scrn                        | devicedata.scrn                       | Screen size in inches                                                | Integer              |
| 58 | device\_camera                      | devicedata.camera                     | Primary & secondary camera spec                                      | String               |
| 59 | device\_cpu                         | devicedata.cpu                        | Processor name                                                       | String               |
| 60 | device\_sims                        | devicedata.sims                       | Number of sim cards                                                  | Integer              |
| 61 | device\_uaspec\_agent               | devicedata.uaspec.agent               | User agent of the browser                                            | String               |
| 62 | device\_uaspec\_ver                 | devicedata.uaspec.ver                 | User agent version of the browser                                    | String               |
| 63 | device\_uaspec\_system              | devicedata.uaspec.system              | User agent system identification of the browser                      | String               |
| 64 | device\_uaspec\_platform            | devicedata.uaspec.platform            | User agent client platform of the browser                            | String               |
| 65 | device\_uaspec\_raw                 | devicedata.uaspec.raw                 | Raw user agent of the browser                                        | String               |
| 66 | device\_first\_access               | devicedata.firstaccess                | First access of the device                                           | Long (Epoch)         |
| 67 | content\_name                       | contentdata.name                      | Name of the content                                                  | String               |
| 68 | content\_object\_type               | contentdata.objecttype                | Type of the content                                                  | String               |
| 69 | content\_type                       | contentdata.contenttype               | Type of the resource                                                 | String               |
| 70 | content\_media\_type                | contentdata.mediatype                 | Type of media of the content                                         | String               |
| 71 | content\_language                   | contentdata.language                  | List of languages                                                    | Array\[String]       |
| 72 | content\_medium                     | contentdata.medium                    | Language medium of the board                                         | String               |
| 73 | content\_mimetype                   | contentdata.mimetype                  | Mimetype of the content                                              | String               |
| 74 | content\_framework                  | contentdata.framework                 |                                                                      | String               |
| 75 | content\_board                      | contentdata.board                     | Board of affiliation                                                 | String               |
| 76 | content\_status                     | contentdata.status                    | Status of the content - Draft, Published etc.                        | String               |
| 77 | content\_version                    | contentdata.pkgversion                | Version of the content                                               | Double               |
| 78 | content\_last\_submitted\_on        | contentdata.lastsubmittedon           | Last submitted date of the content                                   | Long (Epoch)         |
| 79 | content\_last\_published\_on        | contentdata.lastpublishedon           | Last published date of the content                                   | Long (Epoch)         |
| 80 | content\_last\_updated\_on          | contentdata.lastupdatedon             | Last updated date of the content                                     | Long (Epoch)         |
| 81 | user\_grade\_list                   | userdata.gradelist                    | List of grades taught                                                | Array\[String]       |
| 82 | user\_language\_list                | userdata.languagelist                 | List of languages known                                              | Array\[String]       |
| 83 | user\_subject\_list                 | userdata.subjectlist                  | List of subjects taught                                              | Array\[String]       |
| 84 | user\_type                          | userdata.type                         | Type of the user                                                     | String               |
| 85 | user\_loc\_state                    | userdata.state                        | State info of the user                                               | String               |
| 86 | user\_loc\_district                 | userdata.district                     | District info of the user                                            | String               |
| 87 | user\_loc\_block                    | userdata.block                        | Block info of the user                                               | String               |

AggregatesGranularity → DAY

| Druid field name    | Druid source field | Aggregate Type |
| ------------------- | ------------------ | -------------- |
| total\_interactions | interaction\_count | SUM            |
| total\_time\_spent  | time\_spent        | SUM            |
| total\_sessions     | mid                | COUNT          |
|                     |                    |                |

### Report JSON Spec

#### JSON Schema

```js
[{
    id: String, // Required. Report ID.
    label: String, // Required. Report Label (will be shown up as menu)
    title: String, // Optional. Report title. Defaults to report label
    description: String, // Optional. Report description. HTML text can be included as description
    dataSource: String, // Required. Location of the data source to show the report. Can be an expression. For ex: /<report_id>/{{channel}}/report.json
    charts: [{ // Optional
 		datasets: [{
			data: Array[Number], // Required if `dataExpr` is not provided. Array of Number. Data points to show in the chart
			dataExpr: String, // Required if `data` is not provided. Expression pointing to the data in dataSource. For ex: {{data.noOfDownloads}}
			label: String // Required. Label to display on the chart
		}],
		labels: Array[String], // Required if `labelsExpr` is not provided. Labels to show on the x-axis
		labelsExpr: String, // Required if `labels` is not provided. Expression pointing to the data in dataSource. For ex: {{data.Date}}
		chartType: String, // Optional. Defaults to line. Available types - line, bar, radar, pie, polarArea & doughnut
		colors: [""], // Optional. Color to show for each dataset. Defaults to ["#024F9D"].
		options: { // Optional. options for display. Full set of options look at https://valor-software.com/ng2-charts/
			responsive: Boolean, // Defaults to true
			...
		}, 
		legend: Boolean // Optional. Whether to show the legend below/above the chart. Defaults to true and position to top.
    }],
    table: { // Optional
        "columns": Array[String], // Required if `columnsExpr` is not provided. Columns to show.
        "values": Array[Array[String]] , // Required if `valuesExpr` is not provided. Column data.
        "columnsExpr": String, // Required if `columns` is not provided. Expression pointing to the data in dataSource. For ex: {{keys}}
        "valuesExpr": String // Required if `values` is not provided. Expression pointing to the data in dataSource. For ex: {{tableData}}
    },
    downloadUrl: String // Location to download the data as CSV
}]] ]></ac:plain-text-body></ac:structured-macro><p>Following is a example schema to show the general usage report </p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="6c7996fe-6742-46dd-9f4e-91a3234d7381"><ac:parameter ac:name="language">js</ac:parameter><ac:plain-text-body><![CDATA[{
    id: "usage",
    label: "Diksha Usage Report",
    title: "Diksha Usage Report",
    description: "The report provides a quick summary of the data analysed by the analytics team to track progess of Diksha across states. This report will be used to consolidate insights using various metrics on which Diksha is currently being mapped and will be shared on a weekly basis. The first section of the report will provide a snapshot of the overall health of the Diksha App. This will be followed by individual state sections that provide state-wise status of Diksha",
    dataSource: "/usage/$state/report.json",
    charts: [
        {
        	datasets: [{
        		dataExpr: "data.Number_of_downloads",
        		label: "# of downloads"
        	}],
        	labelsExpr: "data.Date",
            chartType: "line"
        },
        {
        	datasets: [{
        		dataExpr: "data.Number_of_succesful_scans",
        		label: "# of successful scans"
        	}],
        	labelsExpr: "data.Date",
            chartType: "bar"
        }
    ],
    table: {
        "columnsExpr": "key",
        "valuesExpr": "tableData"
    },
    downloadUrl: "<report_id>/$state/report.csv"
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]

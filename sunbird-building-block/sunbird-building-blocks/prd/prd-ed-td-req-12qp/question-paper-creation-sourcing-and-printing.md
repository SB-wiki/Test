# Question-Paper--Creation,-Sourcing,-and-Printing

#### **1. Admin will create Question Paper structure through Workspace**

1.1 Create a new Collection category - Question paper

Create Question Paper Design Flow - [https://saketsinha847338.invisionapp.com/console/share/4Z21W3TCQU/497390837](https://saketsinha847338.invisionapp.com/console/share/4Z21W3TCQU/497390837)

Planned Delivery - **12th Jan 2021**

Implementation Approach:

1. Define a new primary category \[ Use the Collection creation API suggested in this GitHub discussion [thread](https://github.com/project-sunbird/sunbird-community/discussions/26) ]
2. Add Blueprint variables in schema - only for Collection - Question paper

***

* Workspace should include a new **Collection** category for Question Paper.
  * Define new Collection category for Question Paper. Share definition for review.
  * Must include _visibility_ , _printable_ , and _print status_ attributes. Add _Printable_ and _Print Status_ to Collection schema.
  * Workspace should show it for user with role CREATOR. Any changes required? Configuration change for Workspace page configuration?
* Collection creation flow remains as-is. Admin will save it as draft (include in Program user manual)

Clarifications:

1. API details updated on Github thread: [https://github.com/project-sunbird/sunbird-community/discussions/26](https://github.com/project-sunbird/sunbird-community/discussions/26)

**2. Admin to create a sourcing project which includes Content-type ‘Exam Questions’, Target collection ‘Question Paper’ and provision to add values for blueprint variables for this project** notePlanned Delivery - **15th Jan 2021**

Implementation Approach:

1. Update Schema to include 'Exam Question' in Content-Type
2. Update schema to include in 'Question Paper' in Target collection list
3. Popup - To add blueprint variables for the project \[ Design Link- [https://saketsinha847338.invisionapp.com/console/share/SH21W554JV/497391177](https://saketsinha847338.invisionapp.com/console/share/SH21W554JV/497391177) ]

***

Project creation: settings to be used by Admin:

* Nomination disabled
* Two-step review enabled (Not to Skip)
*   Project scope: Content Types (categories) to include **Exam Questions**

    _When contributor clicks “Create New” they will see “Exam Questions” in the selection popup. On selecting “Exam Questions” the will get question type selection. They will be able to create one or more questions of the selected type._

    * **Exam Questions** as a new **Content** category. Share definition for review.

    mimeType: ECML, Question format: QuML,

    visibility: private, and ..

    sourcingConfig": { "editor" : \[ { "mimetype": "application/vnd.ekstep.ecml-archive", "type": "question" } ] }

    * **Target Collection** should include collections of category _Digital Textbook_ and _Question Paper_ while creating a project. Configuration update for Creation portal?

    _Admin can search the ‘Question Paper’ created earlier, include it in the sourcing project so that contributors create ‘Exam Questions’ and reviewers can review them._

Planned Delivery - **15th Jan 2021**

Implementation Approach:

1. Update Schema to include 'Exam Question' in Content-Type
2. Update schema to include in 'Question Paper' in Target collection list
3. Popup - To add blueprint variables for the project \[ Design Link- [https://saketsinha847338.invisionapp.com/console/share/SH21W554JV/497391177](https://saketsinha847338.invisionapp.com/console/share/SH21W554JV/497391177) ]

***

Project creation: settings to be used by Admin:

* Nomination disabled
* Two-step review enabled (Not to Skip)
*   Project scope: Content Types (categories) to include **Exam Questions**

    _When contributor clicks “Create New” they will see “Exam Questions” in the selection popup. On selecting “Exam Questions” the will get question type selection. They will be able to create one or more questions of the selected type._

    * **Exam Questions** as a new **Content** category. Share definition for review.

    mimeType: ECML, Question format: QuML,

    visibility: private, and ..

    sourcingConfig": { "editor" : \[ { "mimetype": "application/vnd.ekstep.ecml-archive", "type": "question" } ] }

    * **Target Collection** should include collections of category _Digital Textbook_ and _Question Paper_ while creating a project. Configuration update for Creation portal?

    _Admin can search the ‘Question Paper’ created earlier, include it in the sourcing project so that contributors create ‘Exam Questions’ and reviewers can review them._

Clarifications:

1.  How to update the configuration? (Which Files to edit / Which API to hit for making these changes?)

    Details to be updated on GitHub Discussion thread: [https://github.com/project-sunbird/sunbird-community/discussions/26](https://github.com/project-sunbird/sunbird-community/discussions/26)
2. Sharing of steps needed to add the blueprint form, for Question Paper Collection.
3. Do we have to write a new service to store the value of blueprint variables? \[Assumption: No new service needs to be written]
   * No new service needs to be written this will be handled in the generic implementation of the form data collection.

**3. Admin assigns or invites Contributors and Reviewers for the project** noteNo change.

3.1 Login through Contribution portal (../contribute) to

* assign / invite Contributors
* assign / invite Reviewer-1

3.2 Login through Sourcing portal (../sourcing) to

* assign / invite Reviewer-2

No change.

3.1 Login through Contribution portal (../contribute) to

* assign / invite Contributors
* assign / invite Reviewer-1

3.2 Login through Sourcing portal (../sourcing) to

* assign / invite Reviewer-2

**4. Contributor creates questions of various types and submits for review** notePlanned Delivery - **19th Jan 2021**

Implementation Approach:

4.1 Login to Contribution portal \[No change required.]

4.2 Select Sourcing Project from My Projects \[No change required.]

4.3 Create new → Select content type Exam Question → Choose type of question → Question editor opens \[Change Required]

```
4.3.1 - Create question Desing UI/UX - [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391281](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391281)

4.3.2 - PR [https://github.com/Sunbird-Ed/creation-portal/pull/1195](https://github.com/Sunbird-Ed/creation-portal/pull/1195)
```

To be Done:

4.4 Remove modal to select the mode of creation - \[ [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391285](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391285) ]

4.5 Add tags for a question - [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391287](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391287)

4.6 Set Default values for the question set properties - [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391288](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391288)

No change required.

4.7 Preview of question

4.8 Submit a question

***

1.  “Create New” at any place in the ‘Question Paper’.

    → Creating new Content will inherit certain attributes from the Target collection into the Content metadata details.

    This should include _Visibility_ , _Printable_ , and _Print Status_ . Change required? Share implementation details.
2. Contributor can create following question types..
   1. Interactive
   2. Multiple Choice Question
   3. Non-interactive
   4. VSA
   5. SA
   6. LA
   7. Fill in The Blank
   8. Match The Following

→ Create FTB, MTF as new “category” for reference “type” of questions (assessmentItem). Share implementation details for review.

1.  Contributor selects Competency, Skill Type for each of the questions

    → Question creation page has two form fields. The form fields are configured using **Form API** for ‘Exam Question’ content category for a specific tenant. Share implementation details for review.

    → **Competency** is mapped to ‘Topic’ in taxonomy framework. Review if existing topics are sufficient. Update the list of ‘Topics(s)’.

    Reach out to specific tenant (HR) team to share existing list of topics.

    → **Skill Type** maps to Learning Level (Bloom’s). Point to the list on GitHub. Review if existing values are sufficient.

Planned Delivery - **19th Jan 2021**

Implementation Approach:

4.1 Login to Contribution portal \[No change required.]

4.2 Select Sourcing Project from My Projects \[No change required.]

4.3 Create new → Select content type Exam Question → Choose type of question → Question editor opens \[Change Required]

```
4.3.1 - Create question Desing UI/UX - [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391281](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391281)

4.3.2 - PR [https://github.com/Sunbird-Ed/creation-portal/pull/1195](https://github.com/Sunbird-Ed/creation-portal/pull/1195)
```

To be Done:

4.4 Remove modal to select the mode of creation - \[ [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391285](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391285) ]

4.5 Add tags for a question - [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391287](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391287)

4.6 Set Default values for the question set properties - [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391288](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497391288)

No change required.

4.7 Preview of question

4.8 Submit a question

***

1.  “Create New” at any place in the ‘Question Paper’.

    → Creating new Content will inherit certain attributes from the Target collection into the Content metadata details.

    This should include _Visibility_ , _Printable_ , and _Print Status_ . Change required? Share implementation details.
2. Contributor can create following question types..
   1. Interactive
   2. Multiple Choice Question
   3. Non-interactive
   4. VSA
   5. SA
   6. LA
   7. Fill in The Blank
   8. Match The Following

→ Create FTB, MTF as new “category” for reference “type” of questions (assessmentItem). Share implementation details for review.

1.  Contributor selects Competency, Skill Type for each of the questions

    → Question creation page has two form fields. The form fields are configured using **Form API** for ‘Exam Question’ content category for a specific tenant. Share implementation details for review.

    → **Competency** is mapped to ‘Topic’ in taxonomy framework. Review if existing topics are sufficient. Update the list of ‘Topics(s)’.

    Reach out to specific tenant (HR) team to share existing list of topics.

    → **Skill Type** maps to Learning Level (Bloom’s). Point to the list on GitHub. Review if existing values are sufficient.

Clarifications required:

1. _**How to hide**_ the intermediate pop-up, and directly go from Exam Question Screen to Question type selection screen \[Step 4.4]
2. Do we need to write a new service to store these values (question tags) or is it only frontend change?
3. _**How to set**_ the default values for the question set, as shown in Step 4.6 above?

**5. Reviewer-1 can Accept or Request for Changes for each ‘Exam Questions’ content (containing one or more questions)** noteNo change.

Login to Contribution portal using Reviewer credentials

* **Accept** : will Publish ‘Exam question’ ( _Content containing question(s)_ ) in Sourcing repo. This will be available for reuse later by during Contribution - not available for consumption.
* **Reject** / **Request for Changes** : Send it back to contributor for corrections

No change.

Login to Contribution portal using Reviewer credentials

* **Accept** : will Publish ‘Exam question’ ( _Content containing question(s)_ ) in Sourcing repo. This will be available for reuse later by during Contribution - not available for consumption.
* **Reject** / **Request for Changes** : Send it back to contributor for corrections

**6. Reviewer-2 (Question Paper creator)** **6.1 - Can Accept or Reject or Request for Changes for each ‘Exam Questions’ content (containing one or more questions)** note

* **Accept** will … ?
  * **Accept** will be disabled for each ‘Exam question’ ( _Content containing question(s)_ ). This will ensure that ‘Exam Questions’ are not published for consumption.
  * **Ready for Print** will show up instead since this Content is _Printable_
  * If Reviewer-2 select **Ready for Print** , _Print Status_ will be updated to ..
* **Reject** will remove the ‘Exam question’ (Content containing one question) from ‘Question Paper’ collection
* **Request for Change** will send back the ‘Exam Question(s)' to contributor for correction
* **Accept** will … ?
  * **Accept** will be disabled for each ‘Exam question’ ( _Content containing question(s)_ ). This will ensure that ‘Exam Questions’ are not published for consumption.
  * **Ready for Print** will show up instead since this Content is _Printable_
  * If Reviewer-2 select **Ready for Print** , _Print Status_ will be updated to ..
* **Reject** will remove the ‘Exam question’ (Content containing one question) from ‘Question Paper’ collection
* **Request for Change** will send back the ‘Exam Question(s)' to contributor for correction

**6.2 - Can** **view progress against the blueprint** notePlanned Delivery - **19th Jan 2021**

Implementation approach:

1. Design link - [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497399268?frame-cb=1610434742599](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497399268?frame-cb=1610434742599)
2.  Create a frontend widget, to show the progress

    Assumption: Project values for blueprint set at the time of the creation of the project are available here

Planned Delivery - **19th Jan 2021**

Implementation approach:

1. Design link - [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497399268?frame-cb=1610434742599](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497399268?frame-cb=1610434742599)
2.  Create a frontend widget, to show the progress

    Assumption: Project values for blueprint set at the time of the creation of the project are available here

Clarification required:

1. Confirmation on the design [https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497399268?frame-cb=1610434742599](https://saketsinha847338.invisionapp.com/console/share/JV21W55CTY/497399268?frame-cb=1610434742599)
2. Validate Assumption

**6.3 - Print Preview - For Question Paper creator (Sourcing Reviewer)** noteImplementation Approach:

1. On the Project details page, where the list of questions is shown to the Question paper creator. They also see a On print preview button
2. On click of print preview - a new popup opens which shows the question paper in the pdf format.
   1. Name of Collection → Heading of paper
   2. Description of the collection → Instruction block
   3. Section Name → Section name
   4. Questions, marks, options(if applicable) are shown.
   5. Based on Grade and Medium, the template is decided by the API and the preview is generated (Grade 1-5, provision to write in the paper, Grade 5+ Only question paper)

Engineering implementation:

1. Create a standalone API service that creates gets all the collection hierarchy data based on project ID
2. Formats all the information in the template defined method
3. API Generates the preview of the paper in pdf format.
4. Frontend - on click of the Print Preview button, calls the API and the preview is generated in realtime.

To be added in API in 3.8 cycle

1. Add Support for printing Images
2. Support for Symbols and formulas
3. Support for configurable template

Implementation Approach:

1. On the Project details page, where the list of questions is shown to the Question paper creator. They also see a On print preview button
2. On click of print preview - a new popup opens which shows the question paper in the pdf format.
   1. Name of Collection → Heading of paper
   2. Description of the collection → Instruction block
   3. Section Name → Section name
   4. Questions, marks, options(if applicable) are shown.
   5. Based on Grade and Medium, the template is decided by the API and the preview is generated (Grade 1-5, provision to write in the paper, Grade 5+ Only question paper)

Engineering implementation:

1. Create a standalone API service that creates gets all the collection hierarchy data based on project ID
2. Formats all the information in the template defined method
3. API Generates the preview of the paper in pdf format.
4. Frontend - on click of the Print Preview button, calls the API and the preview is generated in realtime.

To be added in API in 3.8 cycle

1. Add Support for printing Images
2. Support for Symbols and formulas
3. Support for configurable template

Reviewer 2 will review each of the ‘Exam Question’ content against the ‘Question Paper’ collection through the “Sourcing” portal.

On ‘accepting’ the ‘Exam Question’ will be published in sourcing and consumption repository with _visibility = private_ (set in category definition)

Now Reviewer 2, after completion of review, goes to Workspace. From Workspace, ‘Question Paper’ can be edited and submitted for Review.

User with ‘Question Paper’ review role (Reviewer 3) can publish the ‘Question Paper' (should not be same as the person who created the ‘Question Paper’)￼

On publishing, the 'Question Paper’ has _visibility = private_ (set in category definition)

A job listens to this event and prints required PDF / DOC and sends it via email to Question Paper creator (Reviewer-2)

## Configurations

#### Following configurations are required to be made by Dev Ops team enable Question Paper workflow

| **Capability**                                                                               | **Description**                                                   | **Corresponding Request for Prashnavali <> QuML Integration**       | **Highlights of the configuration** | **Link to configuration** |
| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------- | ----------------------------------- | ------------------------- |
| Create Question Paper                                                                        | Define collection category “Question Paper” for a specific tenant | Define Question Set category “Question Paper” for a specific tenant |                                     |                           |
| \`\`\`                                                                                       |                                                                   |                                                                     |                                     |                           |
| curl --location --request POST 'https://dock.sunbirded.org/api/object/category/v1/create' \\ |                                                                   |                                                                     |                                     |                           |
| --header 'Authorization: Bearer \{{devToken\}}' \\                                           |                                                                   |                                                                     |                                     |                           |
| --header 'Content-Type: application/json' \\                                                 |                                                                   |                                                                     |                                     |                           |
| --data-raw '{                                                                                |                                                                   |                                                                     |                                     |                           |
| "request": {                                                                                 |                                                                   |                                                                     |                                     |                           |

```
"objectCategory": {
  "name": "Question paper",
  "description": "Question papers for examinations to be conducted by the state"
}
```

} }'

```
 | 
| Question Paper category definition | Enable Creation through Workspace of “Question Paper” for CONTENT_CREATOR role for a specific tenant | Configure definition of Question Paper Question Set category | Default appIcon  Printable = true Author = SCERT Haryana Include Blueprint Create form | 
```

curl --location --request PATCH 'https://dev.sunbirded.org/api/object/category/definition/v1/update/obj-cat:question-paper\_collection\_01309282781705830427' \
\--header 'Authorization: Bearer \{{devToken\}}' \
\--header 'Content-Type: application/json' \
\--data-raw '{     "request": {         "objectCategoryDefinition": {                         "objectMetadata": {                 "config": {},                 "schema": {                     "properties": {                         "mimeType": {                             "type": "string",                             "enum": \[                                 "application/vnd.ekstep.content-collection"                             ]                         },                         "appIcon": {                             "type": "string",                             "default": "https://sunbirddev.blob.core.windows.net/sunbird-content-dev/content/do\_11320764935163904015/artifact/2020101299.png"                                                      },                         "author": {                             "type": "string",                             "default": "SCERT Haryana"                         },                         "printable": {                             "type": "boolean",                             "default": true                         }                                           }                 }             },             "languageCode": \[],             "forms": {                 "blueprintCreate": {                     "templateName": "",                     "required": \[],                     "properties": \[                         {                             "code": "topics",                             "dataType": "list",                             "description": "",                             "editable": true,                             "index": 0,                             "inputType": "multiSelect",                             "label": "Chapters",                             "name": "Chapters",                             "placeholder": "Please select chapters",                             "renderingHints": {},                             "required": true                         },                         {                             "code": "learningOutcomes",                             "dataType": "list",                             "description": "",                             "editable": true,                             "index": 1,                             "inputType": "multiSelect",                             "label": "Competencies",                             "name": "Competencies",                             "placeholder": "Please select Competencies",                             "depends": \[                                 "chapters"                             ],                             "renderingHints": {},                             "required": false                         },                         {                             "code": "learningLevels",                             "editable": true,                             "displayProperty": "Editable",                             "dataType": "text",                             "renderingHints": {                                 "semanticColumnWidth": "twelve"                             },                             "label": "Skills Tested",                             "required": true,                             "name": "Learning Levels",                             "index": 2,                             "inputType": "select",                             "placeholder": "",                             "default": 0,                             "options": \[                                 0,                                 1,                                 2,                                 3,                                 4,                                 5                             ],                             "children": \[                                 {                                     "type": "learningLevel",                                     "label": "Knowledge",                                     "code": "remember"                                 },                                 {                                     "type": "learningLevel",                                     "label": "Understanding",                                     "code": "understand"                                 },                                 {                                     "type": "learningLevel",                                     "label": "Application",                                     "code": "apply"                                 }                             ]                         },                         {                             "code": "questionTypes",                             "editable": true,                             "displayProperty": "Editable",                             "dataType": "text",                             "renderingHints": {                                 "semanticColumnWidth": "twelve"                             },                             "description": "Question Types",                             "index": 2,                             "label": "Question Types",                             "default": 0,                             "required": true,                             "name": "Question Types",                             "inputType": "select",                             "children": \[                                                                 {                                     "type": "questionType",                                     "label": "Objective",                                     "code": "Objective"                                 },                                 {                                     "type": "questionType",                                     "label": "Very Short Answer",                                     "code": "VSA"                                 },                                 {                                     "type": "questionType",                                     "label": "Short Answer",                                     "code": "SA"                                 },                                 {                                     "type": "questionType",                                     "label": "Long Answer",                                     "code": "LA"                                 }                             ],                             "options": \[                                 0,                                 1,                                 2,                                 3,                                 4,                                 5                             ],                             "placeholder": "Question Types"                         },                         {                             "code": "totalMarks",                             "editable": true,                             "displayProperty": "Editable",                             "dataType": "text",                             "renderingHints": {                                 "semanticColumnWidth": "three"                             },                             "description": "Total Marks",                             "index": 4,                             "label": "Total Marks",                             "required": true,                             "default": 0,                             "name": "Total Marks",                             "inputType": "text",                             "placeholder": ""                         }                     ]                 }             }         }     } }'

```
 | 
| Create Exam Questions | Define content category “Exam Questions | Define question object category “Exam Questions |  | 
```

curl --location --request POST 'https://dev.sunbirded.org/api/object/category/v1/create' \
\--header 'Authorization: Bearer \{{devToken\}}' \
\--header 'Content-Type: application/json' \
\--data-raw '{   "request": {     "objectCategory": {       "name": "Exam Question",       "description": "Questions for examinations to be conducted by institutions"     }   } }'

```
 | 
| Exam Question Metadata | Exam Question category definition | Configure definition of “Exam Question” Question category | maxQuestions = 1 Set question update form (include Learning Outcomes, Topics) | 
```

curl --location --request PATCH 'https://dev.sunbirded.org/api/object/category/definition/v1/update/obj-cat:exam-question\_content\_all'\
\--header 'Authorization: Bearer \{{devToken\}}'\
\--header 'Content-Type: application/json'\
\--data-raw '{ "request": { "objectCategoryDefinition": {\
"objectMetadata": { "config": { "sourcingConfig": { "editor": \[ { "mimetype": "application/vnd.ekstep.ecml-archive", "type": "question" } ]\
} }, "schema": { "properties": { "mimeType": { "type": "string", "enum": \[ "application/vnd.ekstep.ecml-archive" ] }, "maxQuestions": { "type": "number", "default": 1 } } } }, "languageCode": \[], "forms": { "create": {}, "delete": {}, "publish": {}, "review": {}, "search": {}, "update": { "templateName": "", "required": \[], "properties": \[ { "code": "name", "editable": true, "displayProperty": "Editable", "dataType": "text", "renderingHints": { "semanticColumnWidth": "twelve" }, "description": "Name", "index": 1, "label": "Name", "required": false, "name": "Name", "inputType": "text", "placeholder": "Name" }, { "code": "topic", "dataType": "list", "description": "", "editable": true, "index": 2, "inputType": "multiSelect", "label": "Chapter", "name": "Chapter", "placeholder": "Select chapter",\
"renderingHints": {}, "required": false, "visible": true },\
{ "code": "learningOutcome", "dataType": "list", "description": "", "editable": true, "index": 3, "inputType": "multiSelect", "label": "Competency", "name": "Competency", "placeholder": "Select competency",\
"renderingHints": {}, "required": false, "visible": true }, { "code": "bloomsLevel", "inputType" : "multiSelect", "dataType": "list",\
"description": "Cognitive processes involved to answer the question set.", "index": 4, "range": \[ { "bloomLevel": "remember", "name": "Remember" }, { "bloomLevel": "understand", "name": "Understand" }, {\
"bloomLevel": "apply",\
"name": "Apply" }, { "bloomLevel": "analyse", "name": "Analyse" }, { "bloomLevel": "evaluate", "name": "Evaluate" }, { "bloomLevel": "create", "name": "Create" } ], "renderingHints": { "semanticColumnWidth": "twelve" }, "required": false, "visible": true, "editable": true, "name": "Learning Level", "label": "Skills Tested" },\
{ "code": "marks", "visible": true, "editable": true, "displayProperty": "Marks", "dataType": "text", "label": "Marks", "name": "Marks", "required": true, "renderingHints": { "semanticColumnWidth": "six" }, "description": "Marks of the question in the examination", "index": 5, "inputType": "text", "placeholder": "0" },\
{ "code": "author", "dataType": "text", "description": "Author", "editable": true, "index": 6, "inputType": "text", "label": "Author", "name": "Author", "placeholder": "Author", "tooltip": "Provide name of creator of this content.", "renderingHints": {}, "required": false }, { "code": "copyright", "dataType": "text", "description": "Copyright", "editable": true, "index": 7, "inputType": "text", "label": "Copyright and Year", "name": "Copyright", "defaultValue": "2021 MIT", "placeholder": "Copyright", "tooltip": "If you are an individual, creating original content, you are the copyright holder. If you are creating this course content on behalf of an organisation, the organisation may be the copyright holder. ", "renderingHints": {}, "required": false }, { "code": "license", "visible": true, "index": 8, "editable": true, "displayProperty": "Editable", "dataType": "text", "renderingHints": { "semanticColumnWidth": "six" } }\
] } } } } }'

```
 | 


### System capabilities (driven by configuration / data)


|  |  |  |  | 
|  --- |  --- |  --- |  --- | 
| Progress against blueprint | If blueprint is available, system will show automatically |  |  | 
| Print preview | If printable, system will show automatically |  |  | 
| Create Exam Questions > Add New Question | Disabled only for “Exam Questions” |  |  | 


### Expected user flow (Program process guide)


|  |  |  | 
|  --- |  --- |  --- | 
| Question Paper creation | Create > save draftEnsure relevant metadata is filledEnsure structure is signed-off before creating project |  | 
| Project creation | Skip two level review = ..Content type = Exam questions |  | 
| Exam Questions |  |  | 



*****

[[category.storage-team]] 
[[category.confluence]] 
```

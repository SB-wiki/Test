# SunbirdEd-Programs-Portal-for-Content-Contribution

DraftYellow _Watch out this space for more updates soon._

* [Program Portal for Crowdsourcing](sunbirded-programs-portal-for-content-contribution.md#program-portal-for-crowdsourcing)
  * [Program portal workflows](sunbirded-programs-portal-for-content-contribution.md#program-portal-workflows)
    * [Setup](sunbirded-programs-portal-for-content-contribution.md#setup)
    * [Contribution](sunbirded-programs-portal-for-content-contribution.md#contribution)
    * [Review](sunbirded-programs-portal-for-content-contribution.md#review)
    * [Publishing](sunbirded-programs-portal-for-content-contribution.md#publishing)
  * [Telemetry Requirements](sunbirded-programs-portal-for-content-contribution.md#telemetry-requirements)
  * [Non-Functional Requirements](sunbirded-programs-portal-for-content-contribution.md#non-functional-requirements)
  * [Impact on the products/solutions](sunbirded-programs-portal-for-content-contribution.md#impact-on-the-products/solutions)
  * [Impact on the existing users/data](sunbirded-programs-portal-for-content-contribution.md#impact-on-the-existing-users/data)
  * [Localisation requirements](sunbirded-programs-portal-for-content-contribution.md#localisation-requirements)
* [Relevant Jira tickets](sunbirded-programs-portal-for-content-contribution.md#relevant-jira-tickets)
* [Program Portal V1](sunbirded-programs-portal-for-content-contribution.md#program-portal-v1)
  * [Use case story](sunbirded-programs-portal-for-content-contribution.md#use-case-story)
    * [Teacher and Student Enablement](sunbirded-programs-portal-for-content-contribution.md#teacher-and-student-enablement)
    * [Teacher Training Creation](sunbirded-programs-portal-for-content-contribution.md#teacher-training-creation)
  * [Points to be covered](sunbirded-programs-portal-for-content-contribution.md#points-to-be-covered)

Program portal was built to experiment a new way to contribute, create, and curate content on SunbirdEd. It will be now merged with SunbirdEd to solve contribution needs of various programs such as [https://project-sunbird.atlassian.net/browse/SB-14888](https://project-sunbird.atlassian.net/browse/SB-14888)

## Program Portal for Crowdsourcing

In order to crowdsource content adopters can leverage program portal with the current set of tools. These tools allow crowdsourcing with a few salient capabilities

1. Users & Role Management: Configure this portal to allow contribution access by default to anyone who signs up
2. Textbook Driven Content Contribution: Guided contribution flow as per collection hierarchy
3. Supported Formats for Contribution: PDF, Video (MP4), and Questions
4. Report and Dashboard for Admin & Reviewer to monitor content coverage across textbooks

### Program portal workflows

There are following workflows involved in crowdsourcing programs

1. Setup
2. Textbook Creation & QR Code Management
3. Contribution
4. Review & Publishing
5. Monitor

Each of these workflows are detailed below. View all diagrams at once place [https://whimsical.com/EYnZdjNrSFzuHoumPp3G8f](https://whimsical.com/EYnZdjNrSFzuHoumPp3G8f) / [https://whimsical.com/3hvpEjPDP56hANbWF7cHL7](https://whimsical.com/3hvpEjPDP56hANbWF7cHL7)

#### Setup

Setup is to ensure that program portal is ready for contribution. It involves ensuring readiness of

1. Taxonomy framework: Adopter to check and ensure that taxonomy framework contains all the required fields viz. Board, Medium, Class, Subject, Concepts, Learning Objectives. Use implementation team’s services for this.
2. Textbook ToCs: Adopter should provide Textbook creation access to relevant users and ensure Textbooks are created with proper ToCs. Use Textbook editor on Sunbird for this.
3. Contribution portal creation: Launch an instance of contribution portal for your program with the help on implementation & support team
4. Open for Contribution: Once relevant Textbooks are ready with ToC, they need to be _opened for contribution_ . Use implementation team’s services for this.
5. Content type templates: As per the purpose of the program, select relevant content type templates. These will be available for contribution and eventually to the consumers
6. Role assignment: Share list of users to assigned Review, Report viewer, Textbook creator, Textbook reviewer, and other administrative roles.
7. QR codes: Once relevant Textbooks are ready with ToC, QR codes need to be generated and linked to these textbook units. Use Textbook editor on Sunbird for this.

Taxonomy frameworkTaxonomy framework should contain latest up-to-date values as per curriculum and also contain required values to enable search, discovery, content organisation, and data reports. Adopter should ensure latest up-to-date taxonomy with all required fields is uploaded on Sunbird. Following taxonomy services are available (with the help on implementation team)

1. Upload taxonomy as per taxonomy specifications. Sample file is available as an example
2. Read existing taxonomy in .csv spreadsheet format for verification

![](../../../../Design/sbdesign-lr-td-des2/images/storage)Textbook ToC & QR Code ![](../../../../Design/sbdesign-lr-td-des2/images/storage)

* Adopter would be required to define which all Textbooks are in the program scope.
* Those TBs should already be created in SunbirdEd instance.
* In case those are existing TBs for ETB purpose, adopter can share Textbook ID straight away however if adopter wishes to create a new TB exclusively for program purpose, it can create new ones and would further required to tag concepts.
* QR codes: Once relevant Textbooks are ready with ToC, QR codes need to be generated and linked to these textbook units. Use Textbook editor on Sunbird for this.
* Adopter need to share name and IDs of such textbook with support/implementation team.
* As per requirement such TBs shall be opened in program portal for contribution for chosen content type.
* For all the textbook units that need to be opened for contribution through programs portal, it is mandatory to link / tag them with a concept (using topic selector in textbook editor).
* Only Textbook units linked to a concept can accept contributions.

Contribution program portalLaunch an instance of contribution portal for your program with the help on implementation & support team. Share following details

• Program Name

• Program Admin User ID

• List of Textbook URLs

• Channel

• Board

• Medium

• Class(es)

• Subject(s)

Open for ContributionProgram Portal Admin should be able to view all draft textbooks from all users in the tenant, select textbooks to be opened for contribution. Also select specific units in a textbook to be opened for contribution.

Content type templatesContent templates ease up contributor’s job by providing preset values of content metadata. Content templates will contain following information ( _click below_ _section to expand_ )

Content template will contain.. (click here to expand)

1. Name
2. Thumbnail
3. Content description (if required)
4. Content Type
5. Resource Type
6. Audience
7. Creator / Author (Name of logged in user)
8. Configuration specific to each content type, such as list of question type, file format, etc.
9. Configuration related to metadata form, such as Learning Objective is multi-select & mandatory, Name is editable, etc.

A few examples are..

|   | **Content Type Template Name**                      | **File Format**   | **Additional Configuration**                                                                                                                                                                                | **Metadata Configuration**                                                                                                                                                                                                      |
| - | --------------------------------------------------- | ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1 | Lesson Plan                                         | PDF, Video        | None                                                                                                                                                                                                        | • Learning Objective / Outcome : Multi-select, Required• Content Name : Default “Lesson plan ”, editable, required• Author : Default “User Name”, editable, required                                                            |
| 2 | Explanation                                         | PDF, Video        | None                                                                                                                                                                                                        | • Learning Objective / Outcome : Multi-select, Required• Content Name : Default “Lesson plan ”, editable, required• Author : Default “User Name”, editable, required                                                            |
| 3 | Multiple Choice Question Practice Set               | QuML Question Set | • Allow only MCQ Questions to be added• Allow ‘Solutions’ to be added as well                                                                                                                               | • Learning Objective / Outcome : Single-select, required• Content Name : Default “Multiple Choice Question - ”, editable, required• Author : Default “User Name”, editable, required                                            |
| 4 | Subjective Question Practice Set                    | QuML Question Set | • Allow only Subjective / Reference Questions to be added• Allow ‘Solutions’ to be added as well _Category (VSA, SA, LA) of question is not important here. Users will edit Question set name as required._ | • Learning Objective / Outcome : Single-select, required• Content Name : Default “Subjective Question - ”, editable, required• Author : Default “User Name”, editable, required                                                 |
| 5 | PISA (Concept Based Learning) Practice Question Set | QuML Question Set | • Allow only Subjective / Reference Questions to be added• Disable adding ‘Solutions’ _Category (VSA, SA, LA) of question is not important here. Users will edit Question set name as required._            | • Learning Objective / Outcome : Multi-select, required• Content Name : Default “PISA Practice Questions - ”, editable, required• Author : Default “User Name”, editable, required• Additional PISA related attributes required |

Role assignment![](../../../../Design/sbdesign-lr-td-des2/images/storage)Program portal should support configuration of default role and enrolment type - open to anyone, open to tenant verified users, or invite only users. Apart from this all other roles will need to be defined, configured, and assigned to users as required.

#### Contribution

Contribution workflow demonstrates a contributor’s journey when contributing using crowdsourcing programs portal.

View designs here [https://invis.io/ZMU48UESHCF](https://invis.io/ZMU48UESHCF)

**Select Textbook > Select Chapter > Select Content Type template > Upload / Create & Save > Submit for Review**

Below is a workflow diagram with some sample content types

![](../../../../Design/sbdesign-lr-td-des2/images/storage) ![](../../../../Design/sbdesign-lr-td-des2/images/storage/image-20191122-054000.png)

Select TextbookEasily select textbooks to contribute to. Contributor / Reviewer will see textbooks listed in grid view and grouped by specific category (as applicable). User will also be able to filter textbooks / courses using any two of the taxonomy framework categories (e.g. Class, Subject)

Select Textbook UnitContributor / Reviewer will see important actionable statistics about selected chapter, see list of content contributed and take relevant action (contribute / add, edit, review). Allow contribution upto 4 levels of Textbook units.

Contributors will be able to View, Delete, and Move content from the list on this page. List of actions mapped to status of content is shown below

![](../../../../Design/sbdesign-lr-td-des2/images/storage)Content Type templatesContributor will select from available content type templates (as configured by admin). Appropriate tool with required configuration will be launched to make contributions. Contributors will be able to Save & Submit from the contribution page.

ContributionContributors can create Question Sets or Upload files. Following capabilities are required for contributors

Sign-in and default role

* Content contribution is open for all the public users having valid Google id. (This should also support additional configurations : Only for tenant verified users or specific users)

Textbook selection

* Once user sign in, it would be landed on a page with facility to select TB. TBs will be viewed in grid view. Contributor / Reviewer will see textbooks listed in grid view and grouped by specific category (as applicable).
* User will also be able to filter textbooks using any two of the taxonomy framework categories (e.g. Class, Subject)

Textbook details page

* Upon selecting a textbook user will be redirected to TB detail page.
  * TB detail page would have an option to select any particular chapter or all chapter from the drop down called “Select Chapters”.
  * User will also see the following numbers:
  * Total Contribution : All content linked to the textbook (all content types, all content states except retired)
  * My contribution : Contributions made by logged in user (all content types, all content states except retired)
  * Rejected : My contributions in rejected state
  * Under Review : My contributions under review
  * All the chapters should have accordion to expand its nodes.
  * User should be able to contribute both at chapter and node level.
  * User should be able to contribute up to 4 levels of TB.
* Once contributed, content should be shown under that node with status either of them:
  * Draft
  * Under Review
  * Published
  * Rejected
* For every contributed content there should be following options:
  * Preview (User can preview the content In all the stages)
  * Edit (Only for content which are either in draft or rejected state)
  * Move (Only for content which are either in draft or rejected state)
  * Delete (Only for content which are either in draft or rejected state)
* Upon clicking “Add”, User will choose what type of content to be contributed from a platter. (Content types to be contributed, have been already defined for the program by state)
* Depending upon the content type appropriate tool with required configuration will be launched to make contributions.
* Under contribution either user can upload a content (video, pdf) which she already has or user may choose to create a set of questions (for test prep program) corresponding to relevant node/chapter of the textbook.
* When a content is created it inherits / derives attributes such as Board, Medium, Class, Subject, License from textbook _and_ additional attributes such as Content name, icon, audience, resource type, content type, category, etc from Content type template.

License Terms:

* On contribution page, Creator should have options to select license value from a drop down. However by default state defined license should be auto selected.
  * MCQs created on program portal will take tenant license by default and no drop down required in this case. However on MCQ content detail page, following text should be there in the bottom:- _“By creating content on SunbirdEd, you consent to publish it under the Creative Commons License Framework <_ [https://creativecommons.org/licenses/](https://creativecommons.org/licenses/) _>.”_
  * In case of solution videos, again they should be tagged to default tenant license. In this case no need to provide other license values in drop down.
  * While uploading any content, after upload & before final submission (on submission page), user would be required to select the appropriate license term for the uploaded content.
  * By default tenant license value will be selected however if required user may choose other value from the drop down.
  * License field is mandatory and can not be left blank.
  * License drop down value must be fetched from SunbirdEd License Library
  * To start with following can be the drop down values:
  * CC BY-NC-SA 4.0
  * CC BY-NC 4.0
  * CC BY-SA 4.0
  * CC BY 4.0
  * There will be a static text on content submission page which would read following:

_“By creating content on SunbirdEd, you consent to publish it under the Creative Commons License Framework <_ [https://creativecommons.org/licenses/](https://creativecommons.org/licenses/) _>. Please choose the applicable creative commons license you wish to apply to your content”_

* On consumption side, The name and description text of the license selected during the creation of content is shown on content details page against License Terms attribute (both in portal and mobile): "<>: <>". There is no change in the UI design/layout as of now. The text will be wrap if it exceeds that current width of the field.
  * Name and description text of the license. Examples:
  * CC BY-NC-SA 4.0: This license is Creative Commons Attribution-NonCommercial-ShareAlike - [https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode)
  * CC BY-NC 4.0 : This license is Creative Common Attribution- Non Commercial - [https://creativecommons.org/licenses/by-nc/4.0/legalcode](https://creativecommons.org/licenses/by-nc/4.0/legalcode)
  * CC BY-SA 4.0: This license is Creative Commons Attribution-ShareAlike - [https://creativecommons.org/licenses/by-sa/4.0/legalcode](https://creativecommons.org/licenses/by-sa/4.0/legalcode)
  * CC BY4.0: This license is Creative Commons Attribution - [https://creativecommons.org/licenses/by/4.0/legalcode](https://creativecommons.org/licenses/by/4.0/legalcode)
  * Standard Youtube License: This is the standard license of any Youtube content
* In case of MCQs and Subjective questions, user should also have facility (“Add Solution” button) to provide solution (apart from question and options). However providing solution is optional.
* Solution can be either a “video” or “text+image” explanation, which user should be able to select from platter and should be facilitated to upload the same.
* While uploading a solution video user should be facilitated to search existing/already uploaded videos either on Diksha or on program portal. User should be able to use those videos, similar to Diskha portal.
* While uploading solution video/image, there should be following static license text in the bottom of the upload page:

“ _**I understand and confirm that all resources and assets created through the content editor or uploaded on the platform shall be available for free and public use without limitations on the platform (web portal, applications and any other end user interface that the platform would enable) and will be licensed under terms & conditions and policy guidelines of the platform. In doing so, the copyright and license of the original author is not infringed.**_ ”

Upload

* In case of content type (apart from question set) where file is being uploaded, a progress bar should be displayed to track the completion of file upload.
* When uploading file, relevant information such as file formats, file size, and link to ‘how-to’ resize videos, ‘how-to’ create videos should be provided.

| **Content Type**                                                                | **Helping Test To be Displayed on Contribution Screen**                                             |
| ------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Experiential, explanation content upload (wherever video or pdf being uploaded) | <ul><li>Following text should be placed near content name box - "Max-Char 2000 character"</li></ul> |

* Following text should be placed near upload file button - "Max size 50 MB"
* Following note should be placed before submit button: "Videos should be uploaded in MP4 format only. Refer link for - \[How to convert doc into pdf]\(https://kb.benchmarkemail.com/how-do-you-convert-a-word-document-to-a-pdf/) , \[How to convert video file to MP4]\(https://video.online-convert.com/convert-to-mp4), \[How to compress the MP4 file]\(https://www.youcompress.com/mp4/)"

\| | For lesson plan: |

* Following text should be placed near content name box - "Max-Char 2000 character"
* Following text should be placed near upload file button - "Max size 50 MB"
* Following note should be placed before submit button:
* "Lesson plan must be uploaded in pdf format only, refer link - \[How to convert doc into pdf]\(https://kb.benchmarkemail.com/how-do-you-convert-a-word-document-to-a-pdf/)"

|

* As long as uploaded content is in draft state, means has not been submitted for review, “Change file” option should be provided.
* However “change file” option should not be provided for content which are submitted for review or published.
* Contributors will be able to Save & Submit from the contribution page.
* Upon clicking on status, user shall be redirected to a page which would have content previewing window/ content player along with the reviewer’s comment.

#### Review

![](../../../../Design/sbdesign-lr-td-des2/images/storage) ![](../../../../Design/sbdesign-lr-td-des2/images/storage/image-20191122-054146.png)

Reviewer onboarding![](../../../../Design/sbdesign-lr-td-des2/images/storage)

* Content reviewer can be nominated either at the time of program onboarding or by admin at a later stage. Authorised reviewer will login to program portal.
* It is assumed that reviewer would be intimated the scope which she needs to review. Accordingly she will choose TB, Node and content type.

Review workflow details

* Reviewer would have the same TB UI experience as described for contributors. However reviewer would have the following two data points to look:
  * Total under review
  * Accepted by me
* Reviewer can also filter by School / Team if such a list was provided & configured during launch of the program. However if the list was not provided, this dropdown should be hidden from UI during onboarding as well as Reviewer’s view of Textbook details.
* Reviewer can approve or reject a content (video, pdf) by providing appropriate comment. Accordingly content shall either be published or rejected.
* Once published it would be available to be consumed.
* Upon publishing the content will be published independently as well as available to consume through the digital textbook (ETB).
* In case content is a question set (multiple questions), Reviewer would be facilitated to review each question individually.
* She can reject a particular question under a question set, can provide comment on each question separately and may go ahead to approve other questions and eventually the entire question set.
* While finally approving the question set, reviewer should be displayed a message box saying number of questions it has rejected and moving ahead with only approved once.
* Take reviewer’s confirmation by getting him clicked on “Continue” button.
* In that case published question set would have only approved questions.
* Rejected ones will be available to creator with comments.
* However creator would not be allowed to amend the rejected questions.
* On Publishing, content will be published and linked to the textbook.

#### Publishing

As of today, Review will publish to the textbook directly.

### Telemetry Requirements

* Basic telemetry parameters should be captured for each page: start, end, impression, interact, error
* For any page following should be captured : No. of users visited, time spent, feature accessed. Feature threw errors, success workflow completed
* For page load following should be captured: Response time for any page to load - limit may be 30 sec max, No. of page load requests, page load capture, page load error with time , page load success with time

### Non-Functional Requirements

* All API should give the relevant response code.
* NFR should be followed as per standard sunbird platform
* Program portal should support scale up and scale down feature (similar to Diksha). For reference : [https://project-sunbird.atlassian.net/browse/SB-15591](https://www.google.com/url?q=https://project-sunbird.atlassian.net/browse/SB-15591\&sa=D\&source=hangouts\&ust=1573895750648000\&usg=AFQjCNELxqmOXXq0zidjN25OjaBeUT5uVg)

### Impact on the products/solutions

* Anticipated Diksha integration under Workspace
* Impact is being taken care through dependencies

### Impact on the existing users/data

NA

### Localisation requirements

NA

## Relevant Jira tickets

[System JIRA](https://browse/) _**Ignore below section for now! - Rough notes**_

## Program Portal V1

### Use case story

A SunbirdEd adopter / tenant would like to design & implement a program to achieve certain outcomes. In order to achieve the outcomes, the SunbirdEd tenant will need to consider creation, consumption, and data requirements.

1. Teacher & Student Enablement Creation
2. Test Prep Creation & Consumption
3. Teacher Training Creation

#### Teacher and Student Enablement

Content Types & Book StructureIntent was to enable teachers & students by providing access to various teaching and learning resources organised by each chapter in the textbook. Types of resources to enable students and teachers were finalised based on availability & ease of use. These content types were organised for each chapter in the textbook.

Click here to view Textbook structure

* Chapter 1 \[ _Textbook unit_ ]
  * Explanation Content \[ _Textbook unit_ ]
  * Explanation Content 1 \[video / pdf]
  * Explanation Content 2 \[video / pdf]
  * Question Bank \[ _Textbook unit_ ]
  * Multiple Choice Question Practice Set
  * Very Short Answer Practice Set
  * Short Answer Practice Set
  * Long Answer Practice Set
  * Experiential Content \[ _Textbook unit_ ]
  * Experiential Content 1 \[video / pdf]
  * Experiential Content 2 \[video / pdf]
  * Lesson Plan \[ _Textbook unit_ ]
  * Lesson Plan 1 \[video / pdf]
  * Lesson Plan 2 \[video / pdf]
  * Focus Spots \[ _Textbook unit_ ]
  * Focus Spot
  * Learning Outcomes \[ _Textbook unit_ ]
  * Learning Outcome
* Chapter 2 \[ _Textbook unit_ ]
* ..
* Chapter n \[ _Textbook unit_ ]

For each content type

Program user journeys

* Discover (view & access) Program
* Program Details
* Join or Leave Program
* Program Setup and Launch
* Close Program
* Program Analytics

#### Teacher Training Creation

Proposed workflow:

![](<../../../../Design/sbdesign-lr-td-des2/images/storage/Course Creation Workflow.png>)

ArchitectureProgram Definition - Purpose and scope of the program.

* Purpose - Text
* Scope - machine understandable or free text?
* Type - Public, Sign up, invite-only
* Tenant - Root Org
* Framework -

Roles in a program -

* Program admin defines the user roles for the program.
* Maps the program roles to actions in a tool.
* Defines the default role assigned in a program

Setup Activities - Program is a collection of activities. An activity is a tool + actions + config.

* Example tools -
  * QuML Practice Set tool - create QuML questions and bundle them into practice sets against a textbook TOC.
  *

### Points to be covered

Context/Background

Business Flows

* State & System Actions - multiple phases
* Sample Use cases
  * Teacher & Student Enablement
  * Test Prep
  * TPD
* Process, Product and Content
* Creation, Consumption and Data

Architecture

* Experiment vs Program
  * Experiment - driven by us, Program - driven by state
  * Experiment - to test a feature variation, may be flaky
  * Programs are mainly used for scoping and tracking of the activities
* Core feature vs Program
  * Available to all users vs custom experience for a content type / program
  * ..
* Conceptual Model
  * Program - Types??, Definition: Scope, Activity \~ (Tool, Actions, Config)
  * Users, Teams, Roles - on boarding, setup
  * Default Programs - e.g. workspace, consumption for a content type
* High Level Design
  * Program Entity structure
  * Structure of Tools - Angular components, dynamic loading
  * Program Configuration
* Deployment Model
* Delivery Channels
  * Portal
  * Mobile App

Roadmap

***

\[\[category.storage-team]] \[\[category.confluence]]

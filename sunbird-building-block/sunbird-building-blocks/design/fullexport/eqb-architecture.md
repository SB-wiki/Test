# Background

**Problem** : Questions are fundamental to learning -- both in terms of assessing learner's progress as well as in terms of generating curiosity. Boards like CBSE have repository of questions, which are so far accessible to just the affiliated schools and a select few, and in a closed system. How can we open up these assets to all, and provide value added services on the top.&#x20;

Energized Question Bank (EQB) envisions to have a repository of questions and related data, make them available to different applications, offer value added services to Teachers, Parents, and Learners, among other concerned stakeholder in the educational ecosystem.

It amounts to treating Question as a first class citizen in the platform, and develop services around it.&#x20;

**Sample UseCase** : In a Textbook, for each chapter, create a packet containing one mark and five mark questions that have appeared in previous exams, and link them to the chapter. This will allow learners to prepare for exams in a targeted fashion - a digital twin of a guide book available in the market.

**Few Definitions:**

1. **Question:** A question is a measuring construct used to assess the learning outcome of a learner. In simple terms, a question is what is given to a student for the purpose of assessing a student's proficiency in a concept. Example: Explain the benefits of ground water recharging?
2. \*\*Question Set: \*\* A question set a collection of questions having a certain common characteristic. That common characteristic is  defined in terms of the question meta data. Example: set of all questions having one mark.
3. \*\*Question Paper: \*\* It is an array (collection) of Question Sets, where additional conditions/restrictions are placed at the individual member  Question Sets. For example, give ten, 1 mark questions, followed by 5 five mark questions, which all must have appeared in exams.&#x20;
4. **Answer** : A workout, in sufficient details, that satisfies what is asked. In simple terms, it is what a student provides in response to a question. It could just be a correct option in a Multiple Choice Question (MCQ), a single word or a phrase in the Fill-In-The-Blank (FTB) Question, a 150 word essay in a creative writing question.
5. **Marking Scheme** : A Marking Scheme is a set of hints or key points, along with grading scheme, that an evaluator looks for when grading assessments. Primarily, Marking Scheme is meant for a teacher (evaluator) and not a student.&#x20;

**Ingestion Flow :**

1. **Extraction Phase** -  _Convert Unstructured data to Structured data_ \*\*:  \*\* Questions, Answers, Marking Schemes, Meta Data could be available in different forms such as a PDFs, Word Documents, Scanned PDFs, possibly even in databases. Ingest all such (unstructured) data, and extract relevant data and write that data against a specific suitable QML compliant schema. Extracting the data as per the schema, may be human generated or algorithm derived. Source data is now ingested into the platform, and is ready for auto-curation (validation).
2. **Auto Curation (Pre-Validation) -** \_ Generate Quality Metadata of the  Extracted data\_ \*\*. \*\* Some or part of the the extracted data may require validation by an SME. However, validating every and all extracted data might be too cumbersome for a human in the loop. In this phase, additional machine derived quality meta data will be used to prioritize the effort required by the human in the loop.
3. **Curation (Validation) -** _Validate Extracted data_ \*\*. \*\* An expert or a designated curator can validate the extracted data, and change the status of the extracted data into one of the three states: accepted (ready for publishing), modified (and ready for publishing) and rejected (not suitable for publishing). At the end of this phase, extracted data is curated, and the publishable data now is available for downstream consumption.&#x20;
4. **Ingestion -** _Ingest the curated data_ **.** Once data is in a published form, write it to a DB like Cassandra

Note: If we choose to bypass auto curation phase, we might still show all questions in draft mode. It is a policy decision then.

**Question Set Creation Flow:**

1. **Specify the Intent of the question set:**  The purpose of the question set creation will be concretized by filling the query fields. In effect, Intent is nothing but a query against the question bank with agreed upon meta data. Several predefined purpose templates will be given. A user can select an existing one.
2. **Edit the Intent:** A concretized query  can be edited (UI component)
3. \*\*Submit the intent: \*\* Fire the query
4. **Edit the responses:** Accept or Reject the items in the result set at item level or set level

**Question Paper Creation Flow:**

1. Same as question set creation flow, except that additional intent fields are required. For example, give 10% weight to Chapter one, and they should go to Section A of the Exam Set.

**Assigning Question Sets to Textbook Flow**

Pre-requisites: Assume that Textbook Framework and Question Meta Data are aligned at the Taxonomy level. In addition, two data points are required to create an Energized Question Bank: 1) Textbook Spine 2) Question Set Logic (Blueprint, as it is called from now on). Once these two pieces are available, a Textbook can be created with links to Question Sets.&#x20;

**Different** entry points can be enabled to create Textbooks that are linked with Question Sets. Few are suggested below.

1. **Automated Textbook Creation** :
   1. Provide Textbook Spine as a CSV or create these spines for every Framework available in the platform. Textbook Spines can be created via APIs or via Portal UI
   2. Provide a list of available Pre-baked Question Set Intent Blueprints.
   3. For every entry in the Spine, and the preselected list of Blueprints, fire the query, get the question sets, create the resources, and link them&#x20;
   4. Once an energized question bank is created, a user can edit it.
2. **Semi Automated** :  A Sunbird Adoption Team can create Textbook via APIs or portal UI. From backend, EQB can be auto created, made available for editing. A simple UI component can be developed to edit the Intent configuration and select, deselect the items in the result set

**Schema and Architecture Details:**

**Overall System Level View**

![](<../../../../Design/FullExport/images/storage/EQB Systems View.png>)

**CureIt: Ingestion Pipeline**

![](<../../../../Design/FullExport/images/storage/EQB Source to Curation.png>)

**CureIt : Behavior**

1. Schema is defined for the source type (dimensions are specified)
2. Information is extracted against the "meaning" of the dimension. Example: "difficulty" is a dimension of the question. It needs to be extracted if not available in an consumable form
3. By default, all dimensions are in  _draft_ state.&#x20;
4. During pre-validation phase, a set of rules (specified by a human or learnt by the system) are applied, which are helpful in validating the extraction step. For example:
   1. If a dimension is filled by machine, confidence score is a derived score which can be used to prioritize tasks for a human-in-the-loop
   2. We suspect that the image presented in the question is not legible or crossed the boundaries, but there is no easy way to fix it. Present the image to human in the loop and ask whether it is presentable or not.
   3. We (system) may think that one Marking Scheme is suitable for presentation as an Answer. Let the human in the loop validate it.
5. Human-in-the-loop, prioritizes the validation tasks based on "interest". A Maths teacher can only select  Maths questions and only provide Answers.&#x20;
   1. Different kinds of reviewers can focus on specific tasks (of the validation). Not everybody needs to do everything
6. &#x20;Eventually, every record moves from a draft state to either draft or published or reject state
   1. Every individual dimension also goes through the same states except that unlike at record level, individual dimension can only be either published or rejected state

**CureIt: EQB Specifics**

1. Question Metadata
   1. from CBSE hard disk: subject, medium, grade, difficulty, blooms level, question type, marks, marking scheme, answer
   2. Sunbird Taxonomy map: topic, subtopic
   3. additional:&#x20;
2. Question Data
   1. urls: question image, marking scheme image, bundle \[\[pdf, png|pdf,-png]].&#x20;
   2. Question and Answer word docs will be converted to html, and to QML.
3. Validation Meta Data (high is better, low requires attention)
   1. needs cropping
   2. needs answer
   3. marking scheme can be graduated to answer
   4. ...

**SetIt** **: Ingestion Pipeline**

**SetIt: Behavior**

1. Taxonomy terms, such as a Medium, Grade, Subject, Topic, Subtopic are chosen
2. The purpose of the question is set is specified in terms of the attributes of the Question such as a Marks, Blooms level, Difficulty etc..
3. A Query is formed with the above, and fired against the DB. Result are given back to the user

**SetIt: Interface**

1. _Taxonomy Terms_ can be specified via multiple entry points
   1. Sunbird Adoption team can create Textbook Spine
   2. via CSV&#x20;
2. _Question Set Purpose_ is exposed via a JSON configuration. They can be provided in multiple ways
   1. Several Blueprints are provided with pre-filled values.&#x20;
   2. The JSON data can be seen via a custom UI in new Portal as is
   3. A User can edit the JSON data UI in case he/she wants to customize it
3. _The Results_ of the query can be edited by the User. This allows full customization.
   1. Bulk Accept
   2. Reject individual items
   3. Add individual items (so that query can be modified, new results are fetched and interesting items are added to the collection)

**TBD**

1. telemetry event structures (during curation)
   1. to better the auto curation process
2. telemetry event structures (during set acceptance/modification)
   1. to better query fulfilment
3. intent specification schema
   1. similar to Plug-n-Play analytics JSON-ified filtering criteria

***

\[\[category.storage-team]] \[\[category.confluence]]

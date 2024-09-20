# Overview-

Refactor Flow - (Single Sourcing portal for Project and Collection creation) and (Question Creation and Review in QuML 1.0) will allow users to create exam question papers with the new flow.

As part of Refactor, questions will now be created under Target collection type as "Exam Question Set".

In order to replicate the end-to-end use case of exam question papers, Print Program service will also need to be enabled as part of Refactor flow for Question Set Target Collection.

Hence, Print Preview Service needs to be developed such that the sourcing reviewers are able to download the list of Approved Questions as print docx file.

**Tech Implementation Approach-**

1. Get question sets from collection id from below API.

* {baseURL}/api/questionset/v1/hierarchy/{id}&#x20;

2. Read all approved questions from the API below.

\-{baseURL}/api/question/v1/read/{id}&#x20;

3. Repeat step 2 for all approved questions and prepare the final input for docx creation.
4. Get all required values(editorstate, body, marks) from the previous step.

* Editor state
* Body
* Marks
* Grade
* Medium
* Subject&#x20;

5. Prepare JSON for docx file Input(stylings) and generate the doc file

* Headers (styling)
* Instructions (styling)
* alignments
* Tables
* Sections

6. Cover all previous Docx scenarios with the new Docx(1.0) flow.
7. The Docx File should be compatible in all windows versions.

***

\[\[category.storage-team]] \[\[category.confluence]]

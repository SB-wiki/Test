 **Overview:** 

The objective of this document is to capture the complete requirements of the Prashnavali. This will be the single source of truth for tracking all the requirements and their statuses.

 **Actors/Users in Prashnavali:** 



|  **Actor**  |  **Action**  |  **Portal**  | 
|  --- |  --- |  --- | 
| Admin | Project Setup and Management (including roles management) | Diksha-web, Vidyadaan | 
| Contributor | Add questions (teachers or 3rd party vendors) | Vidyadaan (contribute) | 
| Question reviewer | Review each question (Subject matter experts) | Vidyadaan (contribute) | 
| Question paper creator | Create final question paper, choosing from approved list of questions | Vidyadaan (sourcing) | 
| Teachers | Search Question bank, Select questions and create a paper  | Diksha App, Diksha Web | 



 **Steps involved:** 

The following table lists out all the steps that are to be taken in the complete life cycle of a question paper and question bank. This is indicated at a higher level. Later in the document, a separate section for each of the category items will further detail.



|  **Category**  |  **Actions**  |  **Stauts**  | 
|  --- |  --- |  --- | 
| Project Creation | Create a new collection  |  | 
|  | Create and manage project | 
1. Single window transaction (Sunbird team, 3.9?)



 | 
|  | Role management |  | 
|  | Blueprint  | 
1. Provision to edit after publishing project (3.9)


1. Generic blueprint definition (later)



 | 
| Question contribution | New content type - Exam question |  | 
|  | Type of questions |  | 
|  | Tags for a question |  | 
|  | CK Editor enhancements | 
1. Include plugin for symbols (3.9)


1. Include plugin for image resize (3.9)


1. Inline image support (later)



 | 
| Question review | List of all contributed questions | 
1. Show tags of the question as chips (3.9)



 | 
|  | Single review (Accept/ Request edits) |  | 
| Question Paper Creation | List of all approved questions | 
1. Show tags of the question as chips (3.9)



 | 
|  | Progress against blueprint |  | 
|  | Print  | 
1. Support image (3.8)


1. Define template for tenant (3.9)


1. Select template at project level (3.9)



 | 
| Question Bank | Contribute, access questions  | [[Question Bank|Question-Bank]] <To be planned> (3.9) | 
| Analytics and Reports | Dashboard for Admin | <To be planned> (later) | 

 **Pending development items (priority and development roadmap)** 



|  **Category**  |  **Overview**  |  **Priority**  |  **Development Cycle**  | 
|  --- |  --- |  --- |  --- | 
| Refactor | Upgrade to new QuML editor | P1 | 3.9 | 
| Project Mangement | Single console to manage project | P3 | - | 
| Edit: Question set definiton | P3 | - | 
| Edit: Blueprint definition | P3 | - | 
| Edit: Question (by reviewer, who is not author) | P2 | - | 
| Question Contribution | Enable Math Symbols | P1 | 3.9 | 
|  | Enable resize of images | P1 | 3.9 | 
|  | Adding text and Image in same line | P1 | 3.9 | 
| Question review | View question tags as chips in list view | P4 | - | 
| Question Paper Creator (Sourcing reviewer) | View question tags as chips in list view | P4 | - | 
|  | Change a rejected question to Accepted | P3 | - | 
|  | Auto - Generate Question Paper | P4 | - | 
| Print | Support for comprehension | P1 (critical) | 3.9 | 
|  | Support for images | P1 (Critical) | 3.9 | 
|  | Template for question paper | P2 | 3.10 | 
| Question Bank | One question bank which all the teachers have access | P3 | - | 
| Generic Blueprint definition |  | P3 | - | 
| Bulk upload questions |  | P3 | - | 
| Bulk download in csv |  | P3 | - | 
| Tag a question as duplicate |  | P4 | - | 
| Analytics and Reports |  | P4 | - | 



 **Items for 3.9 in order of priority:** 



|  **Category**  |  **Overview**  |  **Priority**  |  **Development Cycle**  |  **Task Size**  | 
|  --- |  --- |  --- |  --- |  --- | 
| Print | [Support for comprehension](https://project-sunbird.atlassian.net/browse/SB-23979) | P1 (critical) | 3.9 | S | 
| Print | [Support for images](https://project-sunbird.atlassian.net/browse/SB-23980) | P1 (Critical) | 3.9 | L | 
| Question Contribution | [Enable Math Symbols](https://project-sunbird.atlassian.net/browse/SB-23781) | P1 | 3.9 | S | 
| Question Contribution | [Enable resize of images](https://project-sunbird.atlassian.net/browse/SB-23781) | P1 | 3.9 | S | 
| Question Contribution | [[Adding text and Image in same line|Inline-image-support-in-the-Question-editor]] | P1 | 3.9 | L | 
| Refactor  (Planning in 3.9) | [[QuML Editor Upgrade|QuML-Editor-Upgrade]] *****  | P1 | 3.10 | XXL | 
| Print (Planning in 3.9) | Template for question paper | P2 | 3.10 | L | 

 ***Upgrade to new QuML editor** 

As there is a new definition of the QuML editor, we need to upgrade all our contributions of 3.7 and 3.8 to the new object definition.





*****

[[category.storage-team]] 
[[category.confluence]] 

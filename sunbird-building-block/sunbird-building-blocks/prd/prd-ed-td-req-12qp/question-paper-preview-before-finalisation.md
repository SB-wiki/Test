# Question-Paper-Preview-Before-Finalisation

\*\*Functionality: \*\*

An admin is able to duplicate an already created question set within a project and make the required edits

**Challenges in the current solution flow:**

In the current flow, each question undergoes the following steps:-&#x20;

![](../../../../PRD/prd-ed-td-req-12qp/images/storage/u5\_ggJle3d3l4nYFTNvkyrMdr\_VcxRvxbFqh01MTV6AE3igmKMDspZJNK8ixgYA4fK-4KDHjVaNAy6jkt\_juzHGyCRaLi0-YVaqUju0yE8KOiGaO3JR7QmWge3oo7mNT512y3Pfu0OevKonJ1q4)

In the third stage, where a question is getting selected to be added in a question paper a preview of the list of questions is not available at one place. This creates an issue for the question paper creator as he/she is unable to gauge two things:-

1. Will I be able to select at-least the required number of questions to be added in the question paper ?
2. Will I be able to get the best questions out of the reviewed questions added in the question paper ?

The reason why these questions remain unanswered for the question paper creator are two fold:-

1. The question paper creator is unable to get a single window view of the lot of questions that have been reviewed on the contribution portal, so he/she cannot make the judgement whether making an effort to review each question individually would result in getting the required number of questions.
2. To select (Approve/Reject) each individual question, the question paper creator has to click on the question card from the list view of questions, go through all the details of that question (body of the question, correct answer & relevant tags) & decide whether that particular question can be selected to the question paper, without knowing if better questions are available or if the required number of questions have already been selected.

**Functional solution:**

Enable a preview for the question paper creator on the sourcing portal, of all the questions accepted from the review that has happened on the contribution portal.

The proposed solution is:-

1. Open sourcing portal
2. Go to ‘My Projects’
3. Open the desired project
4. Open the desired question set
5. The current ‘Print Preview’ button will be replaced by ‘Print/Preview’
6. Click the button ‘Print/Preview’
7. Three options are shown:-
   1. Print Document ( _Only Finalised questions_ )
   2. Print CSV ( _Only Finalised questions_ )
   3. Preview Questions ( _All questions_ )
8. Click ‘Preview Questions’&#x20;
9. A form opens which shows all the questions (with options in case of an MCQ question)&#x20;
   1. All questions open up based on serial numbers
   2. Current status of each question is mentioned under the question statement
   3. Answers for questions are NOT displayed in this form

[Slide 18-21](https://docs.google.com/presentation/d/13\_KfHUE53\_jqaGS6WBpDactC4b9KK7UT/edit#slide=id.p8) attached for wireframes of the solution

**Technical Solution:**

**Enable preview button**

* We’ll use category definition to store isPreviewEnable which will enable the preview button

**Render Questions**

* We’ll lazy load the question using /api/question/v1/list API
* Questions will be rendered using innerHtml

***

\[\[category.storage-team]] \[\[category.confluence]]

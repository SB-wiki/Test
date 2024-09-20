# Question-Set-Duplication

\*\*Functionality: \*\*

An admin is able to duplicate an already created question set within a project and make the required edits

**Challenges in the current solution flow:**

Creation of the question set requires the admin to enter values for the following xx fields:-

_Name, Description, Keywords, Instructions, Board, Medium, Grade, Subject, Audience, Visibility_

Apart from this, the admin has to add at least 1 child where he/she has to enter values for the following 3 fields:-

_Name, Description, Keywords_

Above mentioned are the bare minimum that an admin has to do to create a single question set. Now, based on the current/ongoing use cases it has been found that the number of question sets for some projects range from 15 to 30+. For eg:- Chapter worksheets or HOTS Question Bank development are ongoing projects in Haryana state.

In a particular HOTS Question Bank Project ( Name:- ‘ HOTS Question Library: Grade 7: Hindi ‘ ) there are **33 Question sets** (one for each chapter in Grade 7: Hindi), for which the admin has to individually create 33 question sets wherein all the fields except ‘Name’ of the question set is exactly the same.&#x20;

Hence, to make the flow more user friendly, a duplicate question set option should be available at each question set which saves time & effort of the admin in manual tasks.

**Functional solution:**

Enable a duplicate question set functionality while creating question sets within a project.

The proposed solution is to :-

1. Add a button in front of each question set which enables the user to duplicate that question set.
2. All fields of the question set get duplicated and a new question set gets created

_Note: The blueprint of the question set is not duplicated_

1. On clicking ‘Edit Question set’ the user/admin has the option to edit all the fields of the question set & the subsequent child sections (same as while creating a new question set)

Slide [7-17](https://docs.google.com/presentation/d/13\_KfHUE53\_jqaGS6WBpDactC4b9KK7UT/edit#slide=id.g13681ada685\_0\_9) attached for wireframes of the solution

**Technical solution:**

On pressing duplicate, we’ll take the question-set data and pass it to create API

**APIs:**

* questionset/v1/create : to create question-set
* questionset/v1/hierarchy/update : to add question-set in hierarchy

***

\[\[category.storage-team]] \[\[category.confluence]]

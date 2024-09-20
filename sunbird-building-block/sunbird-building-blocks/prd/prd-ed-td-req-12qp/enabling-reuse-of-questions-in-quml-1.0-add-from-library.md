# Enabling-Reuse-of-Questions-in-QuML-1.0-(Add-from-library)

### Functional use case

#### Overview

The SCERT wants to create a repository of reviewed questions in a question bank. (State has already digitized 5,000+ questions). These questions may be added under collections with public or private visibility. The quantum of questions contributed will keep on increasing on an ongoing basis.

Going forward, when the state wants to create a practice question set/worksheet → They want to use the functionality to search and filter from the question bank/library and directly add.

**This feature will be present in addition to the Create new feature in the Refactor flow.**

#### Functional use case flows:

Usage of question added in question library:

1. For creating a target collection whose visibility is set as -

* Public - Eg - A worksheet, practice question set, practice quiz or
*   Private - Eg - Exam paper,

    The contributor can choose to add a question from the library → Apply filters of BMG + Subject + Topic + LO and select one or more questions and add to the exam question set.

2. List of questions that should be visible in the Question Library are -

* **Visibility of target collection - Public**
* **Status of questions under target collection - Published/Approval Pending (approved by contribution reviewer)**

3. **List of Filters in Add from Library -**

* Hidden filters - Visibility (Public prefilled), Target collection (Exam Question Set prefilled)
* Default filters - Content Type, Board, Medium, Grade, Subject
* Visible filters - User to select - Chapter, Competency (framework attributes)

3. Once Add from Library question is selected, the questions will go to the sourcing reviewer for Acceptance or rejection in the final question set

&#x20;

### Product flow

#### Creation of Exam Question Set Collection

1. A new question set of the target collection - “Exam Question Set” is created
   1. Visibility of this is set as public.
   2. Single level review is enabled
   3. Nominations are turned off
   4. Different asset types - MCQ, Subjective are selected for the collection
2. All the contributors and reviewers are added to the question paper
   1. Any new contributor, either SCERT or a Vendor is added to the question library project
   2. SCERT adds the reviewers (Either Subject matter experts) or others to review the question

**Collection** :

**Filters** : Content type, Board, Medium, Class, Subject, Chapter and Learning outcome

**Question** : We don't have any content type so we'll hide the content type filter.

**Filters** : Board, Medium, Class, Subject, Chapter, and Learning outcome will be the filter

**Open Questions -**

1. How to embedd QuML 1.0 content player in Add from Library?
2. How to enable hidden and default filters in Add from Library (make it tenant specific)?

***

\[\[category.storage-team]] \[\[category.confluence]]

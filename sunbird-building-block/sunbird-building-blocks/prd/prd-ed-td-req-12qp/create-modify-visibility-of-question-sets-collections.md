# Create-Modify-Visibility-of-Question-Sets-Collections

#### Creation of a project:

#### The admin creates a project on VDN with category as “Exam Question Set” of object type question sets and target content as question types

1. Default - Visibility value for the question set is set as ‘Private’. Admin can choose to edit and directly create a project that is public paper (e.g. - practice paper, Question bank/library).
   * In the case of other collections, the default value can be set as public, which can be edited by the admin.
2. A single project can have multiple collections/question sets. The visibility parameter for each of the collection/ question set can be differently set.
3. Admin Publishes the project.

#### Creation of content/asset within private collection/question set

1. All the new questions/content created new within the question set/collection will have the visibility inherited from its parent
2. Adding an existing question/content from the library → All the questions that are ‘Public’ will be shown in the search result when the admin adds a question from the library.
   * A public content/question can be made part of a private collection/question set.
3. If a content/question is private it will not get listed in the Add from Library

#### Viewing and editing of Visibility

1.  After the project is created, in the project details list view → where all the question sets are listed and shown. The visibility parameter for each of the question set is shown to the user.

    In-case of private ( a private tag is shown), in case of public nothing is shown. On mouse hover on the name of the project (visibility value is shown)
2. At any point, the admin will have the provision to edit visibility from private to public

#### Conversion of Question set/Collection from Private to Public

Case1: A question set/collection that is still in draft mode on VDN.

How to:

1. On VDN → Admin goes to the project, sees the list of question sets/collections, and converts a collection/question set from private to public

Impact:

1. The question set/collection and all the questions/content created under it are now made public.
2. The questions will start showing in the Add from library search

Case2: A question set/collection that is published on Diksha as private

How to:

1. On VDN → Admin goes to the project, sees the list of question sets/collections, and converts a collection/question set from private to public

Impact:

1. The question set/collection and all the questions/content created under it are now made public.
2. The questions will start showing in the Add from library search
3. On Diksha, the question set/collection will become searchable and visible (under the Others tab) and via the public URL of the resource.

#### Conversion of Question set/Collection from Public to Private \[Out of Scope]

Case1: A question set/collection that is still in draft mode on VDN.

How to:

1. On VDN → Admin goes to the project, sees the list of question sets/collections, and converts a collection/question set from public to private

Impact:

1. The question set/collection is now made private
2. When the question set/collection will be published to Diksha it will be published as private
3. New questions/content that will be added will inherit the visibility of private
4. All the existing questions/content which were added as the public will remain to do so.
5. In add from library, → All the public questions will show up, while the private ones will not show up

Case2: A question set/collection that is published on Diksha as public

How to:

1. On VDN → Admin goes to the project, sees the list of question sets/collections, and converts a collection/question set from public to private.

Impact:

1. The question set/collection is now made private
2. The question set/collection will no longer be visible On Diksha publicly.
3. All the questions/content within the question set/collection remain to be public
   1. While doing Add from the library the questions are visible to be searched and re-used
   2. If a question is already re-used in another question set/collection they remain to retain their public visibility
4.  On Diksha, the questions will become searchable and visible (under the Others tab) and via the public URL of the resource.

    However the question set will cease to be visible.

Mockups of Enabling Modification of Visiblity of a Question Set on the UI -

(Refer to **Slides 22, 23, then 75-80)**

[https://docs.google.com/presentation/d/12JW58Iokn-3IdwifUeWab8F8vPC8HFHqZjkbERtwsLc/edit#slide=id.ge71b9a585c\_0\_46](https://docs.google.com/presentation/d/12JW58Iokn-3IdwifUeWab8F8vPC8HFHqZjkbERtwsLc/edit#slide=id.ge71b9a585c\_0\_46)

**Fetching Question sets and questions from DIKSHA to External Apps through filters -**

* Once question sets are published on DIKSHA, there would need to be some search filters based on which question sets should be fetched by external apps.
* Search filters can be defined from the Question Set and Question metadata -
* Question Set Metadata -

1. Primary Category, Board, Medium, Grade, Subject, Target Audience, _Visibility_

The 2 problem statements are -

1. **Providing access of DIKSHA Question Sets to External State Applications (Avsar, E-Samwad etc)**
2. **Updating visibility status of question sets and questions from private to public**

**Tech Implementation Design -**

**Approach 1 -**

* Org admin will get an option to publish a QuestionSet/Question to DIKSHA in “Private mode”.
* In private mode questionset/question are not searchable through normal search APIs.
* To access questionset/question we will use “Private Search APIs”
* Once the exam is over the org admin can republish the questionset/question from Vidyadaan and it will update the status to “Public”.

**Sharing of Question Sets with External App** :

* There will be a questionset ID in a mobile app and using this id we can request the question list details using the private search APIs.&#x20;
* These APIs need authentication so we will hardcode the auth token and organization id in our mobile App.

**Tasks:**

* Add the Import button in the project to publish content.
  1. _**Need to check whether questions get published in private mode.**_

**Approach 2 - Unlisted Publishing of Question Sets**

Org admin will get an option to publish a questionset/question to DIKSHA in unlisted mode. In this mode the questionset/question will not be visible in any search APIs, it can only be discoverable through it’s do\_id.

Other external Apps already have these Id’s so they can directly call the question detail API using the do\_id to get all the details.

Once the exam is over the org admin can republish the questionset/question from vidyadaan and it will update the status to “public”, now the content is available for search and reuse using add from library option.

**Tasks:**

* Add unlist publish support in the existing import API if it is not there.
* Add the Import button along with the option to publish it as unlist/public in the project.

**Issue in this approach**

* Anyone can extract the token from the app and use all APIs externally.

**Show Questions in the mobile App:**

We’ll show

**Getting Publish Project/Content Ids to external servers:**

The user will enter the webhook URL while publishing the Questionset/Question to DIKSHA.

Once the questionset/question will be published to Diksha it will send this information to the webhook URL with the following data.

```
{
    "type": "QuestionSet",
    "identifier": "do_someid",
    "board": "CBSE",
    "grade": "class 6",
    "medium": "english"
}
```

**Process to show private content on VDN**

Currently, we are getting data from “ **action/composite/v3/search”** search API.

**Problem Statement** : Composite search API will not return a private question-set, resulting in not being able to view question-set in the program list.

**Solution** : We will use **/v3/private/search** API to get question-sets.

**When to use private search** : If program collections length is not equal to composite search length then we’ll use private API to get content.

Following API will be used to show private content:

Private Search: **/v3/private/search**

Above API list all the private questionset

Hierarchy Read: / **api/questionset/v1/hierarchy/do\_id**

Above API will be used in both cases

Question Read: **/api/question/v1/read/do\_id**

Above API will be used in both cases

What will happen in the following scenario:

If the question--set status is **private** and the question status is **Default,** will the question is available publically or not?

***

\[\[category.storage-team]] \[\[category.confluence]]

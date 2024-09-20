
# Overview
This document details the functional specifications about how the versioning should work with respect to the textbooks and their linked content. 

Textbooks and content have their own independent life cycles. Each go through the phases of draft->review->live in their life-cycle. Hence it becomes very important to detail out the behavior of how the two co-exist. For example, if a content linked to one or more textbooks undergoes a change, how should it get reflected in the textbooks to which it is linked has to be clearly defined. This document details the functional specifications of this behavior.

Through out this document, the word “content” refers to any content type that can be linked to a textbook. This includes a generic resource (Resource) or any specific resources like ExplanationResource, PracticeResource, LessonPlan, LearningOutcomes. It also includes a generic collection.


# Life Cycle and Versions of a Textbook/Content 
A textbook or content have a similar life cycle as described below:

 **Does not exist**  --->  **Draft (v1)**  ---->  **Review (v1)**  ---->  **Live (v1)** 

Once a textbook or content becomes Live, a Draft version can be created from it, but it is a new version. In this case both the versions (Live and Draft) exist in the system.

 **Live (v1) +Draft (v2)** 

Now the content will go through the follow life cycle:

 **Live (v1) +Draft (v2)**  --->  **Live (v1) +Review (v2)** --->  **Live (v2)** 

Once a draft version of a content becomes live, the previous live version will automatically get removed from the system. 

Any version of a content in any state can also be deleted. Once deleted the content goes to  **Retired**  state.


# Life Cycle and Versioning Behavior for Textbooks linked to Content
Following diagram depicts various life cycle transitions of Textbooks and content linked to it:

[https://drive.google.com/file/d/1Gb1Wbrn6kNNvuDmoVloDqXwIF2cjG3Nl/view?usp=sharing](https://drive.google.com/file/d/1Gb1Wbrn6kNNvuDmoVloDqXwIF2cjG3Nl/view?usp=sharing)



Following table depicts the functionality of various life cycle transitions of Textbooks and content linked to it along with the behavior of back-end and front-end system:



|  |  **Initial State**  |  **Changed State**  |  **State Change Allowed?**  |  **Back-end (platform) behavior**  |  **Front-end behavior: Textbook editor**  |  **Front-end behavior: Consumption View (all channels: mobile, portal, desktop app)**  | 
|  --- |  --- |  --- |  --- |  --- |  --- |  --- | 
| 1 |  **Textbook : v1, Draft**  |  **Textbook : v1, Draft**  linked with  **Content: v1, Draft**  | Yes | Allow linking of a draft content to a draft textbook | <ul><li>Textbook Editor should NOT allow searching and liking draft content to a Textbook section.

</li><li>Textbook Editor should display the state of a linked content.  (not yet implemented)

</li><li>When a content is uploaded or created through Contributor View in Program UI), it will by default be created as Draft and linked to the Textbook.

</li><li>Review View in Program UI should display the state of a linked content (implemented )

</li></ul> | Textbook or content is not shown to the end users. | 
| 2 |  **Textbook : v1, Draft**  linked with  **Content: v1, Draft**  |  **Textbook : v1, Draft**  linked with  **Content: v1, Review**  | Yes | Allow changing of Draft content linked to a Textbook to Review state | <ul><li>There is NO explicit way of linking a Content in Review state to a Textbook, either from Textbook Editor or Program UI.

</li><li>Textbook Editor should display the state of a linked content.  (not yet implemented)

</li><li>Review View in Program UI should display the state of a linked content (implemented )

</li></ul> | Textbook or content is not shown to the end users. | 
| 3 |  **Textbook : v1, Draft**  linked with  **Content: v1, Draft/Review**  |  **Textbook : v1, Review**  linked with  **Content: v1, Draft/Review**  |  **No**  | API should throw an error (not yet implemented) | <ul><li>Textbook Editor should disable “Send for Review” option if there is at least one of the linked content is not in Live state (not yet implemented)

</li></ul> | NA | 
| 4 |  **Textbook : v1, Review**  linked with  **Content: v1, Draft/Review**  |  **Textbook : v1, Live** linked with  **Content: v1, Draft/Review**  |  **No**  | The “Initial State” itself in invalid. But even due to some error, it has occurred, API should throw an error for the state change (not yet implemented) | NA | NA | 
| 5 |  **Textbook : v1, Draft**  linked with  **Content: v1, Review**  |  **Textbook : v1, Draft** linked with  **Content: v1, Live**  | Yes | Allow changing of Review content linked to a Textbook to Live state | <ul><li>Textbook Editor should display the state of a linked content.  (not yet implemented)

</li><li>Review View in Program UI should display the state of a linked content (implemented )

</li></ul> | Textbook is not shown to the end users.Content: v1 can be access by end users  | 
| 6 |  **Textbook : v1, Draft** linked with  **Content: v1, Live**  |  **Textbook : v1, Review** linked with  **Content: v1, Live**  | Yes | Allow changing of a Textbook from Draft to Review if all content linked to it are in Live state | <ul><li>Textbook Editor should enable “Send for Review” option if all the linked contents are in Live state

</li></ul> | Textbook is not shown to the end users.Content: v1 can be access by end users | 
| 7 |  **Textbook : v1, Review** linked with  **Content: v1, Live**  |  **Textbook : v1, Live** linked with  **Content: v1, Live**  | Yes | Allow changing of a Textbook from Review to Live state if all content linked to it are in Live state | <ul><li>Review page will allow publishing of Textbook

</li></ul> | Once Textbook is published, end users will see: **Textbook v1**  with  **Content v1**  linked to it. | 
| 8 |  **Textbook : v1, Live** linked with  **Content: v1, Live**  |  **Textbook : v1, Live** linked with  **Content: v1, Live** A new version  **Content v2, Draft** created | Yes | Allow creating Content v2. DraftNo change in **Textbook : v1, Live** linked with  **Content: v1, Live**  | NA | End Users see: **Textbook v1**  with  **Content v1**  linked to it. | 
| 9 |  **Textbook : v1, Live** linked with  **Content: v1, Live**  **Content v2, Draft**  |  **Textbook : v1, Live** linked with  **Content: v1, Live**  **Content v2, Review**  | Yes | Allow changing  **Content v2. Draft**  to  **Content v2. Review** No change in **Textbook : v1, Live** linked with  **Content: v1, Live**  | NA | End Users see: **Textbook v1**  with  **Content v1**  linked to it. | 
| 10 |  **Textbook : v1, Live** linked with  **Content: v1, Live**  **Content v2, Review**  |  **Textbook : v1, Live** linked with  **Content: v1, (hanging state)**  **Content v2, Live**  | Yes | Allow changing  **Content v2. Review** to  **Content v2. Live** No change in **Textbook : v1, Live** linked with  **Content: v1, (hanging state)** Send notifications to creator of  **Textbook v1** about the change in content version (not yet implemented) | NA | End Users see: **Textbook v1**  with  **Content v1**  linked to it. | 
| 11 |  **Textbook : v1, Live** linked with  **Content: v1, (hanging state)**  **Content v2, Live**  |  **Textbook : v1, Live** linked with  **Content: v1, (hanging state)** A new version  **Textbook : v2, Draft** createdWhat should it be linked with?  **Content: v1, (hanging state)**  or  **Content v2, Live** ?It should be  **Content v2, Live**  | Yes | Allow creating **Textbook : v2, Draft** When  **Textbook : v2, Draft**  is created (not necessarily from front-end), check if any of the linked content has newer version that is in Live state. If so, link to that version (not yet implemented) | In Textbook editor, show  **Content v2, Live**  but highlight the textbook node and the linked content, such that it signifies that this is a new version (Live) of the content that is different from what is currently linked to  **Textbook : v1, Live** (not yet implemented) | End Users see: **Textbook v1**  with  **Content v1**  linked to it. | 
| 12 |  **Textbook : v1, Live** linked with  **Content: v1, (hanging state)**  **Textbook : v2, Draft** linked with  **Content v2, Live**  |  **Textbook : v1, Live** linked with  **Content: v1, (hanging state)**  **Textbook : v2, Review** linked with  **Content v2, Live**  | Yes | Allow changing **Textbook : v2, Draft** to  **Textbook : v2, Review**  | In Textbook Review page, show  **Content v2, Live**  but highlight the textbook node and the linked content, such that it signifies that this is a new version (Live) of the content that is different from what is currently linked to  **Textbook : v1, Live** (not yet implemented) | End Users see: **Textbook v1**  with  **Content v1**  linked to it. | 
| 13 |  **Textbook : v1, Live** linked with  **Content: v1, (hanging state)**  **Textbook : v2, Review** linked with  **Content v2, Live**  |  **Textbook : v2, Live** linked with  **Content v2, Live**  | Yes | Allow changing **Textbook : v2, Review** to  **Textbook : v2, Live**  | NA | End Users see: **Textbook v2**  with  **Content v2**  linked to it. | 
| 14 |  **Textbook : v2, Live** linked with  **Content v2, Live**  |  **Textbook : v2, Live** linked with  **Content v2, Live** New version  **Content v3, Draft** created | Yes | Similar to row 8 | Similar to row 8 | Similar to row 8 | 
| 15 |  **Textbook : v2, Live** linked with  **Content v2, Live** New version  **Content v3, Draft** created | New version  **Textbook : v3, Draft** created **Textbook : v2, Live linked with Content v2, Live**  **Textbook : v3, Draft** linked with  **Content v2, Live**  **Content v3, Draft**  (not linked) | Yes | Allow creating new draft **Textbook : v3, Draft** New draft will be linked with  **Content v2, Live**  | <ul><li>Textbook Editor displays new version of Textbook linked with  **Content v2, Live**  content

</li></ul> | End Users see: **Textbook v2**  with  **Content v2**  linked to it. | 
| 16 |  **Textbook : v3, Draft** linked with  **Content v2, Live**  **Textbook : v2, Live linked with Content v2, Live**  **Content v3, Draft**  (not linked) |  **Textbook : v3, Review** with  **Content v2, Live**  **Textbook : v2, Live linked with Content v2, Live**  **Content v3, Draft**  (not linked) | Yes | Allow changing  **Textbook : v3, Draft** to  **Textbook : v3, Review**  | <ul><li>Textbook Review page displays Textbook linked with  **Content v2, Live**  content

</li></ul> | End Users see: **Textbook v2**  with  **Content v2**  linked to it. | 
| 17 |  **Textbook : v3, Review** with  **Content v2, Live**  **Textbook : v2, Live linked with Content v2, Live**  **Content v3, Draft**  (not linked) |  **Textbook : v3, Live** with  **Content v2, Live**  **Content v3, Draft**  (not linked) | Yes | Allow changing  **Textbook : v3, Review** to  **Textbook : v3, Live**  **Textbook: v2, Live**  is removed | NA | End Users see: **Textbook v3**  with  **Content v2**  linked to it. | 
| 18 |  **Textbook : v3, Review** with  **Content v2, Live**  **Textbook : v2, Live linked with Content v2, Live**  **Content v3, Draft**  (not linked) |  **Textbook : v3, Review** with  **Content v2 (hanging state)**  **Textbook : v2, Live linked with Content v2 (hanging state)**  **Content v3, Live**  | Yes | Allow changing  **Content: v3, Draft** to  **Content: v3, Review** and then to **Content: v3, Live**  **Textbook : v3, Review**  and  **Textbook : v2, Live** will continue to link with  **Content v2 (hanging state)**  | <ul><li>Textbook Review page of  **Textbook : v3, Review**  displays Textbook linked with  **Content v2** content

</li></ul> | End Users see: **Textbook v2**  with  **Content v2**  linked to it. | 
| 19 |  **Textbook : v3, Draft** linked with  **Content v2, Live**  **Textbook : v2, Live linked with Content v2, Live**  **Content v3, Draft**  (not linked) |  **Textbook : v3, Draft**  **with Content v2 (hanging state)**  **Textbook : v2, Live linked with Content v2 (hanging state)**  **Content v3, Live**  | Yes | Allow changing  **Content: v3, Draft** to  **Content: v3, Review** and then to **Content: v3, Live**  **Textbook : v3, Draft**  and  **Textbook : v2, Live** will continue to link with  **Content v2 (hanging state)**  | <ul><li>Textbook Editor of  **Textbook : v3, Draft**  displays Textbook linked with  **Content v2** content

</li></ul> | End Users see: **Textbook v2**  with  **Content v2**  linked to it. | 




#  Open Questions

1. What should happen if a content linked to a Textbook is deleted (state changed to “Retired”)? - I think system should not let a content linked to one or more textbooks be deleted.


1. How should a “Limited Sharing” (“Unlisted”) content behave? I think a “Limited Sharing” content should not be allowed to be linked to a Textbook







*****

[[category.storage-team]] 
[[category.confluence]] 

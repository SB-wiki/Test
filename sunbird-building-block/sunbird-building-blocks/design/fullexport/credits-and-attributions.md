# Credits-and-attributions

\| 1.11 | | | | GreenReady | |

\| | | | Lead developer |

| Lead tester |
| ----------- |
| ---         |
| ---         |
| ---         |
| ---         |
| ---         |
| ---         |
| 1.11        |
|             |
| GreenReady  |
|             |

\| | | | Lead developer | | Lead tester |

### Goals

* Allow a creator to give credit to multiple other people registered or not registered on the system
* Allow a creator to give credit to collaborators & contributors

#### Background and strategic fit

Users might be collaborating and contributing to each other's work outside the system in many ways. Also given India's context of low internet and scarce computer infrastructure, many times a user might be creating or uploading on behalf of others. To ensure that as part of promoting democratisation of content and to motivate people to adopt creative commons, we should allow users to give credit to others and everyone involved. Eventually system can even show an individuals contribution in their profile and org level reports.

#### Assumptions

* There is a proxy user uploading or creating a content on behalf of one or many people on or off the system
* The interactions on system and off system collectively will result in credit being written by user
* Any conflict in credits will be resolved by parties involved outside the system
* Users will use the credits to give due credit to people involved in creation of content

### Requirements

Refer to whiteboard discussion captured here at [https://www.camscanner.com/share/show?encrypt\_id=MHgxNWI5MzE4\&sid=15679CDE3D7441449X7P08YY](https://www.camscanner.com/share/show?encrypt\_id=MHgxNWI5MzE4\&sid=15679CDE3D7441449X7P08YY)

Introduce new (use existing) attributes to store following details (changes for Platform)

1. Authors / Creators - text containing name & detail of creators or authors. In future, users can @ mention names of registered users
2. Collaborators / Contributors - text containing name & detail of collaborators. In future, users can @ mention names of registered users
3. Attributions / Acknowledgements - text containing name & detail of contributors, influencers, and all other who helped the authors. Mostly this will have non-registered people's name & detail
4. Copyright / ownership - Refer to [SB-5678 System JIRA](https://browse/SB-5678)
5. Continue to store createdBy, creator, collaborators, and other attributes for system workflows & functionality as required.&#x20;

Consumption (changes for Mobile app & Web portal)

1. Show 1,2,3,4 as mentioned above
2. Do not show system stored / generated attributes as mentioned in 5

Creation

1. System should capture creator (createdBy) and collaborators (with their name & IDs) accordingly.
2. As a creator I should be able to enter names of Authors & Contributors as per 1 & 2 in above
3. Refer to collaboration ticket for more details about collaboration [SB-1919 System JIRA](https://browse/SB-1919)

#### Questions/Comments:

1. An optional addendum should be the display of the Sunbird instance from which the content was sourced (For e.g., Shikshalokam might show that Diksha was the origin of some of the content).
   1. Not being requested so parking for future.
2. There was some discussion about how contributors are shown for textbooks/collections/courses. What was the final call taken here, and who's watching over this decision?
   1. owns this along with Krishna. Storage is in spine and view is as per design.
3. The display of content cards should ideally depend on the instance which is displaying the cards (or playing the content) - does this have any implications, if the source instance rules (the instance where the content was created) wants the organization/creator name compulsorily displayed? Who's taking the call on this decision?
   1. Park for later.  Will watch out and the immediate first example might be EkStep and Diksha integration
4. Similar question for who controls the display for the content details page - content creation instance or destination. Who's taking the call on this decision?
   1. Park for later.  Will watch out and the immediate first example might be EkStep and Diksha integration
5. has mentioned that there's a request to show credits on the end-of-content summary page. Who's watching over this requirement?
   1. Should be able to help.

### Conclusion on requirements and action to be taken in 1.12:

#### As a creator, I can add

1. Creators - list of primary contributors (text). This could be creators or collaborators, all of whom could be the primary contributors.
2. Contributors - list of secondary contributors (text).&#x20;
3. Attribution - free text to type any attributions

will schedule this in 1.12  [SB-7956 System JIRA](https://browse/SB-7956)

Content Framework will enhance core plugin for content details to accommodate this change, and form API will support configuring these fields.

#### System (platform, portal, editor / studio) will capture

1. Logged in user as creator and createdBy.
2. Collaborators as \<to be decided - store ID & proof>&#x20;

Please share content model variables for Creator input 1,2,3 and System capture 2.

Consumption &  have created [SB-7366 System JIRA](https://browse/SB-7366)  and [SB-7946 System JIRA](https://browse/SB-7946)for the same.

**Business Scenarios:**

Given a scenario for textbook creation in Diksha - where various textbook-writers (primary contributor) contribute on creation of content, which are bundled together to form a textbook and reviewed by technical and pedagogy experts (secondary contributor). This is further uploaded/published by Digital Content Team (secondary contributor) on portal.

In this case, the Digital Content Team on Portal can give credits to actual textbook-writers by adding details to primary contributor list and further give credits to reviewers and digital content team itself by adding details to secondary contributor list.

Similarly for course creation -  where content creation cell (primary contributors) creates story boards, digital contents in form of video, html, pdf etc which are motivated or influenced by various existing content/writers (attributors). These are then bundled in structured format by QR Code team or Curation Team (secondary contributor) and then uploaded/published in portal by set of team members from digital content team (owner).

In this case, the Digital Content Team on Portal can give credits to

Primary Contributors - content creation cell members details

Secondary Contributors - QR Code and curation team members details

Attribution - motivator or influencer

Ownership - digital content team

_End of document_

***

\[\[category.storage-team]] \[\[category.confluence]]

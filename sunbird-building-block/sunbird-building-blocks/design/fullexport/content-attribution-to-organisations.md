# Content-attribution-to-Organisations

\| 1.10 | | [SB-5678 System JIRA](https://browse/SB-5678) | | Implementation | |

\| | | |    |

| Lead tester                                   |
| --------------------------------------------- |
| ---                                           |
| ---                                           |
| ---                                           |
| ---                                           |
| ---                                           |
| ---                                           |
| 1.10                                          |
| [SB-5678 System JIRA](https://browse/SB-5678) |
| Implementation                                |
|                                               |

\| | | |    | | Lead tester |

### Goals

* Create incentives for multiple organisations to collaborate on course creation in a Sunbird instance
  * Create the means for an organisation which sponsors content creation to get visibility for their contributions
  * Provide course creators easy ways to 'do the right thing' when it comes to attributing content which they are using

BackgroundContent which is created in Sunbird has three metadata properties which point to the entities involved in creating the content

* createdBy – the is the id of the user who created the content
* creator – the name of the user who created the content
* createdFor – this is the id of the organisation which the user belongs to when creating the content
* organisation – an array of organisation names (not IDs)
* channel – this is the channel to which the creator belongs at the time when the creator last edited the content

When content and courses are displayed in Sunbird, the display text attributes the content to the creator.

### Assumptions

* Content creation can be
  * sponsored – i.e. an organisation is paying for a person to create the content
  * non-sponsored – i.e. an individual is creating content based on personal choices
* In either sponsored or non-sponsored case, an entity will shoulder the responsibility for reviewing the content to ensure standards are met
* Multiple attribution models need to be supported. Content can be
  * _non-sponsored_ and _attributed to the individual_ creating it
  * _sponsored_ and _attributed to the organisation_ sponsoring it
  * _sponsored_ and _attributed to the individual_ creating it
* For a course or a textbook, visible credit at the aggregate level (course or textbook) carries more meaning than credit at an individual content level

### Proposal

The proposal is to allow

1. display text to attribute content to either the individual creator or to the creator's organisation
2. and organisation to remove and individual's edit privileges when she/he leaves an organisation which sponsored content creation
3. content which aggregates other content pieces to automatically attribute the entities who created those items
4. content copy to attribute the source of the content where it was copied from

### Design

#### Attribution to organisation

1. In order to identify sponsoring organisations, introduce a new property in the content model called ownershipType – the property is an enumerated field whose options are createdBy or createdFor
2. If the value of ownershipType is createdFor, the organisation's name will be displayed when the content is shown in Sunbird
3. If the value of ownershipType is createdBy, the individual's name will be displayed when the content is shown in Sunbird
4. When creating it's framework, an organisation can decide
   1. what is the default value of the ownership property
   2. to disable either createdBy or createdFor as options for the ownershipType property
   3. to enable both createdBy or createdFor as options for the ownershipType property
5. To ensure that the creator sets the ownershipType correctly, the organisation can
   1. enforce the ownershipType during the review page, or
   2. choose to give edit rights on the ownershipType property only to some content creators or content reviewers

#### User transfer between organisations

When a user leaves an organisation (or if her/his creation rights are removed), their creator role in that organisation is terminated. At this point,

1. The user no longer has CONTENT\_CREATOR role attached to the organisation
2. The workspace application should apply a filter when displaying editable content to
   1. restrict editable content to those items where the createdFor property matches any of the organisations for which the user currently has CONTENT\_CREATOR role

#### Attribution of aggregate content

When a user creates aggregate content by selecting one or more resources for inclusion, the new content will store references to the entities indicated by the ownership property of the included resource. The references will be stored in the attributions field.

For instance,

1. Galactic Publishers creates a course on the Solar System which contains&#x20;
   1. **Moons of Jupiter** created by _Io Publishing_ , and
   2. **Rings of Saturn** created by _Weekend Imprints_
2. When the course on the Solar System is displayed, the display text will
   1. attribute creation of the course to Galactic Publishers
   2. attribute credit for included content to _Io Publishing_ and _Weekend Imprints_
3. Eg text:
   1. _created by_ : Galactic Publishers _with contributions from_ : Io Publishing & Weekend Imprints

To accomplish this, as the course on the Solar System is created,

1. content stores references to the organisation ids of Io Publishing and Weekend Imprints organisations in the attributions field
   1. attributions: \[{ ownershipType: 'createdFor', id: '\<io\_publishing\_org\_id>', name: 'Io Publishing'}, { ownershipType: 'createdFor', id: '\<weekend\_imprints\_org\_id>', name: 'Weekend Imprints'}]
2. The references are added to the content model while the course is being edited and not when it is saved, sent for review or published so that the author can see the attribution text as the course is being constructed.

Attributing individualsThe example above assumes that the resources included are sponsored and attributed to the sponsoring organisation. If the resources were non-sponsored, or sponsored but attributed to the individual then the reference would be made to the individual as a contributor

Resource VersioningThe reference to contributors will be based on the version of the resource when it was added to the aggregate content.

1. Resource R is at version N where the ownershipType property is set to createdBy and
2. It is added to a course C, the course gives credit to the creator of R
3. Resource R is then edited to change the ownershipType property to createdFor at version N+1
4. Course C, continues to give credit to the creator of R because the course references version N of the resource
5. When C is edited and the version of R added to C is updated to N+1 (or further), only then will the course C give credit to the organisation which sponsored creation

Performance concerns

1. If the number of references grows large, there could be performance considerations when downloading the ECAR file
2. If #1 is indeed the case, i.e. there are performance implications in bundling attribution data with the content
   1. a content contributor API is created which provides complete details of contributors
   2. the web application and the mobile application will augment the content view with a link to a contributor view
   3. the contributor view will use the content contributor API to fetch the data needed
3. If #2 is not the case, i.e. if bundling the attribution data into the content ECAR does not significantly impact the ECAR size,
   1. the web application and mobile application will still augment the content view with a link to a contributor view
   2. however, the contributor view will use the data bundled in the ECAR to render the view

#### Copying content

1. When an item of content is copied, the new item of content must carry attribution to the original content
2. The attribution cannot be edited by the creator of the new content
3. If the content item is an aggregate content (course, collection, book), then the individual items which are part of the source are included into the derived content and credit to the creators of those items is handled as described in the section on Attribution of aggregate content above

### Requirements

[System JIRA](https://browse/)

### Questions

Below is a list of questions to be addressed as a result of this requirements document:

| Question                                                                                                                                                                                                                                                                      | Outcome                                                                                                                                                                                   |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Should an ownershipType property be added or is there another property (copyright) in the content model which could be used instead?                                                                                                                                          | Yes, ownershipType should be added. copyright cannot be used because it already contains many instances of string data which would require data migration and backfills.                  |
| Which property should be used for storing the credits for an aggregate content item?                                                                                                                                                                                          | We should use the attributions property which stores a list of structured references to the entities which should be attributed.                                                          |
| Does attribution/credit information get bundled in the ECAR or is it fetched from the server on demand?                                                                                                                                                                       | Attribution is bundled into the content metadata and downloaded with the ECAR, however, the composed full text of the attribution is constructed at the time of rendering the attribution |
| The createdFor property has review workflows and semantics attached to it. There can easily be cases where sponsorship and review responsibility are separated. Should there be another property (possibly sponsored-by) which is used to represent the sponsorship relation? | Review workflow can be moved by attaching a scope to the REVIEWER permission to route content to the appropriate reviewers.                                                               |

### User interaction and design

Include any mockups, diagrams or visual designs relating to these requirements.

### Not Doing

* At this point, we are not considering the case of an individual creating content without belonging to any organisation. The case of user-rights outside an organisation which grants those rights is a cross-cutting concern across Sunbird and is not a valid scenario at present.

***

\[\[category.storage-team]] \[\[category.confluence]]

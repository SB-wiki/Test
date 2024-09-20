# Overview

Sunbird Content model has been used for specific use cases like textbooks and courses so far. The model has been designed and refined over time mainly to support these two use cases. However, this current model is not flexible enough to serve a wide variety of needs like:

* Easily add new types of content categories like Podcasts, TV Shows, Stories, etc.
* Decouple behaviour from type of content. For example, progress tracking should not be limited only for “Courses”, should be able to track consumption of other types like “Podcasts” also. Similarly, it should be possible to allow anonymous consumption of a particular course.
* Configurable hierarchy structures - i.e. “Textbook” contains chapters, “Course” contains modules and a “TV Show” contains episodes.
* Platform supports content to be created for different purposes but it is not possible to discover these content by other framework users. For example, if there is a Podcast about “what is artificial intelligence”, how can it be made discoverable to an audience that use a different framework.

### Current Model

Following are the main content classification categories we have in the current content model:

* **ObjectType** - Question, QuestionSet & Content. Though we have multiple object types, the only consumable object type currently is “Content”. Everything has to be converted into a content to make it consumable.
* **ContentType** - Course, Textbook, Resource, Collection, ExplanationResource, eTextbook, PracticeSet, etc. There are multiple behaviours specific to content type:
  * It is assumed that all textbooks and courses will be collections only. E.g.: a PDF or an ePub cannot be published as a text book.
  * Specific creation & consumption experience implementations for each content type. I.e. course, textbook, collection and resource content types have different editors & players. Adding a new content type will require changes across the board.
  * Having generic types (like resource, collection) makes it difficult for search and discovery of content for specific purposes. E.g.: “Resource” is used for a lot of purposes like worksheets, games, explanation videos, etc.
* **ResourceType** - Learn, Teach, Practice, Test, Play, Course, Book, Lesson Plan, etc. This attribute is used in some places for filtering the content.
  * Creators find it difficult to tag the resource type for most of the content, especially for generic content types like resource and collection.&#x20;
  * Some resource type values are verbs (like learn, teach) and some are content types (like course, book). There is specific implementation like automatically setting the resource type for courses, textbooks and lesson plans to Course, Book and Lesson Plan respectively.
* **MimeType** - HTML, ECML, ePub, PDF, mp4, collection, etc. This is required for identifying the renderer to be used while playing a content.

### New Model

**Key Principles**

* Classify the objects on a minimal set of categories - Object Type & Mime Type
* Rest of the behaviour should be driven only via attributes - like tracking, monitoring, anonymous access, etc.

**Object Type**

Object type is used to group objects with same structure, metadata & behaviour. These object types are first-class entities in the platform. Proposed object types are:

Asset, Question, Resource, QuestionSet, Collection

* Structure:
  * Assets are individual media elements.
  * Questions have a body, solution, answer, evaluation logic, and assets objects embedded within these question parts.
  * Resources are individual learning units and can contain questions and assets.
  * QuestionSets have instructions, branching & evaluation logics and contain questions, resources and other question sets.
  * Collections can contain other collections, question sets, resources, questions and assets.
* Metadata: Each object type has its own schema that defines the list of attributes (& optionally, allowed values) that can be set for objects of that type.
* Behaviour: Certain behaviour is driven by the object type. For example, a collection object will have a TOC view in player & editor, a QuestionSet will generate ASSESS events when consumed, etc.

**Mime Type**

Mime type is the technical mime type of the object. This is used by editors and players to use the appropriate plugin/renderer. List of mime types supported for each object type is configured as part of the object type schema. E.g.: Collections can be only of mime type “application/vnd.ekstep.content-collection”.

#### Categories

Object types are used for representing the objects within the platform. But different variations of these object types are required to serve different use cases. For example, different types of collections like TextBook, Course, PlayList are required for different learning purposes. Same is the case for question sets (exam, quiz, practice test, etc) and resources (explanation content, story, puzzle, etc). The list of these types keeps growing, and thus, there should be not be any specific implementation for any of these use cases. Hence, these will be defined as “categories” in the platform and will be loosely-coupled & configurable.

* One category can be used for tagging objects of different object type. E.g. a “Podcast” can be either a Resource or a Collection. Platform, creation and consumption will not have any understanding of the category - all behaviour is driven by the object type, mime type and metadata attributes (like trackable, etc).
* One object can be tagged with multiple categories. E.g. a Resource can be tagged as a “Explanation Video” and a “Classroom Teaching Video”.

**Category Definitions**

While we are simplifying the object classification in platform, it may be too abstract for content creators. They will not be able to understand and define various behavioural attributes like trackable, timed vs not-timed, etc. To make it simple, behaviour of a category can be pre-defined:

| **TextBook**                                                                                | **Course**                                                                                   | **Practice Quiz**                                                                   | **QuestionPaper**                         | **Exam**                                                                               |
| ------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------- | -------------------------------------------------------------------------------------- |
| objectType: Collection trackable: no mimeType: \[application/vnd.ekstep.content-collection] | objectType: Collection trackable: yes mimeType: \[application/vnd.ekstep.content-collection] | objectType: QuestionSet mimeType: \[QuML, ECML] showFeedback: true allowRetry: true | objectType: QuestionSet mimeType: \[QuML] | objectType: QuestionSet mimeType: \[QuML] allowRetry: false timed: true trackable: yes |
| objectType: Resource trackable: no mimeType: \[pdf, ePub]                                   | objectType: Resource trackable: yes mimeType: \[pdf, html]                                   |                                                                                     | objectType: Resource mimeType: \[pdf]     |                                                                                        |

With this, the creation experience can be made user-friendly and driven via the category definitions.

* Category definitions will be made configurable at a tenant level, i.e. a category can have multiple definitions, one per tenant.
* Category definitions will be used only in creation and for search & discovery. Consumption is driven only by object type and metadata of the object.
* Category definition will also have modifiable and non-modifiable behaviours. Behaviours that are not modifiable should be automatically set by the system during creation. Behaviours that are modifiable should be shown in the editor (during creation as well as modification) to the user to change.
* An object will have a primary category (for defining the behaviour) and additional display categories (only as tags and used for discovery). Object will be discoverable via both the primary & display categories.

**Organisation & Target Frameworks**

Similar to how an object has primary category for defining the behaviour and multiple display categories for search & discovery, objects can also be tagged with multiple frameworks:

* Organisation Framework - what the object is about. E.g: a resource “How to deal with bullying in classroom” will be tagged with a non-academic framework subject “General Training” and topic “Life Skills“.
* Target Frameworks - to whom this object should be made discoverable. E.g: the resource “How to deal with bullying in classroom” will be tagged with multiple academic framework gradeLevels “Class 6 - Class 10”.

The organisation and target frameworks also are configurable for each category:

* Textbook - Organisation Framework Type: “K-12”, Target Framework Type: “K-12”
* Course - Organisation Framework Type: “K-12, TPD”, Target Framework Type: “K-12”

***

\[\[category.storage-team]] \[\[category.confluence]]


## Object Types
Object type is used to group objects with same structure, metadata attributes & behaviour. These object types are first-class entities in the platform and have implementation specific for each object type like:


* Storage & Processing logic for each object type. E.g: content storage & publish process is different from collection storage & publish process.


* Separate editors for each object type. E.g: content editor & collection editor


* Separate players for each object type. E.g: content player & collection player




### Object Types in Sunbird Platform


|  **Asset**  |  **Question**  |  **QuestionSet**  |  **Content**  |  **Collection**  | 
|  --- |  --- |  --- |  --- |  --- | 
| Object type for media assets. Assets do not have any pedagogic information. | Object type for questions. Question object has a defined structure to store different parts of a question like body, solutions, score, etc.  | Object type for question sets. QuestionSet is used to represent tests, i.e. exams, quizzes, practice exams, etc.  | Object type for Content, a single unit of learning object.  | Object type for a collection of learning objects. | 
| Assets are not independently consumable. | Questions can be consumed independently (with exception of some question types which are not consumable independently). | Question Sets can be consumed independently. | Content can be consumed independently. | Collections can be consumed independently. | 
| Assets do not contain other assets or any other objects. | Questions can contain assets like video, audio, image, etc within their body, solution, feedback and other parts. | Question Sets can contain assets, questions and other question sets.  | Content can contain assets, questions and question sets. | Collections can contain assets, questions, question sets, content, and other collections. | 
| Assets are used in all other objects. | Questions can be embedded within question sets, content and collections. | Question Sets can be embedded within other question sets, content and collections. | Content can be embedded within collections. | Collections can be embedded in other collections. | 
|  |  |  |  |  | 

Schema for each object type can be defined and updated via APIs.


## Categories
Object types are used for representing the learning objects within the platform. But different variations of these object types are required to serve different use cases. For example, different types of collections like TextBook, Course are required for different learning purposes. Same is the case for question sets (exam, quiz, practice test, etc) and content (explanation content, story, puzzle, etc). To enable this, categories can be defined for each object type.


### Sample Categories


|  **TextBook**  |  **Course**  |  **Practice Quiz**  |  **QuestionPaper**  |  **Exam**  | 
|  --- |  --- |  --- |  --- |  --- | 
| objectType: Collectiontrackable: falsemimeType: \[application/vnd.ekstep.content-collection] | objectType: Collectiontrackable: truemimeType: \[application/vnd.ekstep.content-collection] | objectType: QuestionSetmimeType: \[QuML, ECML]showFeedback: trueallowRetry: true | objectType: QuestionSetmimeType: \[QuML] | objectType: QuestionSetmimeType: \[QuML]allowRetry: falsetimed: true | 
| TextBook can be created as Collection object with the specified mime type and they are not trackable. Rest of the attributes can be configured at creation time. | Course can be created as Collection object with the specified mime type and they will be trackable. Rest of the attributes can be configured at creation time. |  |  |  | 
| objectType: Contenttrackable: falsemimeType: \[pdf, ePub] | objectType: Contenttrackable: truemimeType: \[pdf, html] |  | objectType: ContentmimeType: \[pdf] |  | 
| TextBooks can also be created as a content object in the platform and they can be in either pdf or ePub format only. | Courses can also be created as a content object in the platform and they can be in either pdf or html format only. |  |  |  | 

Categories definition can also be configured using APIs. New categories can also be created via APIs. A category definition contains the following:


* Basic information like name, description, user-friendly label, tags, etc. 


* List of object types that can be used to create objects of the category.


* Metadata configuration for each supported object type. This configuration should be a subset of the corresponding object type definition, i.e. the category definition cannot have a mime type other than the ones defined in the Content schema definition if the “category” is using the Content object type.


* Creation information like supported organising framework types, target framework types.


* Rendering information like show/hide category, display order in creation & consumption, custom player to be used, page section config for consumption, etc.





*****

[[category.storage-team]] 
[[category.confluence]] 

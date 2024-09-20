# Collections---structure-optimization

**Introduction:** This wiki explains the current structure for collections and the proposed structure changes for optimization and scale.

**Background & Problem statement:** The textbook is realized by **Collection** node in the Knowledge Platform. The textbook with chapters, sections, and sub-sections created as a sub-graph. Chapter, Section, and Sub-section are also collection nodes, and all these are children (Ex:  **TextbookUnit, CollectionUnit, CourseUnit** etc,.) for Textbook. The textbook children are always accessible via textbook only, and these are not available for other textbooks to add and use. So, they are not giving much functional value.

![](<../../../../Design/FullExport/images/storage/textbook - structure - 1.png>)

Publishing a textbook will check the status (not live or unlisted) of all its children and triggers publish for them also. Publishing the textbook children is required because they are nodes in Knowledge platform. Due to this, the publish process takes more time for textbooks.

* A textbook having **\~400 children** takes  **10 min** to publish.

Knowledge platform maintain two versions of a content (edit and live). Any changes for a live version content applies to the edit version content. Having this for textbook creating more nodes and relations in the sub-graph. When a textbook having hundreds of children and some of them with live and edit version, it will increase the complexity and affect the performance to read hierarchy of a textbook with the mode - edit vs. live.

* A textbook having **\~400 children** takes  **\~8.5sec** to fetch the hierarchy.

![](<../../../../Design/FullExport/images/storage/textbook - structure - 2.png>)

**Key Design Problems:**

* A simple data format to define children of a collection.
* Collection hierarchy data for mode value - edit vs live.
* Performance improvement for operations (read and write) on Collection.
* Performance improvement for collection publish.
* Data migration of the Collection

**Design:** **Collection hierarchy as body** Based on the mimeType of content, its actual data is available in the cloud-storage or Cassandra. After publishing a collection its hierarchy structure (JSON) doesn't change (static). So, as part of the collection publish process, the hierarchy generated and saved to Cassandra. With this, the hierarchy read API for live content performance improved.

* **cloud-store** - application/pdf, video/mp4, application/vnd.ekstep.html-archive, application/epub, etc,.
* **cassandra** - application/vnd.ekstep.ecml-archive

ECML content represented using **stages** and **manifest** . Similarly, a Collection can be represented using **nodes** and **hierarchy** . So, **Collection's actual data stored in Cassandra as** JSON.

| ECML Content | Collection                                                     |
| ------------ | -------------------------------------------------------------- |
| **Stages**   | It defines the slides/pages and all the objects in each slide. |
| **Manifest** | It defines the assets used in ECML content.                    |
|              |                                                                |
| \`\`\`js     |                                                                |
| {            |                                                                |

"manifest" : { "media": \[{...}], }, "stages": \[{...}], .... }

````


 | 
```js
{
    "nodes": {
        "tb_1": {
            "name": "TextBook 1",
            "contentType": "TextBook",
            "visibility": "Default",
            "status": "Draft",
            .....
        },
        "tbu_1": {
            "name": "Unit -1",
            "contentType":"TextBookUnit",
            "visibility": "Parent",
            ....
        },
        ...
    },
    "hierarchy": {
       "tb_1": ["tbu_1", "tbu_2", ...],
       "tbu_1": ["tbu_1_1",...],
       ...
    }
}
````

|

![](<../../../../Design/FullExport/images/storage/collection - current vs new.png>)

**Structure for collection based on mode - edit vs. live** The live version of the collection body is always used only for consumption. The edit version body will have a lot of change with the update operations. So, both versions require a different format of the body as JSON to maintain them easily. The body structure of the collection should have minimal transformations for reads and writes.

* **Edit version** - Will have nodes as a flat list containing metadata of each node and hierarchy as a map (key - parent id, value: children ids list).
* **Live version** - Will have a nested JSON representing the metadata and hierarchy structure together. A property with name **children** used to list the children content. Also, for each child collection in this, the hierarchy stored separately.

![](<../../../../Design/FullExport/images/storage/textbook - redefine - data model.png>)

**ES indexing of the collection and its children** Currently, collection and its children are nodes in the Knowledge platform graph DB. So, any change in its metadata or hierarchy structure synced to ES using the transaction events generated by Neo4J plugin. But with the above design, Collection represented as a node and its children saved in Cassandra. So, only the collection's metadata will sync to ES.

With existing use cases, the children of a collection required in ES only after publishing it. So, publish process will apply changes for children of a collection. The children of a collection (other than resources or leaf nodes) identified by setting **visibility** property value as **Parent** . Below logic will be applied in publish operation of the collection to sync its children.

* Search for all the documents from ES where **visibility: Parent, parent: current collection id** and compare Cassandra data and ES data
  * If a node available only in ES - delete the document from ES.
  * If a node available only in Cassandra - create a new document in ES.
  * If a node available in both - Update ES document using Cassandra metadata.

**Publishing the Collection** With the above design, collection publish will become as simple as publishing an ECML content. It is because the collection is a single node and its hierarchy stored in Cassandra.

Below are the steps which will be executed as part of publish operation:

1. Read the collection body and extract the children of type collection.
2. Download app icon for each child collection.
3. Generate a pre-signed URL for ECAR of the collection. Update the status of children to Live/Unlisted and add this URL as download URL.
4. Generate manifest.json, create ECAR and upload to cloud-store using the above pre-signed URL.
5. Construct a nested hierarchy structure and save it in Cassandra.
6. Use the above hierarchy structure to update ES documents for children.
7. Add relations among collection node and the resources used in it.

**Changes to API Spec:** It requires few changes to the existing Collection API Spec to support the above design. Below table has the details.

| API Name       | Current API                 | Proposed API                                       | Details                                                                                                                                                                                                                                                  |
| -------------- | --------------------------- | -------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Hierarchy Read | GET - content/v3/hierarchy/ | GET - content/ **v3** /hierarchy/ **textbookId** / | With the current data model for a textbook, textbook's section is also a node in the graph. so, we don't need the textbook to identify the section. But, with the proposed design, we need to know the textbook and section id to fetch section details. |

**Conclusion:**

1. Save collection hierarchy structure as body
2. Maintain a single structure of hierarchy for live and edit version.
3. Read Hierarchy API will be updated by adding textbook Id and bookmark Id in URL.
4. Index the nodes in the hierarchy structure into ES as part of publishing.

***

\[\[category.storage-team]] \[\[category.confluence]]

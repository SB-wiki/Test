# Relational-Metadata-feature-Release-Notes

Relational metadata can be added in the collection hierarchy to define the relation between an asset (content/collection) and the folder to which it is linked. It is important to note that Relational metadata attributes have no correlation to the attributes of the asset (content/collection) being linked to the collection unit.

Existing properties defined in schema are

* relName
* relTrackable
* mandatoryQuestion
* relScore
* keywords.

However, these properties behaviour is not defined as part of service. These properties are used as information storage purpose only in service. Behaviour of the application based on values of these properties is to be defined in the front-end(editors/players). Required properties can be defined in [relational\_metadata schema.json](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/schemas/relationalmetadata/1.0/schema.json) file. An adopter can modify/completely replace the schema with necessary properties. Any references of these properties in front-end (editors/players), has to be looked into for behavioural modifications.

Story: [SB-22864 System JIRA](https://browse/SB-22864)

Database Changes:

CASSANDRA - Script: _ALTER TABLE hierarchy\_store.content\_hierarchy ADD relational\_metadata text;_

APIs Updated:

* [Update Hierarchy API](http://docs.sunbird.org/latest/apis/collectionapi/index.html#operation/Collection%20Update)
* [Read Hierarchy API](http://docs.sunbird.org/latest/apis/collectionapi/index.html#operation/Read%20Collection%20Hierarchy)
* [Add to Hierarchy API](http://docs.sunbird.org/latest/apis/collectionapi/index.html#operation/Add%20Collection%20Hierarchy)
* Remove from Hierarchy API&#x20;

JOBs Updated: ‘ **content-publish** ’ flink job.&#x20;

Files Added/Updated:

* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/schemas/collection/1.0/schema.json](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/schemas/collection/1.0/schema.json)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/schemas/relationalmetadata/1.0/config.json](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/schemas/relationalmetadata/1.0/config.json)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/schemas/relationalmetadata/1.0/schema.json](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/schemas/relationalmetadata/1.0/schema.json)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/ontology-engine/graph-core\_2.11/src/test/scala/org/sunbird/graph/BaseSpec.scala](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/ontology-engine/graph-core\_2.11/src/test/scala/org/sunbird/graph/BaseSpec.scala)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/ontology-engine/graph-engine\_2.11/src/test/scala/org/sunbird/graph/BaseSpec.scala](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/ontology-engine/graph-engine\_2.11/src/test/scala/org/sunbird/graph/BaseSpec.scala)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/test/scala/org/sunbird/managers/TestHierarchy.scala](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/test/scala/org/sunbird/managers/TestHierarchy.scala)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/test/scala/org/sunbird/managers/TestUpdateHierarchy.scala](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/test/scala/org/sunbird/managers/TestUpdateHierarchy.scala)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/main/scala/org/sunbird/utils/HierarchyConstants.scala](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/main/scala/org/sunbird/utils/HierarchyConstants.scala)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/main/scala/org/sunbird/managers/HierarchyManager.scala](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/main/scala/org/sunbird/managers/HierarchyManager.scala)
* [https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/main/scala/org/sunbird/managers/UpdateHierarchyManager.scala](https://github.com/project-sunbird/knowledge-platform/blob/release-4.7.0/content-api/hierarchy-manager/src/main/scala/org/sunbird/managers/UpdateHierarchyManager.scala)
* [https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/publish-pipeline/content-publish/src/main/scala/org/sunbird/job/content/function/CollectionPublishFunction.scala](https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/publish-pipeline/content-publish/src/main/scala/org/sunbird/job/content/function/CollectionPublishFunction.scala)
* [https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/publish-pipeline/content-publish/src/main/scala/org/sunbird/job/content/publish/helpers/CollectionPublisher.scala](https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/publish-pipeline/content-publish/src/main/scala/org/sunbird/job/content/publish/helpers/CollectionPublisher.scala)
* [https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/publish-pipeline/content-publish/src/test/resources/test.cql](https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/publish-pipeline/content-publish/src/test/resources/test.cql)
* [https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/publish-pipeline/content-publish/src/test/scala/org/sunbird/job/publish/helpers/spec/CollectionPublisherSpec.scala](https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/publish-pipeline/content-publish/src/test/scala/org/sunbird/job/publish/helpers/spec/CollectionPublisherSpec.scala)
* [https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/jobs-core/src/test/scala/org/sunbird/spec/DefinitionCacheTestSpec.scala](https://github.com/project-sunbird/knowledge-platform-jobs/blob/release-4.7.0/jobs-core/src/test/scala/org/sunbird/spec/DefinitionCacheTestSpec.scala)
* [https://github.com/project-sunbird/sunbird-learning-platform/blob/release-4.7.0/ansible/roles/cassandra-db-update/templates/data.cql.j2](https://github.com/project-sunbird/sunbird-learning-platform/blob/release-4.7.0/ansible/roles/cassandra-db-update/templates/data.cql.j2)
* [https://github.com/Sunbird-Ed/creation-portal/blob/release-4.7.0/kp\_schemas/collection/1.0/schema.json](https://github.com/Sunbird-Ed/creation-portal/blob/release-4.7.0/kp\_schemas/collection/1.0/schema.json)
* [https://github.com/Sunbird-Ed/creation-portal/blob/release-4.7.0/kp\_schemas/relationalmetadata/1.0/config.json](https://github.com/Sunbird-Ed/creation-portal/blob/release-4.7.0/kp\_schemas/relationalmetadata/1.0/config.json)
* [https://github.com/Sunbird-Ed/creation-portal/blob/release-4.7.0/kp\_schemas/relationalmetadata/1.0/schema.json](https://github.com/Sunbird-Ed/creation-portal/blob/release-4.7.0/kp\_schemas/relationalmetadata/1.0/schema.json)

Update Hierarchy API request sample:

```json
{
   "request": {
       "data": {
           "nodesModified": {
               "do_11342063777635532812": {
                   "root": false,
                   "objectType": "Content",
                   "metadata": {
                        "name": "Collection Unit",
                        "contentType": "TextBookUnit",
                        "primaryCategory": "Textbook Unit",
                        "attributions": [],
                        "keywords": [
                            "UnitKW1",
                            "UnitKW2"
                        ]
                    },
                    "isNew": false
                },
                "do_11340096165525094411": {
                    "root": false,
                    "objectType": "Content",
                    "metadata": {
                        "name": "R1"
                    },
                    "isNew": false
                }
            },
            "hierarchy": {
                "do_11342063677881548811": {
                    "name": "Collection",
                    "children": [
                        "do_11342063777635532812"
                    ],
                    "root": true
                },
                "do_11342063777635532812": {
                    "name": "Collection Unit",
                    "children": [
                        "do_11342063777714176014",
                        "do_11340096165525094411"
                    ],
                    "relationalMetadata": {
                      "do_11340096165525094411": {
                        "relName": "R11"
                      }
                    },
                    "root": false
                },
                "do_11342063777714176014": {
                    "name": "L2 Folder",
                    "children": [
                        "do_11340096165525094411"
                    ],
                    "relationalMetadata": {
                      "do_11340096165525094411": {
                        "relName": "R21"
                      }
                    },
                    "root": false
                },
                "do_11340096165525094411": {
                    "name": "R1",
                    "children": [],
                    "root": false
                }
            },
            "lastUpdatedBy": "4cd4c690-eab6-4938-855a-447c7b1b8ea9"
        }
    }
}
```

No changes in the API response.

Read Hierarchy API:

* No changes in the request.
* Hierarchy response will return the ‘relational\_metadata’ **as part of the content metadata** under the respective Unit.

Add children to Collection API request sample:

```
{
   "request": {
       "rootId": "do_11346541373852876811",
       "unitId": "do_11346581562140262413",
       "children": [
          "do_11340096165525094411",
          "do_11340096165525093316"
       ],
       "relationalMetadata": {
           "do_11340096165525094411": {
               "relName": "R21"
           },
           "do_11340096165525093316": {
               "relName": "Resource Relative Name"
           },
       }
   }
}
```

No changes in response.

&#x20;

Remove children from Collection API:

No changes in the request and response. Only processing logic has been updated.

***

\[\[category.storage-team]] \[\[category.confluence]]

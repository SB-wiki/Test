Neo4J migration verification queries:Run the below queries before and after the migration and verify the counts.



|  **Migration**  **order**  |  **Type**  |  **Query**  |  **Before migration**  |  **Final migrationVersion**  |  **Comment**  | 
|  --- |  --- |  --- |  --- |  --- |  --- | 
| 1 | All the nodes | Match(n:domain) return count(n); |  |  |  | 
| 2 | All the node needs to migrate | MATCH (n:domain) WHERE n.IL_SYS_NODE_TYPE="DATA_NODE" AND n.IL_FUNC_OBJECT_TYPE IN \["Asset", "Content", "ContentImage", "Collection", "CollectionImage", "AssessmentItem", "ItemSet"] AND NOT EXISTS(n.migrationVersion) RETURN n.IL_FUNC_OBJECT_TYPE AS objectType, COUNT(n) AS count; |  |  | The count after migration should be 0. | 
| 3 | Video Asset | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Asset"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.mimeType IN \["video/mp4", "video/webm"] return count(n), n.IL_FUNC_OBJECT_TYPE, n.mimeType, n.status, n.migrationVersion; | <null> | 1.2 - Live1.0 - For other status |  | 
| 4 | Non Video Asset | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Asset"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and NOT n.mimeType IN \["video/mp4", "video/webm"] return count(n), n.IL_FUNC_OBJECT_TYPE, n.mimeType, n.status, n.migrationVersion; | <null> | 1.0 |  | 
| 5 | Video Content | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Content", "ContentImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.mimeType IN \["video/mp4", "video/webm"] return count(n), n.IL_FUNC_OBJECT_TYPE, n.mimeType, n.status, n.migrationVersion; | <null> | 1.2 - Live1.0 - For other status |  | 
| 6 | Plugin, Youtube, PDF, EPUB | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Content"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.mimeType IN \["application/vnd.ekstep.plugin-archive", "video/x-youtube", "application/pdf", "application/epub"] return count(n), n.IL_FUNC_OBJECT_TYPE, n.mimeType, n.status, n.migrationVersion; | <null> | 1.1 - Live1.0 - For other status |  | 
| 7 | AssessmentItem | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["AssessmentItem"] and n.IL_SYS_NODE_TYPE="DATA_NODE" return count(n), n.IL_FUNC_OBJECT_TYPE, n.status,  n.migrationVersion; | <null> | 1.0 |  | 
| 8 | ItemSet | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["ItemSet"] and n.IL_SYS_NODE_TYPE="DATA_NODE" return count(n), n.IL_FUNC_OBJECT_TYPE, n.status,  n.migrationVersion; | <null> | 1.0 |  | 
| 9 | H5P | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Content", "ContentImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.mimeType IN \["application/vnd.ekstep.h5p-archive"] return count(n), n.IL_FUNC_OBJECT_TYPE, n.mimeType, n.status, n.migrationVersion; | <null> | 1.1 - Live1.0 - For other status |  | 
| 10 | HTML | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Content", "ContentImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.mimeType IN \["application/vnd.ekstep.html-archive"] return count(n), n.IL_FUNC_OBJECT_TYPE, n.mimeType, n.status, n.migrationVersion; | <null> | 1.1 - Live1.0 - For other status |  | 
| 11 | ECML | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Content", "ContentImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.mimeType IN \["application/vnd.ekstep.ecml-archive"] return count(n), n.IL_FUNC_OBJECT_TYPE, n.mimeType, n.status, n.migrationVersion; | <null> | 1.1 - Live1.0 - For other status |  | 
| 12 | Collection | Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Content", "ContentImage", "Collection", "CollectionImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.mimeType IN \["application/vnd.ekstep.content-collection"] return count(n), n.IL_FUNC_OBJECT_TYPE, n.mimeType, n.status, n.migrationVersion; | <null> | 1.1 - Live1.0 - For other status |  | 



Migration versionPossible values for migrationVersion 



|  **Migration Version**  |  **Description**  | 
|  --- |  --- | 
| <null> | Before migration | 
| 0.1 | Node migration failed | 
| 0.2 | Node migration successful but publishing ECAR failed | 
| 0.5 | Node migration Skipped | 
| 1.0 | Node migration successful | 
| 1.1 | ECAR publishing successful | 
| 1.2 | Video streaming successful | 





*****

[[category.storage-team]] 
[[category.confluence]] 

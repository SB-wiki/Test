As part of CSP migration below data will be migrated:


* Graph DB: "appIcon","posterImage","artifactUrl","downloadUrl","variants","previewUrl","pdfUrl"


* Cassandra DB: hierarchy column will be migrated in questionset_hierarchy table.


* None of the external data (Cassandra DB) for Question object will be migrated. media column will continue to use the proxy url (https://domain_name)


* Live Node (Question or QuestionSet) will be republished to have a new ecar bundle





Migration Dependency:


* All Assets (image, audio, video) should be migrated first. For more details, please [refer here](https://knowlg.sunbird.org/learn/product-and-developer-guide/other/data-migration)





Migration Sequence:


1. All Questions (including visibility Parent) should be migrated first.


1. After Successful migration of Questions, QuestionSet migration should be done.

    



Migration Steps:


1. Execute below queries in neo4j graph database and save the output for later reference


    1. Match(n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Question", "QuestionImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.migrationVersion is null return n.IL_FUNC_OBJECT_TYPE as ObjectType,n.status as Status,count(n) as Count;


    1. Match(n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["QuestionSet", "QuestionSetImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.migrationVersion is null return n.IL_FUNC_OBJECT_TYPE as ObjectType,n.status as Status,count(n) as Count;



    
1. Deploy Sync-tool and run below command to migrate the data. Migration Sequence has to be maintained for successful migration. You can execute any command from below table as per requirement (based on data volume). 





| Command | Description | 
| migratecspdata --objectType Question --status Draft,Review,Retired,Failed --delay 2000 | Migrate all Question with status Draft,Review,Retired,Failed | 
| migratecspdata --objectType QuestionImage --status Draft,Review,Retired,Failed --delay 2000 | Migrate all Question with status Draft,Review,Retired,Failed | 
| migratecspdata --objectType Question --status Live --delay 2000 | Migrate all Question with Live status. All Live Question should have final migrationVersion either 1.1 or 0.2 | 
| migratecspdata --objectType QuestionSet --status Draft,Review,Retired,Failed --delay 2000 | Migrate all QuestionSet with status Draft,Review,Retired,Failed | 
| migratecspdata --objectType QuestionSetImage --status Draft,Review,Retired,Failed --delay 2000 | Migrate all QuestionSetImage with status Draft,Review,Retired,Failed | 
| migratecspdata --objectType QuestionSet --status Live --delay 2000 | Migrate all QuestionSet with status Live. All Live QuestionSet should have final migrationVersion either 1.1 or 0.2 | 

3. After migration, Please use below query to confirm the migration

Question: 

Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Question", "QuestionImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.migrationVersion is null return n.IL_FUNC_OBJECT_TYPE as ObjectType,n.status as Status,count(n) as Count;



QuestionSet:

Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["QuestionSet", "QuestionSetImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" and n.migrationVersion is null return n.IL_FUNC_OBJECT_TYPE as ObjectType,n.status as Status,count(n) as Count;

Note: Count should be 0 (Zero), if the migration is successful



To See exact status of migration, Please use below query:

Question: 

Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["Question", "QuestionImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" return n.IL_FUNC_OBJECT_TYPE as ObjectType,n.status as Status,n.migrationVersion as MigrationVersion,count(n) as Count;

QuestionSet:

Match (n:domain) where n.IL_FUNC_OBJECT_TYPE IN \["QuestionSet", "QuestionSetImage"] and n.IL_SYS_NODE_TYPE="DATA_NODE" return n.IL_FUNC_OBJECT_TYPE as ObjectType,n.status as Status,n.migrationVersion as MigrationVersion,count(n) as Count;





Migration Version Details:



|  **migrationVersion**  |  **Description**  |  **Action**  | 
|  --- |  --- |  --- | 
| 1.0 | static url migration done | NA | 
| 1.1 | applicable only for Live Nodes. It means re-publish is successful | NA | 
| 0.1 | static url migration failed because of some error/exception.  | Please check logs of csp-migrator flink job | 
| 0.2 | re-publish operation failed.  | Please check logs of questionset-republish flink job | 
| 0.5 | migration has skipped because of invalid data. | Please take identifier from db and check data using read api. | 



*****

[[category.storage-team]] 
[[category.confluence]] 

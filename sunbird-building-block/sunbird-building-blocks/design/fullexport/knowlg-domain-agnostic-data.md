# Knowlg---Domain-Agnostic-Data

## Introduction

This wiki explains the current format of the absolute path stored in DBs (Neo4J, Cassandra, ES) and the proposed design to make it domain-agnostic.

## Background & Problem Statement

Knowlg uses URL storage in various scenarios to save and access URLs. The metadata of the functional objects stores the references (URLs) of the respective data.

For example, the content object in the Sunbird Knowlg building block stores the URLs of different files in its metadata to refer to the actual content.

#### Key Design Problems

1. Replace usage of absolute URLs in metadata with relative path while storing in DB.
2. While reading the data it should return the absolute path.

## Design

With the above problem statement, it is clear that we should not use the absolute path directly in our databases or any other places. Configure the base path, trim it while storing it, and prefix it while reading.

#### Solution 1:

Trim the URL as a relative path in [**EkStepTransactionEventHandler** ](https://github.com/project-sunbird/knowledge-platform-db-extensions/blob/release-4.1.0/neo4j-extensions/transaction-event-handler/src/main/java/org/sunbird/kernel/extension/EkStepTransactionEventHandler.java)(in knowledge-platform-db-extentions) while storing after generating the logstash events (so ES will have the absolute path and no code changes will be required for ES).

For the returning the absolute path while reading the data from DB, prefix the base path in the following classes based on different repos:

* knowledge-platform: [**GraphService** ](https://github.com/project-sunbird/knowledge-platform/blob/master/ontology-engine/graph-core\_2.11/src/main/scala/org/sunbird/graph/GraphService.scala)(in ontology-engine)
* knowledge-platform-jobs: [**CassandraUtil** ](https://github.com/project-sunbird/knowledge-platform-jobs/blob/master/jobs-core/src/main/scala/org/sunbird/job/util/CassandraUtil.scala), [**Neo4JUtil** ](https://github.com/project-sunbird/knowledge-platform-jobs/blob/master/jobs-core/src/main/scala/org/sunbird/job/util/Neo4JUtil.scala)(in jobs-core)

![](<../../../../Design/FullExport/images/storage/CNAME Knowlg design-Copy of Page-1.drawio.png>)

#### Solution 2:

Instead of trimming the relative path in [**EkStepTransactionEventHandler** ](https://github.com/project-sunbird/knowledge-platform-db-extensions/blob/release-4.1.0/neo4j-extensions/transaction-event-handler/src/main/java/org/sunbird/kernel/extension/EkStepTransactionEventHandler.java), do it in GraphService only. But in this solution, ES data needs to be handled in the search-indexer job. Reading will be same as solution 1.

![](<../../../../Design/FullExport/images/storage/CNAME Knowlg design-Page-1.drawio.png>)

### Pros & Cons

| **Solution** | **Pros**                                                                                                     | **Cons** |
| ------------ | ------------------------------------------------------------------------------------------------------------ | -------- |
| Solution 1   | <ul><li>Code changes will required only in DB layer. No other code/logic changes will be required.</li></ul> |          |

* Hence Trimming the data in TransactionEventHandler so no ES data handling is required separately.

|

* If adopter later wanted to switch from Neo4J to other DB then he need to handle the data trimming part because it is part of TransactionEventHandler.

\| | Solution 2 |

* Code changes will required only in DB layer. No other code/logic changes will be required.
* If adopter later wanted to switch from Neo4J to other DB then he not need to do anything extra.

|

* ES data needs to handle in search-indexer while indexing the data.

|

***

\[\[category.storage-team]] \[\[category.confluence]]

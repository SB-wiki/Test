# Content---external-store-data-restructuring

**Introduction:** This wiki explains the current structure of external store data for content and the proposed changes in the structure to bring consistency.

**Background & Problem statement:**

| Content-Type | Identifier in Neo4J | Identifier in Cassandra | Version 0   | Version 1..10 | Data                                                             |
| ------------ | ------------------- | ----------------------- | ----------- | ------------- | ---------------------------------------------------------------- |
| ECML         | do\_123             | do\_123                 | Draft, Live | Live          | Draft and Live version object have the same format for the data. |
| do\_123.img  | do\_123.img         |                         | Draft       |               |                                                                  |
| Collection   | do\_123             | do\_123.img             | Draft       |               | Draft version will not have the root-object metadata.            |
| do\_123      | do\_123             | Live                    | Live        |               |                                                                  |
| do\_123.img  | do\_123.img         |                         | Draft       |               |                                                                  |

**Design:** **Option 1:**

| Content-Type | Identifier in Neo4J | Identifier in Cassandra | Version 0   | Version 1..10 | Data                                                             |
| ------------ | ------------------- | ----------------------- | ----------- | ------------- | ---------------------------------------------------------------- |
| ECML         | do\_123             | do\_123                 | Draft, Live | Live          | Draft and Live version object have the same format for the data. |
| do\_123.img  | do\_123.img         |                         | Draft       |               |                                                                  |
| Collection   | do\_123             | do\_123                 | Draft, Live | Live          | A draft version will not have the root-object metadata.          |
| do\_123.img  | do\_123.img         |                         | Draft       |               |                                                                  |

**Implementation Changes**

1. Get hierarchy API for Live version(without mode=edit) should validate status in Cassandra data and throw resource not found if status is not part of hierarchy data
2. In publish pipeline, read data from neo4j and based on identifier from neo4j, fetch hierarchy data from Cassandra
3. Migrate hierarchy data of draft collection content which does not contain pkgVersion in it.

**Option 2:**

| Content-Type | Identifier in Neo4J | Identifier in Cassandra | Version 0 | Version 1..10 | Data                                                             |
| ------------ | ------------------- | ----------------------- | --------- | ------------- | ---------------------------------------------------------------- |
| ECML         | do\_123             | do\_123                 |  Live     | Live          | Draft and Live version object have the same format for the data. |
|              | do\_123.img         | do\_123.img             | Draft     | Draft         |                                                                  |
| Collection   | do\_123             | do\_123                 |  Live     | Live          | A draft version will not have the root-object metadata.          |
| do\_123.img  | do\_123.img         | Draft                   | Draft     |               |                                                                  |

**Implementation Changes**

1. Changes required to store draft version in external store for create, update and read contents
2. Publish pipeline changes to read ECML draft only from do\_id.img
3. Migrating all draft ECML content with do\_id.img

***

\[\[category.storage-team]] \[\[category.confluence]]

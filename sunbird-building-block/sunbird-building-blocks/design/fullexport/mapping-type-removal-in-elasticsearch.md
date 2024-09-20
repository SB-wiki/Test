# Mapping-type-removal-in-Elasticsearch

#### Problem Statement

[Mapping types has been deprecated in Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/master/removal-of-types.html) and are up for complete removal in future releases. To accommodate this, There are changes required in ES and Sunbird since currently we are using and maintaining mapping types.

#### Solution Approach&#x20;

According to official documentation from ES it suggests two approaches to remove mapping types

1. Using a custom type and maintaining single index as it is currently
2. Having a separate index for each type object.
3. In addition to that there could be a third approach which works as hybrid of both the above approach. the least searched and less number of data can be stored with custom types, however vastly used data can have indexes of it's own. This way it would be able to use the best of both world.

Pros and Cons

| Approach          | pros                                                                                                                                                                                                                      | cons                                                                                                                          | remarks                                                                                                     |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| using custom type | less changes required on sunbird sidewould not have unnecessary large number of shardscan be used for composite search across types                                                                                       | can have conflict of field type between objects of different typeslarge shard size affects performance (more than 30GB/shard) | migration with sync api                                                                                     |
| separate indexes  | better search performance (since all document represents same entity)can have different settings on different indexessolves the issue of different object type having different field types                               | can have large cluster state on each ES node.There is a limit on primary shards in a cluster                                  | migration with [reindex api](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/docs-reindex.html) |
| Hybrid            | provides a balanced approach to use separate indexes for dense document.the number of shards can be controlled by having less used or less complicated objects being stored all in same index with different object types | comparatively complex to implement from sunbird side                                                                          |                                                                                                             |

Based on approach chosen, there should be migration of data on the Elasticsearch.

#### References

1. [https://www.elastic.co/guide/en/elasticsearch/reference/master/removal-of-types.html](https://www.elastic.co/guide/en/elasticsearch/reference/master/removal-of-types.html)
2. [https://www.elastic.co/blog/how-many-shards-should-i-have-in-my-elasticsearch-cluster](https://www.elastic.co/blog/how-many-shards-should-i-have-in-my-elasticsearch-cluster)
3. [https://www.elastic.co/guide/en/elasticsearch/reference/6.3/docs-reindex.html](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/docs-reindex.html)

***

\[\[category.storage-team]] \[\[category.confluence]]

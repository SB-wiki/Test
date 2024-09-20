# Indexing-Content-Model-to-Druid

**Introduction:** In this wiki, we are going to discuss methods to index Content model to Druid and its challenges. Since the content model is not time series data, updating the indexed data in Druid is not possible and this would pose challenges to query data, we will discuss more on this in the following sections.

1. Content Data Model
2. Index using transaction logs from Kafka
3. Index using Elasticsearch Snapshot

**1. Content Data Model:** Below table has content model fields that are being indexed. (Content model has more fields than the list below. For simplicity, we have chosen some of the required fields which is useful)

| Sno. | fields                           | Data Type | field in Druid                   |
| ---- | -------------------------------- | --------- | -------------------------------- |
| 1    | author                           | String    | author                           |
| 2    | badgeAssertions.assertionId      | String    | badgeAssertions\_assertionId     |
| 3    | badgeAssertions.badgeClassId     | String    | badgeAssertions\_badgeClassId    |
| 4    | badgeAssertions.badgeClassImage  | String    | badgeAssertions\_badgeClassImage |
| 5    | badgeAssertions.badgeClassName   | String    | badgeAssertions\_badgeClassName  |
| 6    | badgeAssertions.badgeId          | String    | badgeAssertions\_badgeId         |
| 7    | badgeAssertions.createdTS        | String    | badgeAssertions\_createdTS       |
| 8    | badgeAssertions.issuerId         | String    | badgeAssertions\_issuerId        |
| 9    | badgeAssertions.status           | String    | badgeAssertions\_status          |
| 10   | board                            | String    | board                            |
| 11   | channel                          | String    | channel                          |
| 12   | compatibilityLevel               | String    | compatibilityLevel               |
| 13   | contentType                      | String    | contentType                      |
| 14   | createdBy                        | String    | createdBy                        |
| 15   | createdFor                       | String    | createdFor                       |
| 16   | createdOn                        | String    | createdOn                        |
| 17   | creator                          | String    | creator                          |
| 18   | dialcodes                        | String    | dialcodes                        |
| 19   | framework                        | String    | framework                        |
| 20   | gradeLevel                       | String    | gradeLevel                       |
| 21   | identifier                       | String    | identifier                       |
| 22   | keywords                         | String    | keywords                         |
| 23   | language                         | String    | language                         |
| 24   | lastPublishedBy                  | String    | lastPublishedBy                  |
| 25   | lastPublishedOn                  | String    | lastPublishedOn                  |
| 26   | lastSubmittedOn                  | String    | lastSubmittedOn                  |
| 27   | lastUpdatedBy                    | String    | lastUpdatedBy                    |
| 28   | lastUpdatedOn                    | String    | lastUpdatedOn                    |
| 29   | license                          | String    | license                          |
| 30   | mediaType                        | String    | mediaType                        |
| 31   | medium                           | String    | medium                           |
| 32   | mimeType                         | String    | mimeType                         |
| 33   | name                             | String    | name                             |
| 34   | objectType                       | String    | objectType                       |
| 35   | organisation                     | String    | organisation                     |
| 36   | origin                           | String    | origin                           |
| 37   | owner                            | String    | owner                            |
| 38   | pkgVersion                       | Long      | pkgVersion                       |
| 39   | resourceType                     | String    | resourceType                     |
| 40   | status                           | String    | status                           |
| 41   | subject                          | String    | subject                          |
| 42   | topic                            | String    | topic                            |
| 43   | me\_audiosCount                  | longSum   | me\_audiosCount                  |
| 44   | me\_averageInteractionsPerMin    | doubleSum | me\_averageInteractionsPerMin    |
| 45   | me\_averageRating                | doubleSum | me\_averageRating                |
| 46   | me\_averageSessionsPerDevice     | doubleSum | me\_averageSessionsPerDevice     |
| 47   | me\_averageTimespentPerSession   | doubleSum | me\_averageTimespentPerSession   |
| 48   | me\_avgCreationTsPerSession      | doubleSum | me\_avgCreationTsPerSession      |
| 49   | me\_creationSessions             | longSum   | me\_creationSessions             |
| 50   | me\_creationTimespent            | doubleSum | me\_creationTimespent            |
| 51   | me\_hierarchyLevel               | longSum   | me\_hierarchyLevel               |
| 52   | me\_imagesCount                  | longSum   | me\_imagesCount                  |
| 53   | me\_timespentDraft               | doubleSum | me\_timespentDraft               |
| 54   | me\_timespentReview              | doubleSum | me\_timespentReview              |
| 55   | me\_totalComments                | longSum   | me\_totalComments                |
| 56   | me\_totalDevices                 | longSum   | me\_totalDevices                 |
| 57   | me\_totalDialcodeAttached        | longSum   | me\_totalDialcodeAttached        |
| 58   | me\_totalDialcodeLinkedToContent | longSum   | me\_totalDialcodeLinkedToContent |
| 59   | me\_totalDownloads               | longSum   | me\_totalDownloads               |
| 60   | me\_totalInteractions            | longSum   | me\_totalInteractions            |
| 61   | me\_totalRatings                 | longSum   | me\_totalRatings                 |
| 62   | me\_totalSessionsCount           | longSum   | me\_totalSessionsCount           |
| 63   | me\_totalSideloads               | longSum   | me\_totalSideloads               |
| 64   | me\_totalTimespent               | doubleSum | me\_totalTimespent               |
| 65   | me\_videosCount                  | longSum   | me\_videosCount                  |
| 66   | timestamp                        | Long      | timestamp                        |
| 67   | version                          | Long      | version                          |
| 68   | programId                        | String    | programId                        |
| 69   | type                             | String    | type                             |
| 70   | category                         | String    | category                         |
| 71   | learningOutcome                  |           | learningOutcome                  |
| 72   | qumlVersion                      | Long      | qumlVersion                      |
| 73   | bloomsLevel                      |           | bloomsLevel                      |
| 74   | rejectComment                    | String    | rejectComment                    |

**2. Index using Transactional logs from Kafka:**

![](<../../../../Design/FullExport/images/storage/Untitled Diagram.png>)

The idea here is to index the snapshot of Content model initially and append the updated records using the transactional logs(learning graph events) from Kafka which is generated by Learning platform when content is modified/created/removed. Here, the index field would be createdOn. With this approach, querying becomes highly difficult due to multiple versions of the same record created by the update operation.

we can overcome the query problem when an existing record is indexed using Druid's [First/Last Aggregator](http://druid.io/docs/latest/querying/aggregations) but this requires a metric field to be populated (for instance, status field need to transform into `status_metric` field) to get the recently updated record based on timestamp. This also requires the query to be intercepted and add first/last aggregation to work on the recent records otherwise it would fetch all the versions of the same records.  This approach is tedious and error-prone due to the above-mentioned problem.

**Pros:**

1. Maintenance is less since we are using a streaming job to index the data.
2. Consistent state of data.

**Cons:**

1. Multiple versions of the same record, which is less useful as it grows.
2. Creates a lot of partition within a segment due to modifications.
3. Difficult to query due to multiple versions of the same record. &#x20;

**3. Index using Elasticsearch Snapshot:**

![](<../../../../Design/FullExport/images/storage/Untitled Diagram-Page-2.png>)

Here the approach is to take the snapshot of the content model index from Elasticsearch and populate it into Druid. This is a one-time activity and it should be done periodically (for instance, daily once) to keep the state of the data consistent. Here the index field would be `timestamp` (time captured when the script starts to execute) .we can delete the older snapshots indexed to Druid during indexing which is not useful.&#x20;

Time taken to create a snapshot from Elasticsearch index < **1min**

Time taken to ingest **493k** records (compositesearch index) is < **5min**

**Re-indexing:**  Periodically, we have to replace the Druid datasource with a new content snapshot. We can delete the old datasource from Druid and create a new Datasource with a fresh copy of content model snapshot.

**Pros:**

1. Creates only one segment since it is a batch index
2. No multiple versions of the same records created.
3. querying is easy and performant.

**Cons:**

1. It is a Batch operation.

**Conclusion:** we have tried out both the approach (2 & 3) and found that indexing transactional logs(2) require more work to make it easy to query from superset or from the Druid API and also it creates a lot of segments and partitions which might lead to slower query response. We are going ahead with the 3rd approach which is indexing content model snapshot from the script because of the advantages mentioned above.

***

\[\[category.storage-team]] \[\[category.confluence]]

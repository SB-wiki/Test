# Design-Brainstorm--Migrating-all-the-content's-previewUrl-to-streamingUrl-based-on-the-mimeType

**Introduction:** Video file of all the content with mimeType:video, is streamed and uploaded into cloud store. The streamed file url is getting updated into _**streamingUrl**_  field of content metadata.

**Background & Problem Statement:**

As part of video streaming implementation, the video file of the video content will be streamed and stored into cloud store. The respective url will be updated into content metadata as `streamingUrl`. Generation of stramingUrl is evoked as part of publish activity and all the contents which gets published will have stramingUrl and already published content will not have stramingUrl.

For all the video content streamed video should be generated and updated into its streamingUrl property. For other types of resource content streamingUrl should be updated with previewUrl.

**Proposed Design:**

#### Option I:

Since streamingUrl implementation is part of publish activity and we already have republish mechanism, all the content can be republished.

Pros:

* The complete implementation is already available and tested.

Cons:

* Expensive (heavy load on publish pipeline) and time consuming process.
* Only Live content can be republished. Modified live content will not be updated with the streamingUrl until it is not republished again.

#### Option II:

Utilising already implemented SyncTool feature. Write a command method, that will:

* read all the contents from Neo4j (based on specified filter criteria)
* for all the **none video contents** - update the _**streamingUrl = previewUrl**_
* for all the video contents - insert respective entry for the specified content into cassandra table, so that spark job will take the data for _**stream processing**_ .
* Based on the content id, we can fetch the current status of the streaming -  _**stage, stage\_status, status**_

_Command for generating or migrating streamingUrl:_

**stream --mimetype (all / specific mimeType) --offset (val) --limit (val)**

**Perform the respective operation based on mimeType**

* **migration of previewUrl to streamingUrl - for non video**
* **pushing the content data in cassandra table for stream generation**

_**stream --ids**_

**Perform the respective operation based on mimeType of the respective contentId**

_**streamstatus --status (all / status value)**_

**Return the list of entries into cassandra table with specified status.**

_**streamstatus --ids**_

**Return the stream status of the the specified content**

***

\[\[category.storage-team]] \[\[category.confluence]]

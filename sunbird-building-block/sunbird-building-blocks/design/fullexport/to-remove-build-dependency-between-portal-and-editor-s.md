# To-remove-build-dependency-between-Portal-and-Editor(s)

### Introduction:

This document is an approach note to remove the build dependency between the sunbird portal and Sunbird Content Editors. This document will describe the design approach to decouple the Portal and Editor(s) build process.

### Background:

Presently Sunbird Editors \[ Content-editor, Collection-editor, and Generic-editor] build has a dependency on Portal build which is a time-consuming and unnecessary activity.

Jira Issue: [https://project-sunbird.atlassian.net/browse/SB-19080](https://project-sunbird.atlassian.net/browse/SB-19080)

_Existing Build Process:_

1. Editor build artifact stores in blob storage as a compressed file
2. Portal build process downloads that artifact compressed file, uncompress it and stores it as it’s own artifact
3. portal consumes these editors from its own file system which is currently being generated from portal’s gulp task

![](<../../../../Design/FullExport/images/storage/Untitled Diagram (1).png>)

### Problem Statement:

To deploy Editor(s ) we have to deploy Portal as well. Most of the time developers tend to miss doing this step and spend time figuring out the root cause.

### Key design problems:

Editor(s) build has to complete and the portal should be using the latest codebase without redeployment.

### Design:

We need to change the build and consumption process of content Editor(s) so that Editor(s) can be built independently and the portal can consume without a rebuild.

### Approach-1

**Proposed build process:**

1. Define Azure blob storage for each Editor.
2. Each Editor’s uncompressed build artifacts stores in respective Azure blob storage
3. Every build will replace the generated artifact in the respective Azure blob storage
4. Editor’s uncompressed build should be available for the portal to consume.
5. We can set the editor(s) endpoint as an environment variables
6. Portal / Devices will use environment variable values as a source/ Endpoint and always loads the editor(s) from this endpoint

![](<../../../../Design/FullExport/images/storage/Untitled Diagram (2).png>)

#### Pros:

1. No dependency on the build process.
2. Reduce the total build time by 70%.
3. It even reduces build steps for the Portal, where they need to run the Gulp task to download and uncompress editor(s) zip.

#### Cons:

1. If we need to use a particular version of editor(s) we need to build it to use in the portal.

***

\[\[category.storage-team]] \[\[category.confluence]]

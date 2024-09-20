# Support-for-Video-as-Asset

### Introduction

This wiki explains the provisioning of video (mp4) file as asset.

### Background

Currently there is a provision for uploading image and other types of files as an asset. But only for image we enrich metadata using imageTagging job.

For video asset, we don't provide any specific metadata like, thumbnail, size, duration etc.

As per the current requirement, we need to enrich the video asset with the above mentioned metadata as well.

### Problem Statement

Enrich video asset with technical details like, thumbnail (auto generated), size, duration, etc.

### Metadata to be enriched for Video Content:

* Thumbnail
* Size
* Duration

### Proposed Design:

Option I:

* Using FFmpegFrameGrabber API we can break the video into multiple frames and generate thumbnail, frame rate, format.
* These details can be generated and update to content metadata at:
  * Upload API layer

Option II:

* Using FFmpegFrameGrabber API we can break the video into multiple frames and generate thumbnail, frame rate, format.
* These details can be generated and update to content metadata at:
  * Samja job
  * Rename **ImageTagging**  job with **AssetEnrichment**  job
  * Handle asset enrichment according to mimetype.

***

\[\[category.storage-team]] \[\[category.confluence]]

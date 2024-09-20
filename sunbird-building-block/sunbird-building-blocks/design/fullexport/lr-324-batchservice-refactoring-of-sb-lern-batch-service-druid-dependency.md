# LR-324--BatchService--Refactoring-of-SB-Lern-Batch-Service---Druid-Dependency

## Introduction

This wiki explains how to decouple Druid service calls by using the Sunbird-Obsrv API service.

## Background & Problem Statement

Currently, the LERN Batch Service connects directly to the Druid data store to fetch collection summary aggregate data using a druid query on the "audit-rollup-syncts" and "telemetry-events-syncts" data sources. This direct connection creates tight coupling between the LERN Batch Service and the Druid data store. The new design proposes to decouple this connection by using the API service owned by obsrvBB.

![](<../../../../Design/FullExport/images/storage/decoupling druid diagram.drawio.png>)

## Design

To achieve the goal of decoupling the above Druid calls, we propose the following solution:

**Solution 1:**

We can call the new API service designed by obsrvBB by building the required request payload in the LERN Batch Service. This API service will then connect to the Druid data store to query "audit-rollup-syncts" and "telemetry-events-syncts" data sources and return the collection summary aggregate data as a response to the LERN Batch Service. This response can then be used for further computations.

![](<../../../../Design/FullExport/images/storage/decoupling druid diagram.drawio (1).png>)

***

\[\[category.storage-team]] \[\[category.confluence]]

# Root-Org-Content-Management

### Background

* By default, Sunbird's content store is EkStep's global content repository.
* All content residing in the global content repository is licensed under Creative Commons CCBY license
* The content repository is shared by all Sunbird instances.
* Each Sunbird instance may have one or more root orgs, which are mapped to an EkStep channel
* Searching or browsing accesses content from all channels by default
* Content is indexed using a content model and additionally using framework metadata specific to a Sunbird root org
* Important attributes of the content model are the
  * contentType, which is an enumeration of logical content types: Resource, Lesson Plan, Collection, Book or Course
  * resourceType, a sub-enumeration of the Resource contentType
  * mimeType, an enumeration of physical content types: jpg, mp4, html

### Filtering

Content discovery in Sunbird is not limited to a single channel. Access to a global, shared content repository is a valuable consideration for adoption of Sunbird.

However, given the diversity of content across channels, it is not always the case that content published in channel A is meaningful to the users of channel B. To enable content to be filtered for relevance, Sunbird allows changing the default behaviour to restrict content discovery to one's own channel.

### Single Channel Filter

To enable a single channel filter, a Sunbird adopter is required to make the following changes.

Set environment variableEdit, ansible/roles/stack-sunbird/templates/sunbird\_player.env and set the variable sunbird\_content\_channel\_filter\_type=self&#x20;

Use Page APIs to add a channel filterMake a call to api/data/v1/page/section/update to change the each of search queries used to generate the page sections.

```
"request": {

  "display": "{\"name\":{\"en\":\"Latest Courses\",\"hi\":\"????????\"}}",

  "alt": null,

  "description": null,

  "sectionDataType": "course",

  "imgUrl": null,

  "searchQuery": <search query>,

  "name": "Latest Courses",

  "id": "01228382278062080019",

  "status": 1

}
```

The searchQuery is of the form (serialised to a string):

```
"request": {

  "filters": {

    "contentType": \["Course"],

    "channel": \["<channel_id>"],

    "objectType": \["Content"],

    "status": \["Live"]

  },

  "sort_by": {

    "lastPublishedOn": "desc",

    "limit": 10

  }

}
```

#### Limitations

While single channel filtering allows restricting non-relevant content from appearing in a given Sunbird instance, it is an all-or-nothing approach.

1. Implementing this filter denies access to content from any channel which might be relevant.
2. By applying the filter at the Page section level, the likelihood of inconsistent content views within the application is greater.
   1. There are multiple content discovery points within an instance,
   2. if any one is not configured with the appropriate filters, then there will be inconsistencies in what content people can view across the application
3. By applying the filter through instance configuration, all root orgs within the instance are subject to the same limitation.
   1. changing the filters would affect all root orgs and thus
   2. have increased co-ordination costs

### Extended Filtering

To relax the limitations of single channel filtering and to give greater control over content to a root org, an extended filtering approach should provide:

1. Granular filtering allowing for a middle-ground between single channel vs all channels
2. Composition of whitelist and blacklist rules to define more expressive filters (eg to remove only one channel with whitelist rules would require enumerating all other channels explicitly)
3. Creating rules using metadata beyond the channel (eg: to include only video content, or to exclude Lesson Plans)
4. Root org specific filtering rules which allows each root org to control its content independently of other root orgs

The approach to providing an extended filtering capability follows three dimensions. First, a unified configuration removes the need for both environment variables and API calls consolidates configuration to a single point. Second, the use of query composition extends the current method of augmenting search queries. Third, the creation of root org settings allows for joint and independent configuration of org behaviours.

#### Unified Configuration from Environment Variables

We currently use the configuration variable sunbird\_content\_channel\_filter\_type=self and a series of API calls to api/data/v1/page/section/update with the channel-id to configure the content filters. For extended filtering we replace this variable with

1. sunbird\_content\_filter\_channel\_whitelist=,,...,

From this single configuration, the appropriate search query for the Page sections can be constructed by adding an interceptor at the content service.

At present the config provides positive filters to whitelist content with a given channel-id. Extend this behaviour to include negative filters to blacklist content with given channel-ids

1. sunbird\_content\_filter\_channel\_blacklist

Opt Out of DefaultsTo simplify configuration, switch the page setup to be opt-out in place of an opt in. If a channel whitelist is configured, all content searches will use the whitelist. However, if a page section should not use the default whitelist, an API call to api/data/v1/page/section/update is made to opt out.

```
"request": {

 "display": "{\"name\":{\"en\":\"Latest Courses\",\"hi\":\"????????\"}}",

 "alt": null,

 "description": null,

 "sectionDataType": "course",

 "imgUrl": null,

 "defaultSearchFilters": false,

 "name": "Latest Courses",

 "id": "01228382278062080019",

 "status": 1

}
```

#### Search Query Composition via Content Service Interceptor

The search query executed by the content service provides a single point where instance filters can be composed with the default search queries.

We also need to add the ability to whitelist and blacklist based on contentType, resourceType mimeType and framework. To enable this, introduce additional configuration entries can be provided to the searchComposer from a config service. These additional entries can expose the expressivity of the content search APIs via a JSON based configuration.

1. sunbird\_content\_filter\_framework\_whitelist
2. sunbird\_content\_filter\_framework\_blacklist
3. sunbird\_content\_filter\_contenttype\_whitelist
4. sunbird\_content\_filter\_contenttype\_blacklist
5. sunbird\_content\_filter\_resourcetype\_whitelist
6. sunbird\_content\_filter\_resourcetype\_blacklist
7. sunbird\_content\_filter\_mimetype\_whitelist
8. sunbird\_content\_filter\_mimetype\_blacklist

One or more of these filters may be set. During content searches, the values of these filters are read and appended to the search queries as additional filters. The change made above to switch page sections from opt-in to opt-out also applies here. If a page section does not have "defaultSearchFilters": false set, append the filters to the search queries.

#### Root Org Filters

To relax the limitation of the configuration being applied at the instance level use root org settings.

1. A given root org can be updated to change any of the above filter settings.
2. If a setting is absent at the org level, it is inherited from the instance level
   1. This also applies to the page section defaultSearchFilter setting.
   2. It can be set for a root org or for the instance
   3. If it is not set, it inherits from the instance
   4. If not set at the instance, the default behaviour is opt-in

#### Test Scenarios

Unit tests will work by asserting that the query generated at the content service matches the expected query based on the configuration.

Integration tests will work against known datasets in QA to ensure that the search results match the expectations.

Scenarios

1. Config entry is missing&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

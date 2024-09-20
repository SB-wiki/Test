# Ownership-of-Aggregate-content-(course,-collection,-book)

### Introduction

This wiki explains the design and implementation to provide attributions to the entities to whom it belongs to.

### Background

When a content is created it has three metadata properties which point to the entities involved in creating the content

* createdBy – the is the id of the user who created the content
* creator – the name of the user who created the content
* createdFor – this is the id of the organization which the user belongs to when creating the content
* organisation – an array of organization names (not IDs)
* channel – this is the channel to which the creator belongs at the time when the creator last edited the content
* ownershipType -  an array which has the value of createdBy or createdFor

### Problem Statement&#x20;

As of now, the text that is displayed when a content is created only attributes to the creator.

This design proposes solutions to make sure the followings are handled

1. Display text to attribute content to either the individual creator or to the creator's organization.
2. Content which aggregates other content pieces to automatically attribute the entities who created those items.
3. Content copy to attribute the source of the content where it was copied from.

![](<../../../../Design/FullExport/images/storage/Untitled Diagram (1).jpg>)

### Solution 1 - Using the framework level FormAPI

Sunbird portal, going forward, will give property organisations inside users objects in the window.context.

![](<../../../../Design/FullExport/images/storage/Screen Shot 2018-10-03 at 11.11.12 AM.png>)

and when the content is created two new properties will be created based on what the creator is choosing from the owner dropdown.

1. owner -  name of the person/organization
2. ownedby - the id of the owner

With the already available information about the collection/course, (createdBy, creator, createdFor, organization, channel, ownershipType), one more property will be created and added to the content model.

1. content-credits -  it will be an array of objects with each id (Id of user or org) `name` (name of user or org) and `type` (user/organisation)

It will have the following object structure:-

![](<../../../../Design/FullExport/images/storage/Screen Shot 2018-10-03 at 11.24.00 AM.png>)

MOM with @santhosh(19th September’18):

Suggestions:

1. Add ownershipType in editor template (like name and description) and need not depend on FormAPI.
2. Plugins added as content will not be considered&#x20;

Cons: If the owner property is not present in any of the resource that is being added, then the attribution will not be given to that particular resource.&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

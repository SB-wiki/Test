# Modifying-a-Primary-Category---impact-on-modifying-an-existing-content

When an existing content is being modified, the questions are:

* What should be the logic used by the system to open the Editor?
* What should be the logic used by the system to display the attributes for modification?

If there is no change in the definition of Primary Category, there is no problem. The issue is in the case if the definition of Primary Category is changed.&#x20;

**Modification of a Primary Category - impact on Modifying an existing content**

**Scenario 1: Primary Category is deleted** &#x20;

Ideally this should not happen. In case for some reason, a primary category has to be deprecated, we should not allow creation of that primary category, but the definition of it cannot be deleted. For this, following should be enabled:

There should be an option at system and tenant level to configure a list of primary categories to be used when creating new content. This has multiple benefits. It gives flexibility to the tenants to show a subset of supported primary categories. It also enables deprecation of a primary category, without deleting its definition.

**Scenario 2: Primary Category name is modified** &#x20;

I think changing a name will be an issue because the existing content will still continue with the old name. We will then end up with a lot of unnecessary category names in the system. Else, each time the name is changed, we need to modify all the existing content with the new name. Unless there is any other tech soln. for this, we need to do this.

When the Primary category name is changed, if all existing content is updated with the new name, there is no issue for editing the existing content.

**Scenario 3: User Attributes modified in Primary Category**

These are the attributes modifiable by the user - for example Name, Description, Audience Type etc.

In this scenario, Editor should display as per the user attributes configured in the primary category configuration (latest).&#x20;

Due to the changes in user attributes, there may be some user attributes that are modifiable earlier are no longer modifiable (don't show up in the editor) OR some existing attributes that were not modifiable by the user earlier (system attributes), become visible in the editor for the user to modify OR there might be new user attributes defined that become visible in the editor.

**Scenario 4: System Attributes modified in Primary Category**

These are the attributes set by system and not exposed to users to set explicitly - for example mime-type, trackability etc.

This is the most tricky case. I am not sure what are the use cases that might require this modification.&#x20;

In this case the existing content even after modification should continue to have the values whatever were set during the earlier creation and should not be changed.&#x20;

If there are new System attributes added to the primary content category, what should be done? Even in this case I don't think they should be set with the new attributes.&#x20;

**Summary**

In any of the above scenarios, **editing of a content cannot change its primary category** .

The logic for editing can be:

* Use system attributes stored in the object to launch the editor
* System attributes are not modified through editing, even if there is a change in their configuration.
* System shows the user modifiable attributes (as per the current primary category configuration) in the Editor for users to modify

***

\[\[category.storage-team]] \[\[category.confluence]]

# Content-updates-from-within-the-SunbirdEd-desktop-app

As a teacher,

I want to be able to update content to the latest on the SunbirdEd desktop app

So that I can use the content to teach in class.&#x20;

**Context**

Content is updated from time to time on the platform - new content is added to a textbook or new chapters may sometimes be added. A user can receive the updates when they are online through the app directly, or via a pendrive if they are in a purely offline scenario.&#x20;

**Scenarios**

* Given a user content in their library, when there is an update available for one or more content pieces (for either the textbook or the content piece itself), then she is shown a notification that there are updates available.
* When she opens the set of notifications, she is shown all the content for which updates are available - and she can choose to update all of them at once or one by one.&#x20;
* As she updates the content, she is shown the progress of the content updates - and the final status as to whether this succeeded or failed.&#x20;
* She is also shown a banner if she opens a textbook with one or more content pieces available for updates.&#x20;
* If a user has a pendrive with the same content as what is already in the app - and she tries to import the content, then
  * If the content on the pendrive is older than the content on the app, she is shown a message warning her that she is trying to overwrite the content that she already has - and she can choose to either proceed or cancel.&#x20;
  * If the content on the pendrive is newer than the content on the app, then the content in the app is automatically replaced.&#x20;

**Alternate scenarios**

* If the user updates the content to an older version using the pendrive, then when she is online - she will still be shown a notification that the latest content is available, and she can upgrade the content.&#x20;
* If a content undergoes multiple rounds of updates, and she has a very old version of the content which is incompatible with the latest content - then there should be an error message saying the content couldn't be updated (this is a rare scenario - so we're ruling it out as a problem to be solved right now).&#x20;

**Wireframes**

[https://projects.invisionapp.com/d/main#/console/18158205/377119808/preview](https://projects.invisionapp.com/d/main#/console/18158205/377119808/preview)

***

\[\[category.storage-team]] \[\[category.confluence]]

# Allow-a-user-to-resume-the-course-from-the-exact-point-where-they-left-off-(mobile-app-+-portal)

**As a** teacher

**I want to** be able to pick up from where I left off in the course

**So that** I can complete the course on time.&#x20;

**Context**

One of the biggest pieces of feedback that we've received from the ground is that users have limited time available to complete courses online, and the limitation they find with taking it online is the inability to continue the course from where exactly they left off. The resume button today takes them to the resource that they last saw, but it doesn't continue from the last point in that resource. This leads to them having to forward through the content, which they find to be tedious every time they start again.&#x20;

**Acceptance criteria**

_**Main Scenario**_

As users taking the course on the mobile app or portal

\*\*Given \*\* I am a user who is playing a video in the course **When** I didn't finish the video, but I exited the course and I come back to resume **Then**  I can watch the video from the exact point where I last left off.&#x20;

\*\*Given \*\* I finish the video completely and exit the course **When** I resume the course \*\*Then \*\* I am shown the next piece of content in the course.&#x20;

**Given** I have played a video upto a certain point in the course **When** I click on the video from the course TOC \*\*Then \*\* I can watch the video from where I last left off.&#x20;

_**Alternate scenario**_

\*\*Given \*\* I have finished watching a video in the course completely

**When** I restart the video and leave it at a certain point

**Then**  my course progress counts that video as being watched (as I have watched it upto the min. criteria the first time)&#x20;

But when I click on that video from the TOC, I can watch the video from the exact point where I last left off in my latest attempt.&#x20;

**Given** I have watched multiple content in the course to certain points (without finishing them)&#x20;

**When** I select the option to resume course

**Then** I am taken to the latest video that I watched from where it left off in my last attempt. I can always access the other videos from where I left off from the course TOC.&#x20;

**Metrics Requirements**

We'd need to capture telemetry events indicating

1. At what point in the content (time or slide number) the user left off. This is to allow us to figure out statistics around course content quality - metrics like what is average point of dropoff across users for this specific content.
2. The fact that user resumed the content, and the source from where they resumed (course card, course TOC page, or from the TOC directly by clicking on a particular content)&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

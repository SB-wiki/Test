# Providing-visual-feedback-to-users-for-online-only-content

**As** a teacher

**I want to** know that I'm downloading or attempting to play online-only content

**So that** I'm aware that it can't be used in offline environments.&#x20;

**Context**

The SunbirdEd offline app can be used in both online and offline modes. Many content providers tend to create online-only content (like youtube), which can only be used in the online mode. Users need to be appropriately warned that they are downloading online-only content, and also that they are attempting to play online-only content if they are offline or have low bandwidth.&#x20;

**Acceptance Criteria**

GIVEN I am on the desktop app&#x20;

WHEN I attempt to download an individual content or a textbook which has online-only content&#x20;

THEN I am shown a message that the content I'm trying to download has content that can only be played online.&#x20;

GIVEN I am on the offline library section of the desktop app

WHEN I view content cards that contain online-only content

THEN I am shown some sort of visual indicator that the content card has online-only content.&#x20;

GIVEN I am on the offline library section of the desktop app and I am offline&#x20;

WHEN I attempt to play content that requires an internet connection

THEN I am shown a message that the content cannot be played offline, and that I need to be connected to the internet.&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

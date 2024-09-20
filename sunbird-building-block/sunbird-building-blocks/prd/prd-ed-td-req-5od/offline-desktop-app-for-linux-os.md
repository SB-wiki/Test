# Offline-desktop-app-for-Linux-OS

[SB-12220 System JIRA](https://browse/SB-12220)

Around 20% of schools which have a laptop or desktop seem to have Linux as an operating system, and some of the upcoming state tenders seem to show that the pervasiveness of Linux OS is going to increase with time. Hence, the SunbirdEd offline desktop app needs to be packaged and available for Linux OS.&#x20;

**Frequent OSes found**

* Ubuntu 16.04(min cases) -18.04(most cases)
* Suse Linux&#x20;
* Bose Linux

**Min H/W config**

2GB RAM, i3 processor, 128GB HDD

Acceptance CriteriaGIVEN I am on the desktop version of the portal WHEN I see a banner that the desktop app is available and I click on it THEN I should be able to see the Linux installer along with the windows installer.&#x20;

GIVEN I download the desktop app WHEN I try to install it and my machine meets the minimum requirements (OS compatibility check only) THEN I should be able to complete the installation, and the app should launch.&#x20;

GIVEN I download the desktop app WHEN I try to install it and my machine doesn't meet the minimum requirements (OS compatibility or there isn't sufficient space on my machine to even install the app) THEN I should be shown an error message. This will be an OS generated message, not app-specific.&#x20;

All other functionality should work as-is with the desktop version of the app.&#x20;

Scope

* Package the SunbirdEd app for Linux OS.&#x20;
* The user should be able to install the app if their machine meets all the necessary min. requirements.&#x20;
* Host the Linux based installer on the web portal, along with the windows installer (appropriate text changes to be made available to support Linux based app).

***

\[\[category.storage-team]] \[\[category.confluence]]

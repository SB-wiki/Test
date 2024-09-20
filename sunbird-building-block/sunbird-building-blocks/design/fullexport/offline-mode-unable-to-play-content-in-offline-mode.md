# \[Offline-mode]-Unable-to-Play-content-in-offline-Mode

### Introduction:

This wiki page explains the design changes to integrate content-player in mobile(with ionic 4 changes)

Issue ID:- [SB-14688 System JIRA](https://browse/SB-14688)

Background: Mobile code is updating the code to Ionic 4. With this update, file system can't accessible directly while playing the content in content-player. This is causing image broken for images, audio,  PDF & video.

**Problem Statement:**

1. How to access assets or files in content-player without using file system path?

Impacted ares:

1. Question-set
2. EMLC content assests Images, Audios & Video.
3. PDF
4. Video(Mp4 or webm)
5. HTML

### Solution 1:&#x20;

Removing Cordova checks & remove pre-fixing  "file://" to the asses/file path while playing in mobile.

### Solution 2:&#x20;

Use window.parent.Ionic.WebView.convertFileSrc(url);

```
main.js

window.getLocalPath(path) {
	 window.Ionic.WebView.convertFileSrc(path);
} 
```

Replace all the place where-ever we are referring "file://" by calling above function.

***

\[\[category.storage-team]] \[\[category.confluence]]

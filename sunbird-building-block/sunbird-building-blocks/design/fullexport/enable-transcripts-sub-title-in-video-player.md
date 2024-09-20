# Introduction

This wiki explains the design and implementation of enabling the transcripts in the video player.

[SB-26905 System JIRA](https://browse/SB-26905)

### Key Design Problems:

1. How the player should enable/render the transcripts files for the selection.
2. How to handle the transcripts-related changes in configurations.
3. How to handle the default selection of transcripts.

### Design:

![](<../../../../Design/FullExport/images/storage/videoPlayerTranscripts.drawio (1).png>)Solution:

* We are using the video js plugin for enabling the transcripts selection in the player and its [link](https://github.com/tomByrer/videojs-transcript-click/blob/master/dist/videojs-transcript-click.js).
* sample example link for this is [https://tombyrer.github.io/videojs-transcript-click/demo/index.html](https://tombyrer.github.io/videojs-transcript-click/demo/index.html).
* The video js version we are using is 7.4.1
* Reference document of the transcripts and relation between the content and transcripts \[\[Enable transcripts for video content|Enable-transcripts-for-video-content]]
* In the config, the content metadata we need to get transcripts-related details, and the sample data is

```
playerConfig: {
   ....
   metadata: {
     ....
     transcripts: [
      {
          language: 'English',
          languageCode: 'en',
          identifier: 'do_11355096882872320012900',
          artifactUrl: 'https://dockstorage.blob.core.windows.net/sunbird-content-dock/content/assets/do_11355096882872320012900/caption.english.vtt'
      },
      {
          language: 'Urdu',
          languageCode: 'ur',
          identifier: 'do_11355155567137587212904',
          // tslint:disable-next-line:max-line-length
          artifactUrl: 'https://dockstorage.blob.core.windows.net/sunbird-content-dock/content/assets/do_11355155567137587212904/caption.urdu.vtt'
      },
      {
          language: 'Bengali',
          languageCode: 'bn',
          identifier: 'do_11355160347001651212907',
          // tslint:disable-next-line:max-line-length
          artifactUrl: 'https://dockstorage.blob.core.windows.net/sunbird-content-dock/content/assets/do_11355160347001651212907/caption.bengali.vtt'
      }
    ],
    ...
  }
}
```

* Each object in transcripts data should have minimum values of language, languageCode, identifier, artifactUrl. and sample config link is [https://github.com/project-sunbird/sunbird-video-player/blob/release-5.0.0/src/app/data.ts](https://github.com/project-sunbird/sunbird-video-player/blob/release-5.0.0/src/app/data.ts)
* When transcripts are not an available or empty array in content metadata the transcripts selection will be disabled(cc icon will be hidden)
*   **Default config(not handling transcripts state)**

    the state restorations data has to read from local storage ,

    * **Case 1**

    In this case in configuration, there is no need to pass the transcripts-related data and the player will not select any default transcripts by itself.

```
playerConfig: {
     ....
     config: {
     ...
  }
}
```

```
*  **Case 2** 

This case in the configuration can pass transcripts as an empty array, so in this case also the player will not select any default transcripts by itself.

```

```
playerConfig: {
     ....
     config: {
     ...
    transcripts: []
  }
}
```

*   **Custom Config(handling transcripts state/default selection)**

    the state restorations data has to read from local storage ,

    * **Case 1** :

    For default selection or state restoration can be retained by the player for transcripts only when we pass transcripts data in the config. if parent application passes transcripts data in the config like below , the default or state restoration will be achieved for given language code.

```
playerConfig: {
     ....
     config: {
     ...
    transcripts: ['en'],
    currentDuration: 1.019399
  }
}
```

```
*  **Case 2** : 

For default selection or state restoration can be retained by the player for transcripts only when we pass transcripts data in the config and also at the specific duration of the play. if parent application passes transcripts data in the config like below , the default or state restoration will be achieved for given language code form the given duration.
```

```
playerConfig: {
     ....
     config: {
     ...
    transcripts: ['en'],
    currentDuration: 2.119399
  }
}
```

```
*  **Case 3** : 

For default selection or state, restoration can also be retained by the player for transcripts when transcripts data is having multiple language code, the last element in the array will be retained.
```

```
playerConfig: {
     ....
     config: {
     ...
    transcripts: ['en', 'hi'],
    currentDuration: 3.019399
  }
}
```

```
*  **Case 4** : 

For default selection or state restoration can not be handled by the player , when array with a last element  value is off for the transcripts data in the config, so the player will not select any default/restore transcript.
```

```
playerConfig: {
     ....
     config: {
     ...
    transcripts: ['en', 'off'],
    currentDuration: 10.9399
  }
}
```

* The following list of languages tested on video content player and for more details for languages supported by video js library is [link](https://docs.videojs.com/docs/guides/languages.html#language-codes).

| **Language name** | **Language** **code** |
| ----------------- | --------------------- |
| Kannada           | kn                    |
| English           | en                    |
| Hindi             | hi                    |
| Tamil             | ta                    |
| Telugu            | te                    |
| Punjabi           | pa                    |
| Odiya             | or                    |
| Marathi           | mr                    |
| Bengali           | bn                    |
| Urdu              | ur                    |
| Malayalam         | ml                    |
| Assamese          | as                    |
| Gujarati          | gu                    |

Player events:

* Player events can be used in parent application by using these events parent application can determine the which transcript has been selected and at what video time stamp its been selected.
* Using player events parents application can show/hide the transcripts details .
* Player events can used for telemetry events in parent application for various use cases.
* When the user selects transcripts the following player event will be triggered.

```
{"eid":"HEARTBEAT","ver":"1.0","edata":{"type":"TRANSCRIPT_LANGUAGE_SELECTED","currentPage":"videostage","extra":{"transcript":{"language":"English"},"videoTimeStamp":0.020584}},"metaData":{"actions":[{"play":0},{"pause":0.020584}],"volume":[],"playBackSpeeds":[],"totalDuration":8.3,"currentDuration":0.020584,"transcripts":["en"]}}
```

* When user unselect transcripts the following player event will be triggered.

```
{"eid":"HEARTBEAT","ver":"1.0","edata":{"type":"TRANSCRIPT_LANGUAGE_OFF","currentPage":"videostage","extra":{"videoTimeStamp":0.020584}},"metaData":{"actions":[{"play":0},{"pause":0.020584}],"volume":[],"playBackSpeeds":[],"totalDuration":8.3,"currentDuration":0.020584,"transcripts":["en","off"]}}
```

### Telemetry events:

The telemetry events can be used for determining the various cases scenarios of the users like how often user selecting transcripts and unselecting and at what video time stamp. also covers the which languages are being used more.

* When the user selects transcripts the [**CP-VIDEO15** ](https://docs.google.com/spreadsheets/d/1nZZYHQSmIjc\_pkRi4LP8iK0FjKYBiCJ5k3awSZ-ORpI/edit#gid=0\&range=A45)telemetry event will be triggered.
* When the user unselect transcripts the [**CP-VIDEO16** ](https://docs.google.com/spreadsheets/d/1nZZYHQSmIjc\_pkRi4LP8iK0FjKYBiCJ5k3awSZ-ORpI/edit#gid=0\&range=A46)telemetry event will be triggered.
* When required fields missing in metadata.transcripts the [**CP-VIDEO17** ](https://docs.google.com/spreadsheets/d/1nZZYHQSmIjc\_pkRi4LP8iK0FjKYBiCJ5k3awSZ-ORpI/edit#gid=0\&range=A47)telemetry event will be triggered.

***

\[\[category.storage-team]] \[\[category.confluence]]

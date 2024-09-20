To enable offline playback of interactive videos the ECARs for interactive videos need to include the question sets as well. This document discusses the options for achieving this. 


## Option 1 - No change in ECAR, app downloads independent ECARs
In this option, there will be no change in the ECAR generation of Question sets and videos. There will be independent ECARs for each of the question sets and the video itself. 

The app will need to ensure that the ECARs are also downloaded when a user is downloading the interactive video.




## Option 2 - Create a bundled ECAR
In this option, the publish pipeline for the interactive vidoes is changed to produce an ECAR that has the video as well as the question sets in the same ECAR. Below is the structure of such an ECAR

Structure of a current video ECAR


```bash
manifest.json
do_xxxx/video.mp4
do_xxxx/do_yyyy_thumbnail.jpeg
```


Proposed structure


```bash
manifest.json
do_xxxx/video.mp4
do_xxxx/do_yyyy_thumbnail.jpeg
interactions/do_questionset_1/ (this folder has the exact same contents of a question set ECAR)
interactions/do_questionset_2/
```


Option 3 - Use a structure similar to the “full ECAR”
1. All the content (videos & question sets) will be at the top level


1. The manifest.json contains entries for the video as well as question sets


1. New attribute to be added - rootIdentifier - this will be the id of video content folder


1. In manifest first item in items array would be video content





Structure of a current video ECAR


```
manifest.json
do_xxxx/video.mp4
do_xxxx/do_yyyy_thumbnail.jpeg
interactions/do_questionset_1/ (this folder has the exact same contents of a question set ECAR)
interactions/do_questionset_2/
```


Proposed structure


```
manifest.json
do_xxxx/video.mp4
do_xxxx/do_yyyy_thumbnail.jpeg
do_questionset_1/ (this folder has the exact same contents of a question set ECAR)
do_questionset_2/
```


*****

[[category.storage-team]] 
[[category.confluence]] 

RoadmapThis section gives an overview of what’s possible and what’s coming up


## Sunbird Release 4.1

* [[ **Interactive Video Player V1** |Interactive-Video-V1]]


    * Overview - Enabling  _consumption_  of interactive videos on the Sunbird platform 


    * [[Link to Confluence|Interactive-Video-V1-Consumption-Interface---4.1-Scope]] (4.1 Scope)


    * [Jira Link](https://project-sunbird.atlassian.net/browse/SB-25452)


    * Experience it here - [Content 1](https://staging.sunbirded.org/play/content/do_21310353608830976014671?contentType=ExplanationResource)



    


## Sunbird Release 4.2

*  **Question Bulk Upload API** 


    * Overview - Implementing a Bulk Upload API on the backend to enable uploading multiple (to the order of thousands) questions at once onto Diksha.


    * [[Link to Confluence|QuML-Bulk-Upload-API]]


    * [Jira Link](https://project-sunbird.atlassian.net/browse/SB-25750)



    
*  **Interactive Video Player V1 enhancements** 


    * Overview - Enhancing the player scorecard to display the accuracy score


    * [[Link to Confluence|Interactive-Video-Player-Enhancements---4.2]]


    * [Jira Link](https://project-sunbird.atlassian.net/browse/SB-25752)



    


## Next release

*  **Interactive Video Creation** 


    * Overview - Building the  _creator interface_  for interactive videos which will allow adding questions to passive videos


    * Creating new questions:  _Broad Workflow - Create New > Upload Video > Make it Interactive > Create New Questions (MCQ)_ 


    * Adding existing questions: [ _Detailed Workflow_ ](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/2646278147/Interactive+Video+V1#Wireframes)



    

    
*  **Interactive Video Player V1 enhancements** 


    * Overview - Adding offline support for interactive videos



    


## Future

* Interactive Video Creation


    * Find (Discover) existing assets > Make it interactive > Launch editor with video selected > Create New Questions (MCQ, ..)



    
* Creator’s dashboard



Concept Note (Vision)

Interactive videos are a great way to engage a learner. Following capabilities are essential to making a scalable generalised interactive video solution on Sunbird.


1. Any video can be made interactive. Interactions as a behaviour of the video. Interactive behaviour can be contextual. 


1. Creator can either start with a fresh video upload or use any existing video from whitelisted repositories enabled by an sunbird adopter in their instance (e.g. DIKSHA Content Repo, YouTube, NROER, etc).


1. Creator can add any of the existing questions or create new questions to make the video interactive.


1. Interactive videos, similar to other assets on the platform, are reviewed before publishing. They should integrate with various creation (sourcing) workflows.


1. Interactive videos, similar to other assets on the platform, can be organised by adding them to collections. Digital Textbook and Courses are good examples of assets (content) organised in collections.


1. Interactive videos can be played on mobile app, web app, and desktop app just like all other content


1. Any video can have questions attached to it. Video need not be duplicated (copied) - questions are stored as additional metadata of the video.


1. Make a video interactive in particular context. E.g. add questions in a video to make it interactive only as part of a collection (ex course, Digital textbook) vs individual video made interactive. So when an video is added to a collection - either interactive behavior is enabled as is OR suppressed or replaced by another set of questions


1. A video can have more than one set of questions attached to it. Each one created for a different context. Imagine a video being reused by many organisations (States) and each one having their set of questions attached to the video.


    1. Imagine Video uploaded by Org A is being made interactive by Org B using questions created by Org C. 



    
1. Video can be played with or without questions (interactivity) as per the need & context by the consumer, similar to turning off subtitles for a video.


    1. Allowing an interactive video to be played without interactions should be a configuration for creators. Creators can enforce interactivity (questions) in their context if they wish to.



    
1. Sunbird has a concept of Content Statistics for Authors to analyse usage of their contributions. A similar dashboard should be available to contributors for their Interactive videos as well. This is to help creators understand engagement effectiveness and drop-off points to take further action for improving their videos.


1. Sunbird adopters (e.g DIKSHA) should provide a data exhaust for Sunbird contributors to understand usage of their contributions. For example, How many interactive videos were created? What were the various engagement metrics for Interactive videos?


    1. This should be supported by a policy of Sunbird adopter (e.g. DIKSHA) allowing Sunbird contributor (e.g. Avanti, EkStep) to get data exhaust.



    
1. Editor and Player plugins contributed by Plio should give due credit. E.g. ‘Contributed by Plio’




## Discussion notes - 8th April

* Telemetry would need to be emitted from player and editor


    * Re-package as plain JS to generate telemetry events



    
* Use QuML library to render questions on top of videos


* Workflow (creation): 


    * Create new interactive video > \[Start with a video on system]


    * Pick/upload a video > \[Upload v2]


    * Pause at a timestamp to insert question


    * Pick/create questions > \[Create v2]


    * Submit for review



    
* Player: Video (existing player - video js or new player - plyr) overlay with a question (use QuML player)


    * Transitioning between player is possible but not tried out yet



    
* Connect with tech partner. To get a jump-start.


* Local / staging setup → Use Dev APIs instead. To modify APIs - a local instance of backend is required.


* Enhance the asset model to store contextual interactive behaviour (contextual questions) → Rayulu to lead, co-create with Pritam


* Asset model: Definition and Metadata attributes for an object. 


* Interception points to stitch any sequence intermixing variety of content. Time based interception points.


* MVP - Plio V1 + Tiny contribution (as strategic call)


* Offline consumption - requires change in publishing pipeline. Is it critical for V1?


    * Consumption client (portal / app) needs to understand new packaging which includes questions.


    * Same player can play online and offline.



    

Suggested approachdraftYellow


1. Enhance the asset model to store contextual interactive behaviour (contextual questions) → 


1. Enhance or develop a player to play interactive video as per the context


1. Develop an editor to create interactive videos using any video & any question


1. Develop a data product extension to analyse interactive video


1. Make all these changes as part of Sunbird Core and SunbirdEd to scale this innovation globally





Roadmap (Maturity Model)draftYellow

Version 1
1. Design for asset model to support contextual interactive behaviour


1. Design and POC of player to support contextual interactions





*****

[[category.storage-team]] 
[[category.confluence]] 

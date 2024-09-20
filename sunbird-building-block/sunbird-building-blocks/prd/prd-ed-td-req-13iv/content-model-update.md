To enable interactive videos in V1, the content model needs to be updated to include interception points. The change is to the base model so that in the future, this can easily be applied to other content types, though initially, only videos will be supported.

An interception point will be defined as a point during the progress in the player of a content type at which another content type will intercept, i.e. they represent when the content will be intercepted, and with what other type of content. 

For example, in V1, videos can be intercepted by QuML question sets.

Possible ApproachesGiven the requirement for future flexibility, we have come up with two approaches to designing the model for interactive videos:


1. Updating the base content model to allow interception points in any content type: This would mean interactivity can be added to any content type, and interactivity becomes a property of each piece of content where it can be enabled. The players can simply be extended to support interactivity where it is present. The  **disadvantage**  here is that a set of interceptions then becomes tied to its parent content. 

    For example, if questions are added to a video to make it interactive, then to make the same video interactive with different question (for a different purpose), then the video will need to be re-uploaded. This can be solved somewhat by allowing the content model to sit in the relation between courses and content, which would allow different courses to have different interception points. 


1. Adding a new mime type for interactive videos: This would mean each combination of interactivity (video ↔︎ questions, pdf ↔︎ video, pdf ↔︎ questions, and so on) would be a new mime-type. This has the advantage of providing strong rules on when interactivity will be allowed. Each interactive content mime-type can simply store links to the underlying content, so there will not be replication of the base content. For example, an interactive video will store the ID of the video, along with IDs of the question sets that are required, including information about timestamps, etc.

    The  **disadvantage**  here is that creating a new kind of interactive content will require extra work, and this process will need to be repeated for each content type. Every content player will need to be updated not just to support the interactivity, but also to support the new mime-type, which would mean a little (not a lot) extra work in each release.




## Proposed Design for updating base content model
The proposed design change to the schema is adding interception points and the interception type. For a video, this would be a timestamp.




```json
        "interceptionPoints": {
            "type": "array",
            "items": {
                "type": "object"
            },
            "default": []
        },
        "interceptionType": {
            "type": "string",
            "enum": [
                "Timestamp"
            ]
        },
```

### Example 
The following is a sample array of interception points for a video


```json
   "interceptionPoints":{
      "items":[
         {
            "type":"QuestionSet",
            "interceptionPoint":3000,
            "identifier":"ID"
         },
         {
            "type":"QuestionSet",
            "interceptionPoint":9000,
            "identifier":"ID"
         },
         {
            "type":"QuestionSet",
            "interceptionPoint":300,
            "identifier":"ID"
         }
      ]
   },
   "interceptionType":"Timestamp"
```


Timestamp would be an integer that would represent the number of seconds into the video where the interceptions should appear.





*****

[[category.storage-team]] 
[[category.confluence]] 

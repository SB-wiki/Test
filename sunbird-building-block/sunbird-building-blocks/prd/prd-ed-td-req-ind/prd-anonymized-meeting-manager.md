

* [Brief](#brief)
* [Problem Statement](#problem-statement)
* [Suggested Solution](#suggested-solution)
* [Alternatives considered](#alternatives-considered)



# Brief
This document details the requirement of a tool that can help people with organizing meetings and putting the result out in public. This will be primarily used to support an open source project, to enable open communication.


# Problem Statement
For the Sunbird project, we have a few contributors who communicate with one another transparently via the discussion forums. However, there are instances when the sharing of ideas is too slow for the topic at hand, and it needs faster brainstorming. In such scenarios, people need to have access to one another’s emails and calendars, and also be able to have some to-and-fro to identify a time that works for all to meet.

Usually, the calls aren’t documented or recorded, as it requires the convenor to remember to record the call. Recording the call/summary is useful to help future contributors understand how engagement happens between various contributors to an open source project.

The way this is usually done in open-source projects, is that there are two primary methods of communication - discussion forums for any interaction that can be referred to in future, or chat channels (such as IRC or slack) for quick temporary interactions. As we understand it, it is rare for multiple organizations to work together on a specific feature (within a short timeframe), and therefore there is reliance on written forms of communication instead of verbal formats.

While the obvious solution could be to share email addresses for people to coordinate meetings, an indirect fallout of this is that people start interacting with each other via email instead of using the discussion forums. This leads to islands of knowledge, instead of one common repository of open shared knowledge. While one could request contributors to document the summary of the conversations on the forum - it is hard (and not intuitive) to ensure it.


# Suggested Solution
The chat interaction is not currently in the scope of this solution. We are currently focussed on enabling the anonymous meeting management. This tool will have the following capability:


1. People share their calendar with this tool, after logging in with their Github ID.


1. When a Github user wishes to start a meeting, they create an event.


1. In the event, they can add: 


    1. Github IDs of the intended recipients


    1. See potential dates/times that work for the recipients (if the calendars are compatible/have API for this)


    1. Post the github main thread/subthread where they want updates/link access to this event.



    
1. The tool blocks the time for the relevant participants, who can choose to accept/reject. If rejected, the tool informs the creator. It also hides participant info, so that peoples contact info can’t be seen.


1. The tool puts the link to the event on the Github thread mentioned by the creator.


1. The tool also creates a video conference event for the same, and records the event.


1. Once the event is over, the video is auto-uploaded to a publicly accessible location.


1. The tool then comments on the same ticket where the event was first shared, with the link to the recording of the event. 






# Alternatives considered

1. Share email addresses with one another - and trust they’ll not use this to increase 1:1 communication. Auto-record of the meetings that are set up can be enabled on some video-conferencing tools.


1. Calendly - Doesn’t work since it requires you to share email addresses, and there’s a paid plan for group meeting coordination.


1. Indico - Slightly cumbersome creation process, also doesn’t seem to have invite via Github ID. In addition, needs to be self-hosted.


1. Rallly - Can only help identify a date that works for everyone, not a time.


1. Doodle - Paid software.





More options here: [https://blog.hubspot.com/marketing/meeting-scheduler-tools-more-productive](https://blog.hubspot.com/marketing/meeting-scheduler-tools-more-productive)



*****

[[category.storage-team]] 
[[category.confluence]] 

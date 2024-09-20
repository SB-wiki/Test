
### About Avanti Fellows
The mission for Avanti Fellows is to provide children from low income backgrounds access to quality higher education enabled by effective supplementary learning programs with significant additional teaching at a student level.


### Problem
In 2020, millions of students were forced to study online during the COVID-19 lockdown. Avanti Fellows was running an at-home learning program for the students of public schools in Haryana. They were teaching Math and Science using a combination of simple tools. Content was being served through YouTube Videos while Google Forms were being used for assessments and quizzes. 

But student engagement was a big problem with even the best videos seeing a sharp drop off after 1 minute. Additionally, YouTube only provides aggregate statistics with no way to gather data at an individual viewer level.


### Solution
To tackle this, the team developed [Plio](https://app.plio.in/) - an open source tool that allows any educator to convert any YouTube video into interactive lessons and gather rich data on user engagement. Soon, the YouTube & Google Form links being sent to students on Whatsapp were switched with Plio links. Students started watching these interactive videos and learning in an interactive manner. More than 40,000 students interacted with Plio with a  **5x**  higher retention rate compared to passive videos. 

Currently, Plio has more than 9000+ registered users with 2 other NGOs outside of Avanti Fellows actively using it. 


### Contribution to Sunbird
[[Interactive Video V1|Interactive-Video-V1]]

Sunbird currently supports Question Sets and Videos separately. However, we have learned that engagement with videos is much higher if questions can be placed inside videos. Once the videos are made interactive, the learning experience is much more enjoyable for the end user.

With support for Interactive Videos in Sunbird, we will have the capability to:


1.  **Make any video interactive** : The goal is to design this in such a way what any available video can be made interactive by adding any question set at any timestamp in the video.


1.  **Publish interactive videos as a new form of content** : This will enable teachers to leverage interactive videos to improve the experience for learners


1.  **Analyse interactions at a deeper level** : The interactive video platform will provide an exhaust for telemetry and analysis which will allow data about engagement at a very detailed level




### Current Status
Capabilities released until now:


* Ability for a creator to add questions to any new video being uploaded


* Enabling Interactive Video Consumption experience



Please note, these capabilities are right now released under staging. 

Below is our roadmap:



|  **#**  |  **Action Item**  |  **Use Case**  |  **Status**  |  **Planned release**  | 
|  --- |  --- |  --- |  --- |  --- | 
| 1 | [Enhancing the Review/Publish flow](https://project-sunbird.atlassian.net/wiki/spaces/PRD/pages/2972418065) for Interactive Videos to generate a single ECAR for Interactive Video with both question and video meta data packaged together. Also, enhancing the player so that it can understand the new packaged structure. |  _Will allow offline consumption of Interactive Videos and help make the solution scaleable_  | Under development | Sprint 4.9 | 
| 2 | Enhancing Question Set Category Type for Interactive Video Content |  _Will allow making the question sets created inside interactive videos private, but the questions created as public and discoverable. Also will allow configuration of the question set editor inside Interactive Video Flow to keep it user friendly_  | Under Development | Sprint 4.9 | 
| 3 | Taxonomy Derivation Logic | To ensure correct and coherent taxonomy of all components of interactive video - video, question sets, questions. | Under Development | Sprint 4.9 | 
| 4 | Mobile Player Enhancements | To support the new content type | Under Development | Sprint 4.9 | 
| 5 | Question Set Player Enhancements | To support the new content type | Under Development | Sprint 4.9 | 
| 6 | Product Analytics Dashboard | To enable analysis on effectiveness of interactive videos and their engagement | Design |  | 




### Possible use-cases
Based on Avanti Fellows' experience with Plio, following are the use-cases where Interactive Video could be a powerful tool:


*  **Digital Homework/Revision:** Interactive videos can serve as a homework tool, where teachers can send or assign interactive videos as homework to students, which they can engage with in a fun manner. It can also serve as a revision tool for students before exams.

    Currently, in Avanti Fellows' Sankalp program, teachers across Haryana are using interactive videos as digital homework. You can access the Avanti interactive video library [here](https://haryana-teachers-af.web.app/). On an average, 500-1000 students engage with the content on a weekly basis.


*  **Teacher Training:** Interactive videos can also be used to interact with teachers in their training programs. Currently [Peepul](https://www.peepulindia.org/), is using Plio to send interactive videos as pre-course material in their teacher training program in Delhi. They have already used it to train 4k+ users.




### Experiment Design
 **Objective** 

With capabilities released to enable online consumption of interactive videos, we want to run a small experiment/s in order to:


* Get feedback on user experience of the interactive video capabilities released


* Compare engagement levels of interactive video with that of passive videos



 **Experiment Design** 

 **Experiment Period** 

 **Experiment Audience** 











*****

[[category.storage-team]] 
[[category.confluence]] 

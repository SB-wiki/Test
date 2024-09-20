[https://project-sunbird.atlassian.net/browse/SB-22718](https://project-sunbird.atlassian.net/browse/SB-22718)




### 1. Print question set as per the print template defined in the question set primary category. 
System should support various templates for Print similar to Certificate templates.

Default Print template: Print should include following and print them on separate page


* Logo of SunbirdEd instance (header)


* Instruction with Question set details such as Name, Description, Board, Medium, Class, Subject, Author, Attributions, License, , 


* Questions, 


* Answers,  


* Solution


* Footer (page number, downloaded from.. , copyright / license)



Check out a sample template here (in document form): [https://docs.google.com/document/d/1-ZmOU6gi3DkWJRZwpY-RiZzX5wa2_R_UJpbbvUio_SY/edit?usp=sharing](https://docs.google.com/document/d/1-ZmOU6gi3DkWJRZwpY-RiZzX5wa2_R_UJpbbvUio_SY/edit?usp=sharing)


### 2. System should have an easy mechanism to add print logic for various question interaction types 
System should have an easy mechanism to add print logic for various question interaction types so that when we enable new interaction type (e.g. MTF) we can define how it is to be printed. This is to ensure Print service is generalised & extensible

 **3. Support printing in Indian languages so that questions in various languages can be printed** [https://project-sunbird.atlassian.net/browse/SB-23391](https://project-sunbird.atlassian.net/browse/SB-23391)

First version should support following with an option to include support for more languages easily in future


1. English (NotoSans),


1. Bengali (NotoSansBengali)


1. Hindi (NotoSansDevanagari),


1. Gujarati (NotoSansGujarati),Punjabi (NotoSansGurmukhi),


1. Kannada (NotoSansKannada),


1. Malyalam (NotoSansMalayalam),


1. Oriya (NotoSansOriya),


1. Tamil (NotoSansTamil),


1. Telugu (NotoSansTelugu),


1. Urdu (NotoNastaliqUrdu)



Let me know if you would like to prioritise from this list. Have included font in the parentheses. 

We should generalise such that Print service can take different fonts if need be.


### 4. Support printing of Math & Scientific text so that questions from higher grades and subject can be printed

### 5. Support printing of images inserted by the creator 
 **6. Handle printing of non-printable media such as audio, video** [https://project-sunbird.atlassian.net/browse/SB-23393](https://project-sunbird.atlassian.net/browse/SB-23393)


1. If ‘Solution’ is only video, print a message such as “Please click here to watch the Solution video.” (insert direct link to play video)


1. If  _audio_  is attached to question, answer / options, or instruction, a relevant message is printed along with text + image of that block - “Please click here to listen to the attached audio.” (insert direct link to play audio)



 **Scenarios** :


1. (This is unlikely, still..) If there are more than one media for any of the question property, system should print the relevant message for them as many times. For example, if there are two Solution videos then system would print the message twice - every time in a new line.



“Please click here to watch the Solution video.”

“Please click here to watch the Solution video.”



*****

[[category.storage-team]] 
[[category.confluence]] 

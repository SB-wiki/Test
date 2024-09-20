# Improvements-to-MCQ-Templates

IntroductionBased on usage of MCQ questions by several states, there are several inputs that have come up to improve on the experience of users consuming these questions. These constitute of enhancements to support new layouts as well as improvements to existing layouts.

This PRD documents the specifications of these changes.

JTBD \*\*Jobs To Be Done: \*\*

* **User Personas:** The logged in users who have content creator role, Will be able to use these templates. Teachers or Students who consume questions on mobile or portal
* **System or Environment:**  Works on for desktops with Chrome browser only.

## Requirement Specifications&#x20;

1\. Improvements to the existing MCQ Templates

#### Image Zoom-in&#x20;

1. Where ever there is an image in the question or in the option, while previewing the question in the mobile App or in the portal, the Zoom in button should be shown on the image.
2. When a user clicks on the Zoom in button, the image should pop up in the full screen both in mobile App and in the Portal preview.
3. Whenever the user is on the pop-up,  on the right side of the image there should be a cross (X) button, Whenever user clicks on that button the image should go back to its original position.

#### Audio Button

There is a change in the location and size of the audio button. The modified UI is given in the UI Screenshots. There is no change in the functionality. Only placement and size of the icon as given in the wire-frames need to be considered and not change in the icons between play and stop.

#### Text Wrap

Text wrap should be enabled for both question and options in all existing templates wherever text is present.

JIRA Ticket ID[SB-12280 System JIRA](https://browse/SB-12280)

Wire-frames[https://projects.invisionapp.com/share/73SRFRRSBPC#/screens/371494039](https://projects.invisionapp.com/share/73SRFRRSBPC#/screens/371494039)2. New MCQ Layouts In MCQ, we need to add two new layouts which support horizontal layout for an image in the Question where the image of the question is shown on the top and options are shown at bottom.

1. A layout that supports: Horizontal Image+Text in Question. Image+Text in options
2. A layout that supports: Horizontal Image+Text in Question. Only Text in options

Wireframes for the same are below.

Functionality of the new layouts should be exactly same as that of the two layouts that support Image in Question on the left side (portrait mode).

JIRA Ticket ID[SB-13367 System JIRA](https://browse/SB-13367)

Wire-frames[https://projects.invisionapp.com/share/PWSWZ1I8MFX#/screens](https://projects.invisionapp.com/share/PWSWZ1I8MFX#/screens)Localization RequirementsN/A

Telemetry RequirementsAll the Telemetry events of the existing templates have to be implemented for the new MCQ layouts as well.

Non-Functional RequirementsN/A

Impact on other Products/SolutionsN/A

Impact on Existing Users/Data Improvements to the existing templates will not reflect automatically in the existing live content. The content has to be republished to reflect this. Separate Jira ticket will be created for this as required.&#x20;

Key Metrics

| Srl. No. | Metric                                  | Purpose of Metric                                   |
| -------- | --------------------------------------- | --------------------------------------------------- |
| 1.       | Number of content using new MCQ layouts | To understand the business value of the new layouts |
|          |                                         |                                                     |

***

\[\[category.storage-team]] \[\[category.confluence]]

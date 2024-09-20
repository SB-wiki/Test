# Accessibility-Guidelines

**Accessibility**  is the inclusive set of engineering/solutioning practices to ensure there are no barriers that prevent interaction with, or access to, website on the internet by people with physical disabilities, situational disabilities, and socio-economic restrictions on bandwidth and speed.

Following needs are addressed as part of accessibility:

* Cognitive
* Seizure
* Visual
* Motor
* Auditory

As part of our Efforts, the Accessibility has been divided into two phases :

a) Product Accessibility

b) Content Accessinility

#### Product Accessibility

The fundamental Guidelines are derived from WCAG 2.1 guidelines. We are currently using these guidelines as base to formulate the guidelines.

|                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                       | **Tools**                                     | **Guidelines**                                                                                                                                                                                                                                                                                                                                                                            |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Color Contrast                                                                                              | WCAG 2.0 level AA requires a contrast ratio of at least 4.5:1 for normal text and 3:1 for large text. WCAG 2.1 requires a contrast ratio of at least 3:1 for graphics and user interface components (such as form input borders). WCAG Level AAA requires a contrast ratio of at least 7:1 for normal text and 4.5:1 for large text.Large text is defined as 14 point (typically 18.66px) and bold or larger, or 18 point (typically 24px) or larger. | WAVE, AXE Auditor, Accessibility by Microsoft | It is recommended on the buttons, headers, footer sections of the website. The Context Ratio between foreground text Color and Background text Color to be in contrast ratio of 4:5:1.Accessibility Issue Example:![](<../../../../Consumption/Fullexport/images/storage/Screenshot 2021-08-24 at 2.05.23 PM.png>)                                                                        |
| Keyboard Accessibility                                                                                      | Keyboard Accessibility can be broadly categorized as follows: a) TabOrderb) Tab Focusc) KeyBoard Handling Enabling                                                                                                                                                                                                                                                                                                                                    | Keyboard Navigation needs to be tested        | Any Specific Area/Element/ Component should be accessible using keyboard without the help of mouse movement. Ex: Tab Index should be defined on elements which has click Handlers                                                                                                                                                                                                         |
| \`\`\`                                                                                                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                               |                                                                                                                                                                                                                                                                                                                                                                                           |
|                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                               |                                                                                                                                                                                                                                                                                                                                                                                           |
| \`\`\`                                                                                                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                               |                                                                                                                                                                                                                                                                                                                                                                                           |
| Tab Focus can be defined by css with seperate Highlighted border to be clearly distinguishable to the user. |                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                               |                                                                                                                                                                                                                                                                                                                                                                                           |
| Aria Labels                                                                                                 | Aria Attributes to be used: a) aria-labelledforb) aria-labelledbyc) aria-roles                                                                                                                                                                                                                                                                                                                                                                        | Screen Readers like NVDA, JAWS                | In order to have descriptive text available for the headings, regions and sections aria attributes are to be used effectively. When custom components are used in the application aria attributes come in handy in explaining the role of these components and description on what these components intend to help the user. This is getting covered as part of 4.2 IMPLEMENTATION Cycle. |
| \`\`\`                                                                                                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                               |                                                                                                                                                                                                                                                                                                                                                                                           |
| Back                                                                                                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                               |                                                                                                                                                                                                                                                                                                                                                                                           |
| \`\`\`                                                                                                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                               |                                                                                                                                                                                                                                                                                                                                                                                           |

```
<div role="main" aria-labelledby="sample">
   <h1 id="sample"><Text Book Title></h1>
   ...
</div>
```

\| | Image Alt tags | Every Image needs to have descriptive text helping the user to identify the image using text | WAVE, AXE Auditor, Accessibility by Microsoft | Ex:

```
<img _ngcontent-jqd-c7="" class="cursor-pointer" alt="Sunbird Application Logo" src="https://preprod.ntp.in/tenant/ntp/logo.png">
```

\| | Navigation Screens | Navigation Options / Site Map should be clearly defined for the site | | [https://diksha.gov.in/sitemap.html](https://diksha.gov.in/sitemap.html) | | Font Size SwitchDark Mode / Light ModeNavigation Options | Varying font sizes should be provided as an option for all users in the websiteIn Order to comply with GOI guidelines the website has been introduced with dark theme/ white theme.In Compliance with GOI guidelines links like “Skip to Main Content“ / “Screen Reader Access“ / “Site Map“ has been introduced. | | ![](<../../../../Consumption/Fullexport/images/storage/Screenshot 2021-08-24 at 4.45.03 PM.png>) |

Development Tools to be used :

1. WAVE Chrome Browser Extension -
2. AXE Accessibility Browser Extension
3. Microsoft Accessibility Suite

Contribution Guidelines:

* Any Feature Contributed to Sunbird shall be accessible by default
* Accessibility should not be seen as a separate Engineering/QA effort by contributors.
* AXE Auditor Reports to be published by each contributor at the end of release.
* QA to include the test cases of Accessibility as part of main test cases. Regression report to be published on Accessibility across app and web site.
* Each Contributor to provide the roadmap of achieving accessibility compliance.

#### Content Accessibility

Content Accessibility refers to wide variety of contents in the platform contributed as part of Vidyadaan and Creation Workflows in Portal.

1.  Any Players contributed should have additional intelligence necessary to enable accessibility of content.

    Ex: Html Generated content like ECML, QuML Players can have an option of Accessibility mode available by default.
2.  Any asset generated in the platform should have relevant guidelines to ensure creators are nudged to create Accessible content.

    Ex: Content like PDF should have a clear guidelines on Do's/ Dont’s of creating pdf. Ability for creator to explicitly declare a content to be non-accessible would be desirable.
3. Image Based Based Questions in ECML/QuML can get explicitly marked as “Non Accessible“ and relevant warning has to produced to users.

***

\[\[category.storage-team]] \[\[category.confluence]]

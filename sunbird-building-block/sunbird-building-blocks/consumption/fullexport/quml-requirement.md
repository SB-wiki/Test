# QuML-Requirement

## Why QuML Player?

A player built on open-source technology to natively play QuML Questions & Question Sets. This player will be optimised to play content faster and support building capabilities much faster in future.

As a User I should have a player to plug & Play the Questions from various data source. Embeddable player in content. For example, questions from various Question banks stored in QuML format.

Should work as open standard for rendering of question banks with customised User Experience. So, someone should be able to build a custom player using these guidelines and open-source QuML player library. This player's architecture could be leveraged to build other such players for other content types.

As a User I should have a native playing experience of playing content across all device platforms (Desktop,Mobile & Tablet). So content would respond to various consumption channel's form factor and resolutions. This player would also have richer UI / UX such as new navigation, responsiveness, orientation support (portrait / landscape). For example, playing MCQ in portrait mode.&#x20;

It would support use-cases such as Quiz, Mock Test, Timed Test, Training Assessment, and more.

Player capable of relatively lighter deployment capability is desirable. This we will achieve by migrating / complying to NPM standards. This would make player size less (light-weight) and make deployment cycles faster & lighter (internal dev team).

Player should be brand-able based on minimalistic input. So we can have multiple themes of the player to visually differentiate for various use-cases / user-groups. This player would support configurations to enable / disable certain capabilities.

Problems with the current approach .. security, iframe, deprecated

It could have capabilities (in-future) such as:

* Question Ordering such as branching logic,&#x20;
* Player would support dynamically fetch sets of exam based on a blueprint
* Animation
* Theme
* Time Keeping. Timer - enforced exit or stopwatch
* Behaviour Metadata
  * Attempt Metadata
* Score Board
* Receiver of all Event Emitters of Hosted Templates
* Loader
* Telemetry wrapper for all emitted events
* Common Latex library which can process inline latex content
* Shuffle questions to give equivalent yet different test
* Instruction (start) page
* Summary (end) page
* Report card for detailed question level results
* ...

### Beneficiaries / Stakeholders

* Developer community
  * Building on open-source standards allows us to attract more contributors
  * Ease of development due to latest tech stack and popular industry technologies
* Users
  * Faster player
  * Better User experience&#x20;
  * Lightweight device storage requirements for player installation
  * Help reduce content size due to template bundling
* Product & Business team
  * Cost / Time / Effort of development would reduce
  * Faster feature dev
  * Customisations supported - various use-cases supported by one player

### Comparison of current (ECML) Content player and QuML player

\| | Current (ECML) Content Player | QuML Player | | Generic player built for variety of content types | Specific player built for a purpose | | Supported Content Types: Resource | Supported Content Type: Practice Question Set | | Supporte Formats:&#x20;

1. ECML
2. PDF
3. Video (MP4, WebM)
4. YouTube video
5. H5P
6. HTML Archive
7. ePub
8. .. (more?)

\| Supported Formats: QuML Question Set | | Technology used: | Technology used: | | Player load time is comparatively higher since it loads all dependent libraries before it begins to play content | Player load time is comparatively lesser .. | | Responsiveness.. | | | | | | | | | | 600 KB inclusing KaTeX dependencies | | --- | --- | --- |

| ---                                               |
| ------------------------------------------------- |
| ---                                               |
| ---                                               |
| ---                                               |
| ---                                               |
| ---                                               |
| ---                                               |
| ---                                               |
| Generic player built for variety of content types |
| Supported Content Types: Resource                 |
| Supporte Formats:                                 |

1. ECML
2. PDF
3. Video (MP4, WebM)
4. YouTube video
5. H5P
6. HTML Archive
7. ePub
8. .. (more?)

\| Supported Formats: QuML Question Set | | Technology used: | Technology used: | | Player load time is comparatively higher since it loads all dependent libraries before it begins to play content | Player load time is comparatively lesser .. | | Responsiveness.. | | | | | | | | | | 600 KB inclusing KaTeX dependencies |

### Discussion Points

Forward/Backward Compatibility of Questions Ex: Introduction of new capability would end us up with introducing new player version for content.

Introduction of New Question Types - introducing a new question type (new evaluation logic) requires you to upgrade the player or supports only..

Evaluation logic 1 : Select / Multi-select would support various MCQ templates

Evaluation logic 2 : Pairs would support various templates such as MTF, Reordering, Sequencing, Memory game

Evaluation logic 3 : Text input would support FTB, ordered FTB, unordered FTB,&#x20;

New evaluation logic requires player upgrade. Older players will not support these &#x20;

Download dependencies if compatibility is broken and play as iframe; and in the upcoming release upgrade the player

## What will QuML player be capable of?

List of capabilities and NFRs

Users will continue to create Practice Set (QuML) using Program portal and/or Contribution workflow. The editors would generate the appropriate content HTML / QuML as per specification. The player, built as per QuML specs, would play these content seamlessly & efficiently.&#x20;

**Alpha** _Target release: 2.7.0_

1completeResponsive to variety of form factors - can adapt to any screen size and orientation2completeMCQ with dynamic layout selection - vertical, horizontal, grid, multiple column3completeInitially built using Angular, Vue JS, TypeScript

1. Later decided to build using Pure JS & Angular

4complete(Spike) Embed in non-Angular apps **Beta** _Target release: 2.8.0_

5completeEnd page & Navigation configuration in player [SB-17575 System JIRA](https://browse/SB-17575)Feature parity with current Practice Set player

6completeSupport MCQ with all 4 layouts and be capable of supporting more layouts in future [SB-17576 System JIRA](https://browse/SB-17576)7completeSupport Subjective questions [SB-17578 System JIRA](https://browse/SB-17578)8completeSupport Question + Answer + Solution for MCQ & Subjective question types [SB-17579 System JIRA](https://browse/SB-17579)9completeSolution as text + image10incompleteSolution as video11completeSupport show / hide of evaluation feedback [SB-17580 System JIRA](https://browse/SB-17580)12completeSupport top (new) navigation design [SB-17583 System JIRA](https://browse/SB-17583)13incompleteMenu 14completeSupport for end (summary) page as-is in Content Player15incompleteCustom end page for Course Assessment 16incompleteGenerate telemetry + summary events [SB-17410 System JIRA](https://browse/SB-17410)Changes required in Content Editors

1. Generate QuML as per specification
2. Integrate QuML player to show preview to the creator
3. Learning platform would send QuML body in content archive package
4. Ensure correct & appropriate telemetry is generated from editor & player

**Gold (v0)** _Target release: 2.9.0_

1. Ready to use in
   1. Mobile
   2. Portal
   3. Desktop app
   4. Editors
2. MCQ - support for additional layouts
3. Support for Question set configurations - shuffle questions, show x/y questions, show/hide evaluation feedback
4. MSQ (MMCQ)
   1. Support for creating MCQ with multiple correct options
   2. Support for all / any correct option evaluation
5. Question type templates - FTB, MTF, Subjective&#x20;

**V1** \_Target release: \_

1. Support for timer in Question sets (Time restricted and Time counter)
2. Configuration to customise end summary page

## How will these capabilities be built?

Tech design&#x20;

## When will it be built?

Versions and Release plan&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

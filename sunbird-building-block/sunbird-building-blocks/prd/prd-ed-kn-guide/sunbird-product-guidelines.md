# Sunbird-Product-Guidelines-🚀

Sunbird aims to unlock various use cases in learning, teaching and learning administration spaces in diverse learning environments. It aims to allow adopters to solve problems across a breadth of scenarios and actors, while allowing them to deeply solve each of these scenarios. Hence, when any new capability needs to be introduced in Sunbird, there are a set of product guidelines that need to be kept in mind.&#x20;

This is an evolving document which we all as Sunbird contributors will keep updating and refining as per the changing education landscape and our experiences of trying to solve it.

**Checklist**

* [Driven by Need](sunbird-product-guidelines.md#driven-by-need)
* [Evolvable](sunbird-product-guidelines.md#evolvable)
* [Observable by design](sunbird-product-guidelines.md#observable-by-design)

### **Driven by Need** . Strong validated needs

At Sunbird, we try to build for needs arising from the ground (the end-user) to solve a real problem in their current context to stay relevant to the dynamic market. Starting with a strong validated need ensures the capabilities being built can be tested or piloted on ground and will be refined further to scale for a wider audience. Some of the questions have help refine the need are:

* Who is the target user group? Be specific about their context to define this as sharply as possible
* What is their challenge?
* How do they currently solve it? Or What do they currently do in their context because of which the problem exists?
* What is the proposed solution? What value will it provide or add to the user’s life?
* What resources, skills, infrastructure, capabilities, etc have we assumed about our users when designing the solution?
* Is this a need for a specific organisation or across organisation of similar nature?
* When thinking about a solution, make sure what you build is _needed_ at scale, _viable_ at scale, and thus _scalable_ .

### **Evolvable** (Maturity Model)

The capabilities being envisioned should layout a path to evolve them over time to cater to diversity while building the minimal version to serve the current need. It should be possible to evolve with time with changing needs on the ground, shifting landscape of education or the specific industry / sector in which Sunbird is adopted. Here are some of the guiding questions or thought-patterns to think evolvable:

* What’s the larger vision of the capability to serve diverse needs? (Apply generalisation explained next to arrive at this)
* How can I break it down into smaller / thin layers of capabilities that can be built over time?
* How does this integrate with other parts of the system? What is the core minimal functionality this building block is supposed to provide?
* What’s the generalised design that allows me to add/remove/configure more newer capabilities with least disruption in the core?
* What does the final envisioned UX look like? What are the various versions of it with incremental iterative changes?

**Generalisation** Solving for diversity (across actors, environments and use cases) at population scale cannot be done by pointed, hardcoded solutions.&#x20;

For example,

* &#x20;A capability built for a teacher to assign homework and monitor her students progress can easily be repurposed for use cases of adult learners co-learning together via a study circle. At the end of the day, both usecases need a group of users, activities and utilities for progress tracking.&#x20;
* Various actors and use cases require different types of assets - textbooks, courses, playlists, podcasts, videos, quizzes etc based on purpose. A generalised way of looking at this is that each use case really needs a combination of content types curated specifically for delivering an experience. I.e.&#x20;
  * All content in Sunbird are assets (like question sets, videos, PDFs etc.)
  * Which have certain attributes (like a timer, a certificate attached etc.)
  * Which can behave in a certain way (progress is tracked, test mode vs. practice mode for a question set etc.)
  * And can be organised or curated in a certain way (as a course or a playlist etc.)

Rather than building custom content types - the assets, attributes, behaviours and organization/curation method can be combined together to deliver the experience needed.&#x20;

Hence, while bringing in any new capabilities into Sunbird, there are some questions that need to be asked during the solutioning phase:&#x20;

* If one zooms out of the specific use-case, what are other similar types of use-cases across different actors and scenarios in the learning environment?
* Is the UX generalised enough to easily expand to these scenarios even if the MVP is focused on the specific scenario?
* How does this capability integrate (fit-in) with the existing capabilities and user flow?

**Configurable by design** One of the key value propositions of Sunbird is the configurability it provides. An adopter may need to configure anywhere from the theme to the navigation experience to the internals of a specific page or a section. Allowing capabilities to be controlled by external configurations minimises the dependency of rolling out a solution on the code development & engineering effort. This makes configurability one of the underlying product principles. Examples of externalisation:

* A new type of a collection (like a podcast) can be easily introduced through configuration, without the need for a code change.
* An adopter can configure a way to discover content that works best for their user base and their context - for eg., they can set up a section on trending courses or have a section highlighting content from that is in the user’s language. They can experiment with which configuration works the best for end users without needing to write code or release a new app every time.
* Creation experience can be simplified by configuring defaults and exposing only the required behaviour settings as per the use-case.

While designing a capability in Sunbird, these are some of the questions to be asked:

* Which parts of this capability are likely to change either often or are likely to change based on the user and their context?
* Is this capability likely to enable other use cases in the learning environment? If so, is there a way it can be designed to avoid code changes?
* Is there something that would need to be turned on or changed in the mobile app which needs to get out to the existing audience without needing everyone to get onto the latest version of the app? (For eg: Critical messages to get users to upgrade their app)
* Across various use-cases & scenarios, what is likely to change and what will remain constant? The variable and the constant together constitute a capability.

**Self-service by design** As Sunbird aims to solve societal education-specific problems at population scale, various adopters would find it difficult, expensive and unsustainable to hire large operations teams to manage their instance. Hence, when any capability is being built into Sunbird, the following questions need to be asked:

* Is there a way to enable this capability in a self-service fashion (i.e the user can do it themselves) without depending on an operations team? (For eg. can a course mentor configure rules to issue certificates for his/her course without needing help from the operations team)
* What sort of data and dashboards should the user be provided access to in order to enable them to truly gain control over the problem they are trying to solve without needing the intervention of operations teams?
* What self-help mechanisms are in place to help resolve typical user queries on a capability (FAQs, help documentation/videos, community forums etc.)?
* If time pressure forces one to rely on releasing the capability without self-serviceability inbuilt, what is the path to get there?

### **Observable by design** (i.e. data driven)

When solutions are rolled out at population scale, it is hard to know what is working and what isn’t without robust logging and telemetry in place. When every feature is being designed, there are a few things one needs to think about:

* What type of metrics does one need to figure out the success or failure of this capability when rolled out?&#x20;
* What is the dimensional data, the correlation data and what type of aggregation are you likely to look at to determine this?&#x20;
  * _Dimensional data:_ What are you likely to slice this metric by? By location? By device type? By acquisition channel?&#x20;
  * _Correlation data:_ Are there actions you would need to correlate? For example, do you need to know if the user scanned the QR code and then played a content attached to the same QR code? Or if a user opened up a textbook and then played a content from it, that is linked with the same QR code?
  * _Aggregation data:_ Is there data that you frequently need to calculate and refer to for analysis (for eg. average no. of ratings for a piece of a content or average time spent on the app per user)? If you need to calculate this frequently - it is more prudent to have it precomputed by the system so that you can refer to it as needed.&#x20;
* For what timeframe and how frequently are you likely to refer to this data?
* Is there a part of this data that needs to go into a dashboard in order to allow users to make decisions themselves?
* What type of monitoring is required to determine the health of the feature?

**Designed for diversity** Learning environments are inherently diverse. There is the diversity of demographics, needs and access to resources. Hence, while building a capability, the following questions should be considered:

* Are all constraints the user base is likely to face considered?
  * No internet or limited internet?
  * Low storage space? Is the capability likely to increase the size of the app?
  * Low end devices - OS, hardware config?
* Does the design consider multi-lingual interfaces?
* Does the capability need a mandatory login? Is there a way to lower the barrier of entry and allow guest access?&#x20;

Sunbird is designed to be inclusive and universal for anyone to access, anytime, anywhere.

**User testing** In the absence of segmentation as a core capability, most of the Sunbird features get rolled out to 100% of the audience unless an adopter chooses not to leverage that capability. Hence, before building in any capability the following should be considered:

* What problem does it solve for the user? Has both the problem and the solution been validated through user testing?&#x20;
* Do the designs and copy text need to be field tested? What qualitative and quantitative data is available to back up one's decisions on the capability and designs?

**Privacy, security and trust by design** There are strict data privacy laws in various countries - specifically when it comes to the data of minors. Hence, while thinking about data storage and access by different stakeholders, the following questions need to be answered:

* What all data is being collected?&#x20;
* Is collection of all this data truly necessary now? Or can it be added later if really needed?
* Who has access to this data, and what do they intend to do with it? When is this data likely to be used?&#x20;
* Is any of the data that is being shared considered to be PII? If so, has the necessary consent from the user been taken at the right time? Is it recorded in a non-disputable fashion? Does the user have the ability to revoke that consent?
* If any data on minors is being captured, has parental consent been taken? If so, how is it recorded in a non-disputable fashion?
* Does the T\&Cs and the language used on the interfaces communicate exactly what the data is likely to be used for?

Some policies and guidelines to be aware of:

* [COPPA ](https://www.ftc.gov/enforcement/rules/rulemaking-regulatory-reform-proceedings/childrens-online-privacy-protection-rule)
* [Google playstore policies](https://support.google.com/googleplay/android-developer/topic/9858052?hl=en)
* [Apple store policies](https://developer.apple.com/app-store/review/guidelines/)
* [GIGW](https://web.guidelines.gov.in/)

**Accessibility & inclusive design** The reference consumer apps provided by Sunbird are usually directly used as the base for multiple initiatives in the learning space (for eg: DIKSHA, which is the National Platform for School Education in India). Hence, they need to be accessible by design for all users, including those with special needs as per [Web Content Accessibility Guidelines](https://www.w3.org/WAI/standards-guidelines/wcag/). The UX design and product testing phases should consider these guidelines.&#x20;

* Can the interfaces be navigated with assistive devices, like screen readers?
* Are the UI elements on the screen the minimum size and contrast needed?
* Is there sufficient help documentation available if there is an accessibility-friendly version of a feature? (For eg. the content player on Sunbird maynot be fully keyboard accessible, but it allows download of content so that one can use it in the manner required - how is this communicated to the user?)
* Do the new interfaces/designs comply with the overarching accessibility features of Sunbird (font size controls, dark mode, keyboard accessibility)?

**Forward and Backward compatibility** Data from one of the Sunbird-based mobile apps shows that it takes around 3 months for 85% of users to get onto the latest version of the mobile app. Hence, features need to be designed keeping in mind that there is a significant audience on the older (N-1 and N-2th version of the app). Conversely, there may be times a certain feature may not be fully built on the server side but may need to be activated in a future time frame on the mobile app without necessarily needing a new release.&#x20;

Few guidelines:

* Backend services that support older functionality should continue to exist for at least 3 months. For example, if the older apps expect a PDF version of the certificate and one has optimised for certificate delivery times by using SVG certificates, the backend still needs to support PDF certificates till the majority of users move to the latest version of the app.&#x20;
* If an underlying data model (like the asset model) needs to undergo a change, data migration strategies should account for backward compatibility. For eg. let's say that the attribute name “Grade” has been changed to “Class” - then older apps will still expect the attribute called Grade and newer apps will expect Class. There will need to be a data migration strategy planned for all content on the platform such that it is discoverable on both the old and new apps.
* It takes time for users to get access to the latest capabilities one is releasing, and hence what are the program or app based constructs in place to nudge users onto the latest version of the app? (Note: Force upgrades should be used very sparingly as it comes at a cost to DAU)&#x20;
* Telemetry definitions can be added to, but cannot be modified or removed - as existing reports definitions/logic are dependent on those values. Older mobile apps will have the older definition, and keeping track of various definitions by app version is difficult to manage.&#x20;
* There are also instances of sideloading of the desktop/mobile app, which shows that users aren’t necessarily on the latest version of the app (mobile/desktop). This means that there will be a small % of data definitions/capabilities from the older versions of the app that continue to be leveraged.&#x20;
* When a capability is thought through, what may be the future scenarios that this may be leveraged for that can be preset up in the app? For example, making sure the app can read all types of notifications before the server capability of sending notifications is in place. This ensures that when the server capability is enabled, push notifications can be sent to a wider audience base.&#x20;

Backward compatibility also needs to be considered from a creator’s perspective. As a creator, I should be able to edit any of my previous contributions on the platform whenever I wish to.&#x20;

Few guidelines:

* Ensure that whenever an older version of content is being opened for editing, the relevant editor is launched.
* If the old editor needs to be deprecated, for any reason - maybe because it is difficult to manage two different editors - new & old, or any other reason. Make sure the new editor supports editing of old (previously created) content / assets

The editor could implement a migration script which migrated old content to new content format for editing in the new editor.

**Scalable and resilient** Most capabilities designed for Sunbird go live as part of the adopters implementation at scale from day one. Hence, while designing a capability, the following needs to be kept in mind:

* What is the likely load of concurrent and staggered usage that this capability is likely to see?
* What are the minimum acceptable response times of pages that need to be considered?
* What are the cross-platform requirements to be considered (OS, browser, mobile vs. desktop, minimum resolution, minimum device spec)?
* Are there any capability-specific NFRs to consider - maximum vs average no. of nodes in a collection, maximum vs average size of the collection etc.?

***

\[\[category.storage-team]] \[\[category.confluence]]

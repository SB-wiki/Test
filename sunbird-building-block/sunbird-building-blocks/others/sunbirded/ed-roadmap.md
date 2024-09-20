

| Theme | Problem | Outcome | Deliverables | Who | Release | Status | 
| Ease of deployment & upgrades to ED | Today it takes 3 weeks to deploy ED | ED should be deployed in one day using a ED installation starter kit | Phase 1: Install ED with minimal config and variables and upgrades to ED | Sanketika  | Oct '23 | Design In-Progress | 
|  |  | ED should be deployed as per adopters' usage needs  | Phase 2: Install ED as per adopters' usage & feature requirements<ul><li> _One click installers_ 

<ul><li>Ability to turn on / off certain features

</li></ul></li><li> _Reliability_ 

<ul><li>Automated weekly builds

</li></ul></li><li> _Rollback_ 

<ul><li>Support rollback post upgrade

</li></ul></li><li> _UI based configurations_ 

<ul><li>For frameworks, taxonomy, forms etc

</li></ul></li><li> _Installations based on TPS_ 

<ul><li>Enable one click installer to support installations based on required TPS

</li></ul></li><li> _Operations_ 

<ul><li>New ways to perform operations such as backups (Kubernetes native ways)

</li><li>Monthly upgrades process

</li></ul></li></ul> | Seeking contribution | Future |  | 
| Ease of operations | No self-serviceability enabled to carry out admin related activities such as user, tenant & framework management | Tenant Admins use an admin console to carry out user, tenant & framework management | ‘Instance Manager’ Admin Portal ([https://github.com/orgs/Sunbird-Ed/discussions/47](https://github.com/orgs/Sunbird-Ed/discussions/47) ) a) Create / Manage Organisation on Sunbird Instance b) Create / Manage Users c) Create / Manage Framework(s) d) Create / Manage forms e) Create / Manage user consent and PII info in reports | Parth/Ashwin (Tekdi Community) | Future |  | 
| Admin Self Service Portal for each Tenant -P1 (user management code base) a) Manage Own users b) View Own Reports c) Manage Frameworks | Parth/Ashwin (Tekdi Community) | Future |  | 
|  | ED reference apps and backend still has DIKSHA related references | ED reference apps can be used for the sake of learning and education  |  | EkStep Community | Dec '23 (7.0.0) |  | 
| Capability Enhancement | Adopters cannot use their existing authentication providers with ED | Adopters should be able to integrate ED with their own authentication and access management software | Ref: [https://github.com/orgs/Sunbird-Ed/discussions/239](https://github.com/orgs/Sunbird-Ed/discussions/239)a) Upgrading Keycloakb) Allow integrating any OpenID compatible authentication source (Eg: Google, Okta, Azure AD, GitHub etc)c) Ability for adopters to connect to their existing Keycloak | Mohit/Anil (Ekstep Community) | ETA to be added later | Design In-Progress | 
| Capability Enhancement | Sunbird ED isn't compatible with all cloud service providers. | Sunbird ED is cloud agnostic | Adopters should be able to deploy ED irrespective of the cloud service provider | Vinu (Ekstep Community) | Sep '23 | In-progress | 
| Capability Enhancement | Content published on Sunbird is visible across tenants. | Tenant admins are able to configure the content discoverability & access as per their needs. | a) Tenant level configurability of content discovery & access b) Within tenant at sub-org level configurability of content discovery & access - who can access what? | Seeking Contribution | Future |  | 
| Capability Enhancement | Sunbird doesnt support SCORM format. This format is currently the most widely adopted format of ELearning content development . 30-40% of the content used by organizations is in SCORM format. | Learners should be able to consume scorm content | a) Changes to editor to allow for uploading SCORM packages b) Changes to content service publish pipeline to process SCORM format content c) Changes to player to play SCORM content d) Necessary instrumentation changes to allow for tracking SCORM progress so that the same can be reported in progress exhausts and for users to resume from where they have left in the previous session | Parth/Ashwin (Tekdi Community) | ETA to be added later |  | 
| Capability Enhancement | Course authors cannot provide optional course material to the learners. All learning resources within the course are mandatory for learners to complete. | Courses with reference/optional material are published. | Ref: [https://github.com/orgs/Sunbird-Ed/discussions/34](https://github.com/orgs/Sunbird-Ed/discussions/34) a) Changes to editor to allow for authors to mark optional content in course. b) Changes to batch service to ensure that optional content progress isn't in scope for course progress calculations. c) Changes to mobile, desktop & web apps | Open for Contribution | Future |  | 
| Course ToC does not allow for learners to take the course in a controlled manner as defined by batch administrator. | Batch administrators are able to publish courses with are to be consumed in a pre-defined manner. | Ref: [https://github.com/orgs/Sunbird-Ed/discussions/262](https://github.com/orgs/Sunbird-Ed/discussions/262) a) Changes to batch service for batch admins to define how the course modules are to be consumed. b) Changes to mobile, desktop & web apps | Open for Contribution | Future |  | 
| Private batches are not supported in Sunbird. | Courses with private batches are published. | Added examples of what privacy can be allowed : [https://github.com/orgs/Sunbird-Ed/discussions/274](https://github.com/orgs/Sunbird-Ed/discussions/274) a) Changes to batch service  b) Changes to mobile, desktop & web apps | Open for Contribution | Future |  | 
| Capability Enhancement | Registered users of Sunbird do not have the agency to delete their account and erase their learning history. | Users have the agency to delete their account from Sunbird | a) In all the reference ED apps, users should have the option to delete their account | Pooja/Anil/Prateek (EkStep + SL) | Dec '23 (7.0.0) |  | 
| Ease of experiencing ED | As a potential adopter I find it difficult to understand Sunbird and what the various buiding blocks have to offer |  | a) Marketing website | Pritha | Sep '23 | Done | 
| There are no Ready to use tools to experience ED’s capabilities in the consideration stage | Adopters are able to deploy their own trials |  | Parth/Ashwin (Tekdi Community) | ETA to be added later |  | 
| Externalization of Sunbird | <ul><li>Current Sunbird frontends are highly opinionated & not easily configurable. 

</li><li>Developing new frontends/ modifying them has a very large learning curve of understanding various SB Artefacts & APIs

</li><li>Unopinionated, highly configurable frontend interfaces with its own Admin configuration microfrontend which allows configuring all required APIs via UI, Allows easy theming & styling, overriding language constants will make this a more generic starter tool & allow for easier adoption

</li></ul> | <ul><li>Adopters can quickly use the Configuration UI to configure & deploy various frontends like Web , PWA, Mobile etc. 

</li><li>Exposure to React Community which is a fast growing Pool 

</li><li>Alignment with Shiksha which is being driven by various related stakeholders in the ecosystem like Samagra, Avanti. Ready modules here will allow these ecosystem partners to also contribute more

</li></ul> | a) Reference Sunbird frontend using Shiksha | Parth/Ashwin (Tekdi Community) | ETA to be added later |  | 
|  | In the ED reference web app, filter level changes needs code change. | Adopters are able to design their own filters on the fly for their ED web app | a) Page level filter configurations: [https://project-sunbird.atlassian.net/browse/ED-306](https://project-sunbird.atlassian.net/browse/ED-306?filter=12696) | Krishna/Vinu (Ekstep Community) | 5.1.1 (Jan 2023) | Done | 
| Sunbird Adoption Growth Hacks | <ul><li>Sunbird has limited organic discoverability. Leveraging an existing community that has already achieved scale will accelerate discoverability

</li><li>Current Sunbird frontends are highly opinionated & not easily configurable. 

</li><li>Developing new frontends/ modifying them has a very large learning curve of understanding various SB Artefacts & APIs

</li><li>Requires knowledge of Angular which has resource scarecity in the market today . This allows exposure to a community that has deep skills in Wordpress & PHP making the BBs accessilble to a wider audience

</li></ul> | <ul><li>Sunbird is Discovered by the Wordpress community worldwide in the form of a wordpress plugin opening up Sunbird to the large community & Developer ecosystem that is Wordpress

</li><li>Lowers entry barrier & allows any Wordpress User to use Sunbird with the comfort of offering SB features through their wordpress website 

</li><li>extensive wordpress theme , template & developer community can accelerate adoption worldwide

</li></ul> | a) Wordpress plugin for Sunbird | Parth/Ashwin (Tekdi Community) | ETA to be added later |  | 
| Capability Enhancement | Any changes needed to the on-boarding steps in portal & mobile app need code changes. | Adopters able to configure the on-boarding steps as per their need | Portal:a) [ED-222 System JIRA](https:///browse/ED-222) b) [ED-214 System JIRA](https:///browse/ED-214) | Krishna/Vinu (Ekstep Community) | 5.1.2 (Feb 2023) | Done | 
|  |  |  | Mobile App: | Krishna/Vinu (Ekstep Community) | Future |  | 
| Capability enhancement | ED enables few on-demand exhausts out of the box. However, ability to configure real time custom reports isn't supported. | Adopters able to configure real time reports as per their need | Report service which can aggregate data from various sources to create custom reports. Ref:[https://github.com/orgs/Sunbird-Ed/discussions/23](https://github.com/orgs/Sunbird-Ed/discussions/238)8 | Parth/Ashwin (Tekdi Community) | ETA to be added later |  | 
| Capability enhancement | ED provides a few roles out of the box. However, it doesnt support configuring new custom roles as per the adopters' need. | Adopters should be able to define the roles appropriate for their organization using the admin console | a) The organization admin can create custom roles through the admin console b) Admin can create user groups. c) User groups can be assigned to role and get the role level access. d) User group can be given access to activities irrespective of the role to user belongs. e) Group level access of user supercedes the Role level access. | Parth/Ashwin (Tekdi Community) | ETA to be added later |  | 
| Capability enhancement | Adopters want to migrate tenant data from one tenant to a new instance or vice-versa. |  | a) Script to facilitate tenant data migration ref:[https://github.com/Sunbird-Ed/Community/discussions/29](https://github.com/Sunbird-Ed/Community/discussions/294)4 | Open for contribution | Future |  | 
| Tech Debt |  |  | a) Angular migration from 9 to 14 | Krishna/Vinu (Ekstep Community) | 6.0.0 (Sep '23) | In-validation | 
|  |  |  | a) KeyCloak Upgrade | Mohit/Sajesh (EkStep Community) | 7.0.0 (Dec '23) |  | 
|  |  |  | a) Ubuntu upgrades for Sunbird environment | Santhosh G (EkStep Community) | Oct '23 | Design In-Progress | 
|  |  |  | Completion of API automation | EkStep Community | 7.0.0 (Dec '23) |  | 
|  |  |  | Ease of debuggability: a) Implementation of request traceability for faster debugging of issues | EkStep Community | 7.0.0 (Dec '23) |  | 
|  |  |  | Optimize Sunbird Dev & Staging environments | EkStep Community | 7.0.0 (Dec '23) |  | 



*****

[[category.storage-team]] 
[[category.confluence]] 

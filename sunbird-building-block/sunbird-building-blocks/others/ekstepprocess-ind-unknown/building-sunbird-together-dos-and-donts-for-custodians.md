As we evolve our own culture of developing open source projects, it’s important to stay aware of how Repo Owners of Sunbird are expected to support other participants in the ecosystem. We’ve put down a few do’s and don’ts for your reference. 

If you find yourself facing a situation where you’re not sure of how you should respond - please reach out to any of the following team members: 

If you’re not sure about reaching out to any of the people above, please remember that reaching out to your immediate manager is always an option. Tell somebody, please don’t stay silent.

This is a living document. It evolves as Sunbird evolves. We’re building this together, and we’ll identify solutions together. We’re very early in our journey, and it’s likely that our processes and activities are not the most optimal - we will refine it together.

* [Terminology](#terminology)
* [Vision](#vision)
* [Dos](#dos)
* [Dont’s](#dont’s)



# Terminology
For the sake of clarity, we’re going to define specific terms we use in this document:

 **Contributor:**  Any organization that is adding to Sunbird and willing to maintain the code they’ve added for a significant duration.

 **Repo owner:**  Any organization that is accountable for a specific Sunbird service (or set of Sunbird repositories). Accountability here involves ensuring (a) alignment with the design principles of Sunbird, (b) high quality code; and that (c) the code is easy to understand and maintain.


# Vision
Our end-goal is that Project Sunbird becomes a collaborative endeavour where there are multiple repo owners each watching over specific Sunbird services, so that there is no ONE repo owner of Sunbird (organization or individual).

For the sake of this, the goals are:


* to make the system as self-serviceable as possible, with guardrails to ensure the least failure by anyone choosing to contribute to Sunbird. An example of a guardrail will be the automated test cases that we require any code contribution to have, so that if anything fails - the contributor knows what it is and is able to fix it themselves.


* to allow any motivated organization to grow itself from the role of newcomer, to contributor to repo owner - without non-essential manual intervention.



Please keep the above vision in mind, as a guiding principle for your interactions with one another and contributors. A step that you’re taking might seem easy and appropriate in the short term, but is it right for the long term? Does it serve the above vision? Answers will not be black or white, and there will be times when we unblock ourselves for the short term, but these have to be careful and conscious decisions keeping the above vision in mind.


# Dos

1.  **Be kind to one another.** As repo owners, we’re likely to suffer from the curse of knowledge - we just know too much about what we’re working on. Do not assume that others around you have to OBVIOUSLY know what you’re working on, or the fundamentals that you base your work on. Do not assume this even if they appear to have significantly more experience than you do.


1.  **Interact in the open.**  We have been building technology and processes at a pace that we didn’t have a few years ago. Future contributors and repo owners are yet to build up to this pace. If our interactions with others (including our own teams) happen in the open, people in the future will better understand the culture of how Sunbird was built, the problems/tensions that we face, and how we arrive at the final resolution. This also helps people understand WHY certain decisions were taken. What is true today, may not be true tomorrow. If people understand WHY we took a specific decision today, it can be easier for them to rebuild a specific tech/process based on what is true at their time.


1.  **Document what you are building in an easy-to-absorb manner.**  We are not permanently going to watch over Sunbird. Enable the future repo owners and contributors to understand what you have designed and built in a frictionless manner. The lesser friction (and more enjoyable) the learning process is, the sooner we have multiple accountable partners ensuring the flourishing of Sunbird.


1.  **Be clear on what you are responsible and accountable for.**  As a member of a Sunbird repo owner, are you fully aware of what responsibilities you have and what you cannot drop? There are multiple activities happening, be very clear on what you’re expected to do, and where you can offer help. If every one of us takes absolute care of the duties we’re expected to fulfill, and offer help where we can afford to, Sunbird will grow with a sure and secure foundation. Even if you’re a little unclear on the specific duties you’re expected to serve, please speak to your lead at the earliest. At a high level:


    1.  **Tech team:** 


    1. The code you design and write, and the test-cases and documentation for the same.



    
    1.  **Tech owners:** 


    1. The review that you do for what the tech team writes, and quality of the deliverables from your team.


    1. The review of the detailed tech design and code submitted for PRs by contributors, to verify that it aligns with Sunbird principles and quality guidelines.



    
    1.  **Product owners:** 


    1. The product definition, acceptance criteria and sign-off for the product features you watch over.


    1. The review of the product definition and acceptance criteria for the features by contributors, to verify that it aligns with Sunbird principles and product guidelines.



    
    1.  **Product design:** 


    1. The design guidelines and deliverables for the product designs that you watch over.


    1. The review of the design deliverables by contributors, to verify that it aligns with Sunbird design guidelines.



    
    1.  **Quality assurance:** 


    1. The QA guidelines and deliverables for the test cases and scenarios for the products built by the repo owner.


    1. The review of the test cases and scenarios by contributors, to verify that it aligns with the Sunbird QA guidelines.



    
    1.  **Documentation:** 


    1. The documentation guidelines and deliverables for the products that are built by the repo owner.


    1. The review of the documentation by contributors, to verify that it aligns with Sunbird documentation guidelines.



    
    1.  **Dev Ops:** 


    1. The uptime of the Sunbird dev and staging environments.


    1. Keeping an eye on resource utilization, to ensure what’s being newly added doesn’t break the system in production.



    
    1.  **Sunbird Design and Product Council:** 


    1. The Sunbird design and product principles are published in the open.


    1. The reduction of gap in knowledge between repo owners, contributors, adopters and newcomers.


    1. The Sunbird contributions and maintenance process is efficient.


    1. The Sunbird open-source project doesn’t implode/explode.



    

    
1.  **Highlight and help fix gaps in Sunbird processes.**  The people mentioned above (org leadership) will not be able to identify many gaps, because they aren’t present at all touch-points. But you are interacting with other people and the development process everyday. When you notice an inefficiency in the process, bring it up - we’ll add it to a list, and treat it like we handle P1/2/3 bugs. Yes, some of it won’t be resolved in the next month - and will likely hang around for years. But atleast everyone will be aware of it.  If you can fix it, and tell us how you did it, that would be supremely beneficial. Just inform a lead that you’re going after it and keep the vision in mind if you attempt to go after it yourself.


1.  **Be willing to ask for help.**  It’s completely ok to ask for help. Self-help is the best help, but if unable to help yourself - just ask. How do you know you need help? If you’re feeling unnecessary stress, and feel like you’re barely managing to keep your head above water, it is likely that you need help.


1.  **It’s ok to say no.**  You will find yourself in situations where you can’t willingly and enthusiastically say yes. If you’re unable to support something, please say no. If you can, direct the incoming request to someone else that you know can better handle it. Maybe you’re not the right person for that specific situation, the requester will reach out to someone else. Maybe you ARE the right person for that specific situation, but you don’t have the resources (this includes time and mental bandwidth) to handle the incoming request. People around you will work towards helping unblock the situation.


1.  **It’s ok to raise a concern at ANY point.**  Did you notice a breakdown somewhere? Have you been helping with a concern for some time in the past, and now don’t know how to step away from it? It’s all right. Let us know. The point is to evolve the process and our documentation to a level that people can move into self-serve. We are aiming to improve efficiency in all areas, towards delivering the final outcome - a world class learning management infrastructure, with multiple repo owners. Maybe you stayed silent so far, it’s perfectly all right to bring it up now. Better late than never.




# Dont’s

1.  **Do not stay silent.**  Do you notice something going wrong? Maybe it feels wrong? Speak up. It’s ok if you want to get involved to help solve the immediate problem, but bring it up to your leads or someone from the above list of people, so we can avoid the situation becoming more difficult than what it currently is.


1.  **Do not take on the responsibility of another individual/organization.**  The construct of repo owner and contributor has been carefully arrived at, to ensure decentralized progress for the Sunbird project. If you can offer help at a very low cost (including time) to yourself, feel free to do so. Also, let the contributor know where they’ve deviated from the process so they can self-correct the next time. But if this is becoming a pattern, it likely means that our process is suboptimal and needs to be fixed. Raise the concern immediately so we can reduce friction to contributions - and in turn help ourselves and others.


1.  **Do not encourage conversations with external organizations in private mediums.**  This is something we’re all struggling with. This is NOT easy to shake. So, let’s start with why we need to avoid this. Going back to the vision, we’re trying to ensure that incoming contributors can have frictionless onboarding and growth within Sunbird. As people, we observe an existing community before deciding to engage with it. Think back to how you start interacting with a new group of people. You first observe them from some distance, and then you get involved (unless of course, you’re the daring person who jumps in and figures ongoing interactions and dynamics within a social group on the fly). If you had a way to see how other people get through their early discomfort, you face lower friction when you actively get involved. This is why most organizations have a few onboarding sessions, or a buddy program, and even team dinners / open houses / all-hands sessions.

    When you encourage a discussion in a private medium (e.g. a call, or DM in slack, or email) - yes, it helps people be more comfortable and open, but it also means that some information was missed in the process due to which the person making the request reached out to you in private. Having this discussion in private means we don’t have an interaction that we can point a future contributor to (saying this is how we solved this concern in the past). You can’t ‘google’ a problem, if the problem wasn’t written in an open medium in the first place. We want to be in a situation in a year or two, where you can google ‘how to solve x in Sunbird’.

    If you do decide to have an interaction in private, and there was information shared that would be useful for more people in future - please put up a digest/note on what was shared on one of the public mediums. This will hopefully reduce the time needed from you (or someone from your team) to have this same discussion again with another partner.







*****

[[category.storage-team]] 
[[category.confluence]] 

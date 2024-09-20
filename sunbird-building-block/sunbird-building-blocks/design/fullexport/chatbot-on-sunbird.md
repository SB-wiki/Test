# Chatbot-on-Sunbird

## About

This document details the chatbot architecture principles and the functional use cases addressed via chatbot.

## Use Cases

Chatbot on Sunbird is positioned as:

* a capability which can help users with the discovery of relevant content on the platform
* virtual help desk which can resolve users' queries

Chatbot can be configured for users to:

* initiate free flow conversations or
* guided discovery or
* both of the above

Below use cases are under consideration to be supported on Sunbird:

* As a org admin, I should be able to configure my own guided journey workflows on the platform.&#x20;
  * these guided journeys will help users discover relevant content on the platform as configured in the workflows and as per the rules configured for each of these workflow
* As a org admin, I should be able to render the workflows in the below consumption channels
  * sunbird portal & mobile app
  * external channels such as whatsapp, slack, telegram etc

## Scenarios

1. An org launches their own program on the platform. Chatbot is used to enable ease of discovery of the program either by:&#x20;
   1. all the assets which are part of the program are tagged to a unique keyword. The {keyword + asset meta data} is used in combination to help users discover the assets related to a program.  OR
   2. all the assets which are part of the program are tagged to a certain primary or additional category. The {primary/additional category + asset meta data} is used in combination to help users discover assets related to a program OR
   3. The {asset url} is provided directly to help users discover the asset
2. Chatbot is used to enable discovery of content published by an org.

***

\[\[category.storage-team]] \[\[category.confluence]]

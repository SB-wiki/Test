# Menu-configuration-deploy-to-blob-steps

This wiki help QA team to verify below ticket and also

[https://project-sunbird.atlassian.net/browse/SB-21295](https://project-sunbird.atlassian.net/browse/SB-21295)

This below steps need follow to get deploy/run with following steps:

**Step 1:**

Modify the configuration in Diksha private repo ([https://github.com/DIKSHA-NCTE/Diksha-Bot/tree/master/router/config](https://github.com/DIKSHA-NCTE/Diksha-Bot/tree/master/router/config) ).

Its just adding/modifying steps in chatbot for Menu driven flow.

**Step 2:**

Modify the configuration files based on requirements then Raise PR against to release branch for same. Request for PR merge, Once PR merge done. follow next step

**Step 3:**

Deploy this jenkins job in which environment you want to verify (Ex: [Preprod Jenkin Job )](http://10.20.0.9:8080/job/Deploy/job/pre-production/job/Kubernetes1/job/UploadChatbotConfig/)).

Once done this Job successfully. Ask implementation team to run below curl command.

**Step 4:**

Run below curl command in which env you want to verify

curl -X POST \\

&#x20; {[{host\}}/chatapi/refresh](https://preprod.ntp.net.in/chatapi/refresh) \\

&#x20; \-H 'cache-control: no-cache' \\

&#x20; \-H 'content-type: application/json' \\

&#x20; \-H 'postman-token: a98ba7e7-2bd9-7a91-bae6-829972da0ece' (edited)&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

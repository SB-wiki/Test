
* A Nginx proxy will be needed.
* Wildcard DNS pointing to the proxy server will be needed
* Reason for proxying [sunbird.org](http://sunbird.org) (Marketing website) - We can set Permanent rewrite URL with HTTP status 301 302 from [sunbird.org](http://sunbird.org) to [docs.sunbirg.org](http://docs.sunbirg.org)

Required Nginx Server blocks for proxying - **Marketing website -** 


* [sunbird.org](http://sunbird.org)
* [www-qa.sunbird.org](http://www-qa.sunbird.org)
* <pr-id>.www-qa.sunbird.org

 **Docs website -** 


* [docs.sunbird.org](http://docs.sunbird.org)
* [qa.docs.sunbird.org](http://qa.docs.sunbird.org)
* <pr-id>.[qa.docs.sunbird.org](http://qa.docs.sunbird.org)

Related Jira Issues: [SB-5494 System JIRA](https:///browse/SB-5494)

[SB-5497 System JIRA](https:///browse/SB-5497)

[SB-5495 System JIRA](https:///browse/SB-5495)



*****

[[category.storage-team]] 
[[category.confluence]] 

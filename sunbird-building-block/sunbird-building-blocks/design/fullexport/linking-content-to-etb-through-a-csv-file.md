
###  **Link to issue** : [SB-9805 System JIRA](https:///browse/SB-9805)


 **Problem Statement** As ETB content is done through CSV upload, there are chances of issue in the input data. So before processing the data it is desirable to validate the data before starting the linking process.

Here is the flow which validates the topics, dialcodes & content before update hierarchy api is invoked.



 **Flow to validate and link content through csv file:** 
1. read textbook data by id (/content/v3/hierarchy)
1. validate the dial codes provided in csv file with textbook data.
1. get the framework Id from textbook data and get framework data (/framework/v3/read)
1. validate the topics provided in csv file with the framework data.
1. validate the content ids provided in csv file (/composite/v3/search)
1. once validation done, create the request and update the hierarchy (/content/v3/hierarchy/update)
1. once hierarchy got updated call dial code link api (/content/v3/dialcode/link) to link the dial code.



*****

[[category.storage-team]] 
[[category.confluence]] 

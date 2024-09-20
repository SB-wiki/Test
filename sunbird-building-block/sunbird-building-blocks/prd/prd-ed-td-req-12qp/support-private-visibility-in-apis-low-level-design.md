
### Read API
 **Public Read API - (Existing)** 


* We will add a visibility condition and return the content only if visibility is not private and fetching the data if visibility is public, parent, and default. 



 **Private Read API** 

- We will create a new API with endpoint /content/v4/private/read/:identifier


*  We will add a new method privateRead in the existing controller and actor.


* We will filter the content based on the following conditions and return the data only if true:

     - visibility condition is private

     - channel id from the header


* We are restricting the data if visibility is public, parent, and default by returning the error code.



 **→** Similar implementation is applied to collection, question, and question set.


### Search API
 **Public Search API - (Existing)** 


* We will add a visibility condition and return the data only if visibility is not private and fetching the data if visibility is public, parent, and default. 



 **Private Search API** 


* We will create a new API with endpoint /v3/private/search


*  We will add a new method privateSearch in the existing controller and actor.


* We will filter the content based on the following conditions and return the data only if true:

     - visibility condition is private

     - channel id from the header


* We are restricting the data if visibility is public, parent, and default by returning the error code.





*****

[[category.storage-team]] 
[[category.confluence]] 

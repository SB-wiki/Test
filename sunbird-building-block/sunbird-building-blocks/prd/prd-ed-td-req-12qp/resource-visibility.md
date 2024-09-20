
## Use case:
The state will create its question papers on Diksha using the Sourcing portal; Vidyadaan (Prashnavali). Once the question paper is finalized it will be published on the Consumption portal; Diksha with private visibility. 

Once the Question paper is created and published(privately), it will be accessed by:


1.  **External Applications -** The external applications will call 


    1. Consumption Search API (Diksha API) to get the list of question papers that are published and are private.


    1. Content read API to get the complete question paper.

    These API request needs to be 


    1. Authenticated - who is calling the API is checked


    1. Authorized - The entity calling the API, with the request to access private question paper will receive the Question paper details if they are allowed to, in case of unauthorized access the request should return an error.



    

    
1.  **Users with administrator role -** Users (assessment wing Admins)  who are given the authorization to view the private question paper, when they logon on to Diksha, they can view the question paper resources which are private as well.

     _Note:_ 

     _- Any user (teacher or admin) can be given this authorization. (Typically within the contributing org circle)_ 

    -  _Not all users involved in question sourcing will have access to the private question paper_ 





 **Enhancement required:** 

Access Control at the API level - 


* At present - Diksha has ACL at the frontend level and not at the API level.


* Required - ACL (Authentication and authorization) at the API level 

     _Here we have a special use case of a resource question paper that can not be made publicly available._ 







*****

[[category.storage-team]] 
[[category.confluence]] 

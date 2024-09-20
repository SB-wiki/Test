Meeting - 1


## Consumption Repo 

### Search API
There will be two sets of search and Read API on the consumption repo:


* Public Search API (Existing) to provide public content only. 


* Private Search API (new) to provide Private as well as public content



 **Public Search API - (Existing, Changes needed)** 


1. At present, if a specific request is made for the private content through API. the private data is also returned. This behavior needs to be updated.

    Going forward only Public content should be returned In the current behavior, it also returns private content, if specifically asked for it.

    (Change) - Not allow private content to be returned. Only public content should be returned.



 **Private Search API (New)** 


1. (New) New API to be created


    1. An exact replica of the public Search API


    1. One relaxation from the public search API - This should return both Public & private content


    1. Will work only on API Token-based authentication


    1. The API token will be linked to a tenant - Only content of that tenant is returned



    
1. Restricting access 


    1. Private content access


    1. Only share content via Private Search API


    1. API must be called with a token



    
    1. Tenant level restriction - only content related to the tenant is shared 


    1. The API token is linked to a tenant


    1. User (if registered on Diksha) sends User Token as well as the API token - Tenant is recognized based on 1st user token, 2nd API token, then the access is given to private content


    1. In absence of tenant details, API token the access is marked as unauthorized acees



    

    

( _Similar implementation - tenant linked to API token, is already done for Data Exhaust_ )


### Read API
Exactly the same as the search APIs, there will be two sets of API on the consumption repo:


1. Public Read API (Existing) to provide public content only. 


1. Private Read API (new) to provide Private as well as public content



 **Public Read API - (Existing, Changes needed)** 


1. (Change) Restrict returning of any private content, even when specifically asked in API call. At present, private content is also returned. (Same change as public search API)



 **Private Read API** 


1. (New) New API to be created


    1. Replica of public read API


    1. (Change) This API is allowed to return private as well as public content


    1. The API token is a must while calling this API


    1. API token - linked to a tenant - Only content of that tenant should be returned



    
1. Restricting access


    1. Private content access


    1. Only share content via private read API


    1. API must be called with a token



    
    1. Tenant level restriction


    1. The API token is linked to a tenant


    1. Only content related to that tenant is allowed



    

    




## Sourcing repo
 **4.2 Development** 


1. Search and Read API will provide both private and public content to the contributor


    1. (Change) need to check the current behaviour of API and allow all (private, public) content



    
1. Through Frontend flows -  Access will be restricted to only contributors and reviewers


1. If a specific API call is made it would return both the private and the public assets


1. APIs will be accessed based on API token



 **In 4.3 or beyond** 


1. We need solve for the situation where external restriction can be made to access private and public content based via APIs as well.













*****

[[category.storage-team]] 
[[category.confluence]] 

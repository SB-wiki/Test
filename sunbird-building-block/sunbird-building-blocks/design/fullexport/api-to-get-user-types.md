[SC-880 System JIRA](https:///browse/SC-880)



 **Overview** As part of user search result enhancements, we will require user to be able to filter based on user-type.

For that, we need a way to fetch the available user-types.



 **Approach 1** 

Create a look-up table within database, and return it from there.

 **Pros:** 


* Systematic proper approach for persistence of look-up
* Additional values don't require code-changes.

 **Cons** 


* Will result in unnecessary I/O calls for pretty limited data.
* It will extend database design without much advantage.
* As such we are using Cassandra - and such table is useful if we can apply foreign key constraints at database level.



 **Approach 2 (Preferred)** 

Use hard-coded values from existing enumeration created for the purpose

 **Pros:** 


* DB storage not required
* Easy to implement.

 **Cons:** 


* Enumerated values are stored within code, so additional value requires code-change

Given the simplicity of the data, and no forseen future requirements to maintain it as a seperate entity, we propose to use Approach 2.



 **Approach 3** 

Store the user-types available in user-profile configuration. 

 **Pros** 


* Flexible per installation - one can have different user-types - different display-names

 **Cons** 


* Difficult to apply business logic based on user-types.
* Difficult to maintain - if someone changes user-types list, especially remove existing value can become a problem for data-consistency.

 **API Definition** 


```js
Response: 200 OK

[ "TEACHER", "OTHER"]


```




*****

[[category.storage-team]] 
[[category.confluence]] 

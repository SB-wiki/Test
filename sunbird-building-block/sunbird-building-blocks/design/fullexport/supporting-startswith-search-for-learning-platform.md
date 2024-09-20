[SB-10552 System JIRA](https:///browse/SB-10552)

 **Overview** As part of ticket SB-8173 - user search result is being enhanced, and following new filters will get added:

User Type/ Medium/ Class/ Subject

District/ Block/ School/ Role

This will require us to enhance the searching capability in learning platform to support -  **startsWith**  operator, so that locations search can allow auto-complete feature.

 **Proposed Solution** We will be adding support for operators  **startsWith** and  **endsWith** so that API user can create such filters for searching.

User will have to specify query as follows:




```js
POST   /v1/location/search

{
 "filters":{
   "type: : "block",
   "startsWith" : {"name": "KA"}
  }
}
   
```
Based on above query, first matching page of records will be returned.

Currently, there seems to be some bug/issue due to which starts_with, or ends_with filter are not working correctly.





*****

[[category.storage-team]] 
[[category.confluence]] 

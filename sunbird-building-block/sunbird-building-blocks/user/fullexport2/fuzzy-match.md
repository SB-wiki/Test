# Fuzzy-Match

### \*

* [Solution 1: ](fuzzy-match.md#solution-1: )
* [Solution 2:](fuzzy-match.md#solution-2:)
* [Solution 3:](fuzzy-match.md#solution-3:)
* [Solution 4:](fuzzy-match.md#solution-4:)
* [Fuzzy Match :](fuzzy-match.md#fuzzy-match-:)
* [ Library explore for fuzzy match](fuzzy-match.md# library-explore-for-fuzzy-match)
* [Test Data set:](fuzzy-match.md#test-data-set:)
* [Test Scenario:](fuzzy-match.md#test-scenario:) Problem statement: System need to find all uses associated with particular identifier (phone/email and prevUsedPhone/prevUsedEmail) and then on top of that response it will do fuzzy name match.&#x20;

### Solution 1:&#x20;

&#x20;We can enhance user search api to do following activities:

```js
URL: {BaseUrl}/private/user/v1/search
Method: POST
Request body:
  {
    "params": {
    },
    "request": {
        "filters": {
            "$or":{    
                "phone": "phone number",
                "prevUsedPhone": "same value as above "
             }
        },
       "fuzzy": {
             "firstName" : "value"
            }
    }
  }

Response: 
       *  Search api will provide user email,phone,prevUsedEmail,prevUsedPhone as masked form.
       * if no user found with provided identifiers then system will return 200 ok , with count 0, 
       * if multiple records founds with provided attribute but name didn't match , system will provide status code as 206 and ERROR-CODE : "NAME-NOT-MATCH"
       * provided name in request if contains any space will be splitted and will splitted names in a doc which will enhance the searching capability of the      library 
       * if multiple records found and user name also matched then it will return  200 status code and ERROR-CODE will be success              



```

* when search request contains fuzzy attribute then only special search behavior will occur otherwise normal search will happen.
* &#x20;We have enhance system to support or search under filter \[\[User Search with email or phone|User-Search-with-email-or-phone]]
* on top of final response ,it will perform fuzzy search, Whatever document will match with fuzzy search that will be retun in response.

| Pros                         | Cons​                                                                                                                                          |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Reuse of existing search api | <ul><li>  As this functionality has some different search criteria and use case , so need to handle request and response differently</li></ul> |

NOTES: We have enhance search capability to support OR operation inside filter.

### Solution 2:

&#x20; Provide a separate endpoint for doing all these activities.

```js
URL: {Baseurl}/private/user/v1/fuzzymatch
Method: POST
Notes: Request and response body will be same as Solution 1. And it will do exact same business logic as solution 1 is doing.



```

| Pros                                                                                                                                                                                                                | Cons                                                |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| <ul><li>Clean and separate implementation</li><li>in future only one reason of change , if business requirement of fuzzy search got change </li><li>other api won't have any impact due to separate impl.</li></ul> | <ul><li>Need to maintain one new endpoint</li></ul> |

### Solution 3:

&#x20;  Consumer can make two search api call,one with phone/email and another with prevUsedPhone/prevUsedEmail and then they can do fuzzy name match on client side.

&#x20; \* In search api , system will provide maskEmail/maskPhone as well, as of now these data are not provided.

### Solution 4:

&#x20;       Search api can be enhance to support "OR" query. Consumer will make search api call and then do fuzzy match on client side.

### Fuzzy Match :

We have explore following option for fuzzy match

1. Elasticsearch fuzzy api:  As this fuzzy api will return all matched document , there might be possibilities having more than 10k records. in that case we need to use cursor.And finally we need to match small set of document with large set of  fuzzy match document. Elasticsearch fuzzy api is not supporting exact match and then on top fuzzy match.
2. &#x20;xdrop/fuzzywuzzy : This library is doing string fuzziness match and it will provide matching weight.
3. intuit/fuzzymatcher : This library is same as option 2, instead of taking String and matching it's accepting com.intuit.fuzzymatcher.domain.Document object .
4. Apache lucene fuzzy search :  This search is applicable only with saved document object.

Will use Solution 1 for user search and for fuzzy match will use  **intuit/fuzzymatcher** library

### &#x20;Library explore for fuzzy match

| Library                 | Pros             | Cons | License |
| ----------------------- | ---------------- | ---- | ------- |
| Elasticsearch fuzzy api | supported by ES  |      |         |

1. And operation is not supported with fuzzy match
2. it can return more than 10k records for name match

\| Apache | | xdrop/fuzzywuzzy | String based match and providing weighted for each string |

1. Issues with single character or only two char pass , it will provide weighted more than 60%

\| GPL-3.0 | | intuit/fuzzymatcher |

1. It's Document based match
2. Match weighted can be configured
3. For single char it's not matching with completed string

\|   1. Need to created intuit document object to do match | Apache-2.0 |

### Test Data set:

```js
Manzarul, 
Manzaruhlaque, 
Haque, 
Monzarul, 
Manzhrol, 
Manzhrol, 
Manmmet, 
Manzhar, 
Manzhar, 
manzar, 
manjar, 
zanjoor, 
Manzaru haque, 
Stephen Wilkson, 
John Pierre, 
“Wilson, Stephen”, 
Pierre john, 
Stephen Kilsman wilkson, 
ma
```

### Test Scenario:

| ​Input        | **Threshold** | Matches with                                                                 | Comment |
| ------------- | ------------- | ---------------------------------------------------------------------------- | ------- |
| manzarulhaque | 0.5           | 'Manzarul','Manzaruhlaque','Monzarul','Manzhrol','Manzhar','manzar','manjar' |         |

\| The first 8 characters are seen matching. | | manzarul | 0.5 | 'Manzarul','Manzaruhlaque','Monzarul','Manzhrol','Manzhar','manzar','manjar'

\| The first 8 characters are seen matching. | | manzarul haque | 0.5 | Manzaru haque | Notice the despite the missing 'l', the name is called matching and is absolute. | | manzarul haque | <0.5 | 'Manzaru haque','Manzarul','Manzaruhlaque','Haque','Monzarul','Manzhrol','Manzhar','manzar','manjar'

\| Any value less than 0.5 matches with far too many values. | | haque | 0.5 | Haque | Capitalisation is not a problem, but notice it doesn't match with any of the second names. | | haque | <0.5 | 'Manzaru haque','Haque','manzarul haque'

\| If the threshold is less than 0.5, then the input is matched with first-name and second-name. | | manzarul | <0.5 | 'Manzaru haque','Manzarul','Manzaruhlaque','Monzarul','Manzhrol','manzarul haque','Manzhar','manzar','manjar'

\| | | Man ha | all | no data | Not matching at all, which is good. | | Man haq | 0.5 | no data | Not matching at all, which is good. | | Man haq | <0.5 | 'Manzaru haque','Haque','manzarul haque'

\| If the threshold is set less, it starts to match. This is best avoided to prevent misuse of this option. | | Manzar haq | 0.5 | 'Manzaru haque','Manzarul haque'

\| Missing few characters is ok. | | haque manzar | 0.5 | 'Manzaru haque','Manzarul haque'

\| Ordering is handled. | | Stephen | 0.5 | no data | | | Stephen Wilkson | 0.5 | 'Stephen Wilkson','Wilson, Stephen','Stephen Kilsman wilkson'

\| | | john | 0.5 | no data | | | John | <0.5 | 'John Pierre','Pierre john'

\| | | Stephen | <0.5 | 'Stephen Wilkson','Wilson, Stephen'

\| |

Conclusion:

Solution 1 and 4 combined is chosen to implement.&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

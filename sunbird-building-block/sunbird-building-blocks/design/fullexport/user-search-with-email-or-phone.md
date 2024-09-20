# User-Search-with-email-or-phone

Problem statementCurrently search uses filters which are joined with  AND ('&&') operator by default. Hence It is not possible to search with OR ('||') condition. Hence to search a user by either an email or phone number, It requires to make two different calls, one with phone and if result is empty then another call with email. This process is inefficient. Hence there should be a way that a user can be searched by email or phone. It requires to create a structure in filter where we need to provide if we want to call with and or or or both together.

Solution approachApproach 1 -Currently the filter request is mapped with elasticsearch request with 'must' call, which produces 'and' result. This should be modified to include 'must' or 'should' based on the filter structure provided. The filter should be able to use operators which can be mapped with 'and' or 'or' conditions.

Current filter

{

&#x20;   "request": {

&#x20;          "filters": {

&#x20;                 "email" : "abc@[example.com](http://example.com)",

&#x20;                 "phone" : "9988998899"

&#x20;           }

&#x20;     }

}

Above filter will fetch user whose email is [abc@example.com](mailto:abc@example.com) and phone is 9988998899.

The changes for using or condition would be

```
{
  "request": {
    "filters": {
	"$or": 
	     {
	        "email" : "abc@example.com",
            "phone" : "9988998899"   
              
	     },
       "firstName": "xyz"
    }
  }
}
```

basically a "$or" operator which takes an array of conditions to apply any of them.

This will have backward compatibility, since all the top level argument will be used as and condition as before

```
{
  "request": {
    "filters": {
		"$or": [
	     	{
	        	"email" : "abc@example.com"
	     	},
            {
                "phone" : "9988998899"
	     	}
		],
        "gender" : "male" 
    }
  }
}
```

Approach 2 -

In this approach we can have an altogether different parameter for 'or' conditions

The request will looks like as below

```
{
    "request": {
           "orFilters": {
                  "email" : "abc@example.com",
                  "phone" : "9988998899"
            }
      }
}
```

This approach does not requires any changes in existing filter logic and will have backward compatibility Whatever comes with filter will be used as 'must' (and) and data coming with orFilters will be considered in 'should' (or).

```
{
    "request": {
			"filters": {
                  "gender" : "male"
            },
           "orFilters": {
                  "email" : "abc@example.com",
                  "phone" : "9988998899"
            }
      }
}
```

Approach 1 is agreed to used.

***

\[\[category.storage-team]] \[\[category.confluence]]

To make fuzzy search in any of search APIs like org & location, use below request






```
curl --location --request POST 'http://localhost:9000/v1/org/search' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "request": {
        "fuzzy":{
          "param": "value"
        },
        "filters": {
        }
    }
}'
```


*****

[[category.storage-team]] 
[[category.confluence]] 

 **Overview** Sunbird APIs are consumed via mobile app as well as web application, where in even web-application can be loaded from mobile or tabs. Most of the api is based on exchange of request/response in json format. Motivation is to reduce the size of responses so that responses are delivered faster even on devices with slower connections.

 **Solution** Sunbird platform provides the api end-point over play2 framework server. It provides us the way to configure compression through notion of web-filters.



 **Functional:** 


1. We will enable the gzip compression in our play server configuration.
1. If user sends request header "Accept-Encoding": with one of the values as gzip, api will respond with compressed response, if it is configured to return compressed response.
1. We will be compressing all response of type application/json by default.



 **Technical Solution** 


1. We can provide a web-filter, for Gzip compression by configuring play.filters.gzip.GzipFilter.
1. During object constructor,we can further customize it to perform the encryption based on parameters available in request/response object.
1. We will only compress the data if response size is greater than configured threshold. Default will be provided, which can be over-ridden by user through updating the environment variable.
1. Variable name will be  **sunbird_gzip_encryption_threshold** 
1. We need to return GzipFilter object as one of the values in array returned from filters function, from the class that implements HttpFilters.

 **Note:** We would only apply compression, if Accept-Encoding header is passed and



 **Code (Enabling G-zip):** 


```
publicclassFiltersimplementsHttpFilters{@InjectGzipFilter gzipFilter;publicEssentialFilter\[] filters(){returnnewEssentialFilter\[]{ gzipFilter };}}



We can also pass a function - while constructing gzipFilter, to tweak when to compress the data based on request/response parameter.


```

```
(RequestHeader req, ResponseHeader resp) -> {
   return (resp.headers().get("Content-Length") > configuredLimit\*1000);
  }
```
 **Advantages:** 1. Response size will be considerably smaller and will use less band-width.



After design discussion no need to implementation. This will be handle from Nginx.







*****

[[category.storage-team]] 
[[category.confluence]] 

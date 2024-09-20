This approach involves below steps:


1. Enable [Azure CDN](https://learn.microsoft.com/en-us/azure/cdn/cdn-overview) on your blob or web endpoint.                                                                                                                                           For a Blob Storage endpoint,  [Integrate an Azure storage account with Azure CDN](https://learn.microsoft.com/en-us/azure/cdn/cdn-create-a-storage-account-with-cdn).    


1. [Map Azure CDN content to a custom domain](https://learn.microsoft.com/en-us/azure/cdn/cdn-map-content-to-custom-domain).


1. [Enable HTTPS on an Azure CDN custom domain](https://learn.microsoft.com/en-us/azure/cdn/cdn-custom-ssl).        






## 1. Enable Azure CDN on your blob or web endpoint.

* Create a new CDN profile, In the Azure portal, select  **Create a resource**  (on the upper left). The  **Create a resource**  portal appears.


* Search for and select  **Front Door and CDN profiles** , then select  **Create** :


* Select  **Explore other offerings**  then select  **Azure CDN Standard from Microsoft (classic)** . Select  **Continue** .


* In the  **Basics**  tab, enter the following values:



sunbscription, resourcegroup, resourcegroup region, Name, region, Pricing tier.


* Select  **Review + Create**  then  **Create**  to create the profile.




### Create a new CDN endpoint

* In the Azure portal,  select the CDN profile that you created, On the CDN profile page,                                select  **+ Endpoint** .


* The  **Add an endpoint**  page appears. Enter the following setting values:





| Setting | Value | 
|  --- |  --- | 
|  **Name**  | Enter name for your endpoint hostname. This name must be globally unique across Azure; if it's already in use, enter a different name. This name is used to access your cached resources at the domain  _<endpoint-name>_ .azureedge.net. | 
|  **Origin type**  | Select  **Storage** . | 
|  **Origin hostname**  | Select the host name of the Azure Storage account you're using. | 
|  **Origin path**  | Leave blank. | 
|  **Origin host header**  | Leave the default value (which is the Origin hostname). | 
|  **Protocol**  | Leave the default  **HTTP**  and  **HTTPS**  options selected. | 
|  **Origin port**  | Leave the default port values. | 
|  **Optimized for**  | Leave the default selection,  **General web delivery** . | 


* Select  **Add**  to create the new endpoint. After the endpoint is created, it appears in the list of endpoints for the profile. (The time it takes for the endpoint to propagate depends on the pricing tier selected when you created the profile.  **Standard Akamai**  usually completes within one minute,  **Standard Microsoft**  in 10 minutes, and  **Standard Verizon**  and  **Premium Verizon**  in up to 30 minutes.)




## 2.Map Azure CDN content to a custom domain.
 **Create a CNAME DNS record** , Before you can use a custom domain with an Azure CDN endpoint, you must first create a canonical name (CNAME) record with Azure DNS or your DNS provider to point to your CDN endpoint.

 **DNS Provider:** 

 **Map the temporary cdnverify subdomain** 


* Sign in to the web site of the DNS provider for your custom domain.


* Create a CNAME record entry for your custom domain and complete the fields as shown in the following table (field names may vary):





| Source | Type | Destination | 
|  --- |  --- |  --- | 
| cdnverify.www.contoso.com | CNAME | cdnverify.contoso.azureedge.net | 


*  **Source** : Enter your custom domain name, including the cdnverify subdomain, in the following format:  **cdnverify.<custom-domain-name>** 


* Type: Enter or select  **CNAME** .


* Destination: Enter your CDN endpoint hostname, including the cdnverify subdomain, in the following format:  **cdnverify.<endpoint-name>.azureedge.net** .


* Save your changes.



 **Map the permanent custom domain** 


* Sign in to the web site of the domain provider for your custom domain.


* Create a CNAME record entry for your custom domain and complete the fields as shown in the following table (field names may vary):





| Source | Type | Destination | 
|  --- |  --- |  --- | 
| www.contoso.com | CNAME | contoso.azureedge.net | 


* Source: Enter your custom domain name.


    * For example:  **www.contoso.com** 



    
* Type: Enter or select  **CNAME** .


* Destination: Enter your CDN endpoint hostname in the following format:  **<endpoint-name>.azureedge.net** .


    * For example:  **contoso.azureedge.net** 



    
* Save your changes.




## 3.Enable HTTPS on an Azure CDN custom domain.
To enable HTTPS on an Azure CDN custom domain, you use a TLS/SSL certificate. You choose to use a certificate that is managed by Azure CDN or use your certificate.

 **Enable HTTPS with a CDN managed certificate** 


* Go to azure portal and select your  **CDN profiles** .


* In the list of CDN endpoints, select the endpoint containing your custom domain.


* The  **Endpoint**  page appears.


* In the list of custom domains, select the custom domain for which you want to enable HTTPS.


* Under Certificate management type, select  **CDN managed** .


* Select  **On**  to enable HTTPS.


* Validate the domain.







*****

[[category.storage-team]] 
[[category.confluence]] 

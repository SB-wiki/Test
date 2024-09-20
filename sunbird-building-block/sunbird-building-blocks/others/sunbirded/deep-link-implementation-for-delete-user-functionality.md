

This documentation outlines the usage of deep linking to implement the 'Delete User' functionality within the sunbird mobile app. The functionality involves initiating the deletion process through a deep link dynamically passed to the portal. Upon successful deletion, a callback is received, and the deep link redirects back to the mobile app.


### Functionality Flow

1.  **User Interaction:**  Clicking the 'Delete Your Account' button on the profile page triggers the verifyUser() method.


1.  **Verification:**  The verifyUser() method checks if the user has necessary authorization (no roles assigned).


1.  **Launching Deep Link:**  If authorized, the launchDeleteUrl() method generates a deep link and opens it in a browser using custom tabs plugin.


1.  **Deletion Process:**  Upon successful deletion on the portal, a callback is received, triggering local data deletion and logging out the user.




## Code Implementation

### launchDeleteUrl() Method

* Generates a deep link with necessary parameters (includes the deeplink) and launches it in a browser.



Steps:
1.  **Generate Telemetry:** 


    * Records telemetry for delete button click.



    
1.  **Construct Deep Link URL:** 


    * Retrieves base URL and URL scheme. (using utility plugin)


    * Constructs the delete endpoint and modifies the deep link value.


    * Appends the deep link to the constructed URL.



    
1.  **Launch Custom Tab:** 


    * Opens the URL in a browser using custom tabs.


    * Listens for a callback URL upon successful deletion.



    
1.  **Handle Callback:** 


    * Parses the callback URL to extract parameters.


    * Checks for user ID match and deletion status.


    * Deletes local profile data if the user ID matches and deletion is successful.



    
1.  **Error Handling:** 


    * Handles errors during the deletion process.



    


### isUserDeleted() Method

* Checks if the user is deleted on the server. (This is done to create an extra check if delete user fails from the portal side)



Steps:
1.  **Server Profile Details Request:** 


    * Constructs a request to get server profile details for the given user ID.


    * Forces a refresh to ensure the latest data.



    
1.  **Check Profile Response:** 


    * Checks if the profile response is available.


    * Returns a boolean indicating user deletion status.



    
1.  **Error Handling:** 


    * Handles exceptions and returns true for error cases.



    


## Conclusion
This documentation provides an overview of how deep linking is used to implement the 'Delete User' functionality in the Sunbird mobile app. The process involves generating a deep link, initiating deletion through a browser, and handling the callback to perform local data deletion upon successful deletion on the server.



*****

[[category.storage-team]] 
[[category.confluence]] 

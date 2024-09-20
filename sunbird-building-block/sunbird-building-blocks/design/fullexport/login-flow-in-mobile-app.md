# Login-Flow-In-Mobile-App

### Overview:&#x20;

Currently sunbird supports Google, SelfSignUp and State state account for user registration. In case of state user, even though they already have a state account they need to register in sunbird.

### Problem statement:&#x20;

When launch the login page using CustomTab and then tap on home or minimize the the app. then again tap on app user landed on the same screen where user initiated the login . (ex. Course or library screen)

### Scenarios:

**Issue 1 : Sign In issue**

1. Open the app
2. On Library or Course screen, tap on “Sign In” link
3. Now minimize the app
4. Again open the app check user landed on “Library” or “Course” screen instead of “Sign In” screen

**Issue 2 : Sign Up issue**

1. Open the app
2. On Library or Course screen, tap on “Sign In” link
3. Tap on “Sign Up” link
4. Now minimize the app
5. Again open the app , check that user is on Library or Course screen instead of “Sign Up” screen

**Issue 3: Forgot password screen issue**

1. Open the app
2. On Library or Course screen, tap on “Sign In” link
3. Tap on “Forgot”
4. Enter email or phone number
5. Now minimize the app
6. Open the app again and check that user landed on Library or Course screen instead of “Forgot password” screen

**Issue 4 : OTP screen issue**

1. Open the app
2. On Library or Course screen, tap on “Sign In” link
3. Tap on “Forgot”
4. Enter email or phone number and submit
5. Now minimize the app
6. Open the app again and check that user landed on Library or Course screen instead of “Forgot password OTP” screen

### Current Implementation:

* Launch the keyclock login page using the custom tab
* Continue self signup and google login with custom tab
* When user clicks on state login then closing the custom tab and launch the inapp browser.

### Solution:

Solution 1:

* Launch the login page using the inapp browser.
* Continue self signup and state login with inapp browser
* When user clicks on Google login/signup then close the inapp browser and launch the google login with CustomTab by listening the callback URL on click.

Solution 2:

* List all the option (Signin, Login with Google, State Login, Manual Signup) in app.
* If user clicks on **Signin** then launch the Keyclock page with **inapp browser** .
* If user clicks on **State Login** then launch the state login page with **inapp browser** .
* If user clicks on **Signup** then launch the signup page with **inapp browser** .
* If user clicks on **Login with Google** then launch the Keyclock page with **custom tab** .

Solution 3:

* List all the option (Signin, Login with Google, State Login, Manual Signup) in app.
* If user clicks on **Signin** then launch the Keyclock page with **inapp browser** .
* If user clicks on **State Login** then launch the state login page with **inapp browser** .
* If user clicks on **Signup** then handle signup flow in app.
* If user clicks on **Login with Google** then handle in app using Google plugin.

### Pros and Cons:

| Solution | Pros                                                                                                                                                                                                                   | Cons                                                                                                                   |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| 1        | <ul><li>Minor changes in the keyclock page and in app.</li><li>If later we want to remove any option then there are no build deployment is required for app.</li><li>Common code base for Mobile and Portal.</li></ul> | <ul><li>Need to handle the callback to switch between inapp browser and custom tab based on selected option.</li></ul> |
| 2        | <ul><li>No need to handle the callback to switch between inapp browser and custom tab.</li></ul>                                                                                                                       |                                                                                                                        |
| 3        | <ul><li>By implementing the manual signup and google login in app will have more control on flow.</li></ul>                                                                                                            |                                                                                                                        |

### Conclusion:

Solution 1 is suggested by the design council.

&#x20;  &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]

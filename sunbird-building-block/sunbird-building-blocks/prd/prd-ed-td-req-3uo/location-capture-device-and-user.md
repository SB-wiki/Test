# Location-Capture----Device-and-User

Introduction

Jira Ticket:&#x20;

[https://project-sunbird.atlassian.net/browse/SC-1321](https://project-sunbird.atlassian.net/browse/SC-1321)

JTBD

* \*\*Jobs To Be Done: \*\* **Context/ Ask :** States require Diksha usage to be reported at a District level (as of now) so as to be able to drive action on the ground to improve usage.&#x20;
* **User Personas:** All usage (state as well as other consumption)

Requirement SpecificationsThis section consists of requirement specifications for specific use cases in the User JTBD. The requirements for each use case are elaborated in detail through sub-sections for:

* **Use case overview**

The solution proposal is based on the following broad premises:

> > Any device that installs/ uses Diksha will be mapped to a location (Device Profile) - the user will be prompted to edit/ confirm a location based on a suggestion that uses IP based location&#x20;

> > Users who sign up will be required to declare a location for their user profile - the location from the device profile can be used as a suggestion for the user to edit/ confirm.

**Usage attribution (for telemetry):**

If there is no user logged in:

> > All such usage will be attributed to the device location

If there is a user logged in:

> > If the User Profile has a location available, usage will be attributed to this location

> > If the user profile does not have a location, the user will be prompted to confirm their location - the system will suggest a location for the user to confirm, based on the device location. Once the user  confirms, this is stored against the user profile.

* **Overall process workflow**

**App/ Portal Actions:**

1. When a device starts to use Diksha, check to see if the device is registered (has an entry in the device profile)
2. If device not entered in Device Profile, create an entry in Device Profile (post location capture as confirmed by user - this will use GPS/ IP mapping to provide suggestions)
3. If no user is logged in, set Derived Location = Device Location
4. When a user logs in, check to see if the User Profile has a location
5. Set Derived Location = User Profile location

* Stamp telemetry from device with Derived Location - stamping of telemetry with the location will happen in the pipeline

**APP BEHAVIOUR**

_When a device installs the app :: Determining Location for Device Profile_

1. The device register API is called as soon as installation happens (if the device is online), and the IP based location of the device is captured  \_\[ \_ \_  \_ _- in case the device is offline, is it cached locally and sent to the server when a connection is available? ]_
2. TBD : As part of permissions, the user is asked to grant access to GPS - and if this is obtained, the GPS based location of the user is also obtained (but not saved)
3. As part of on boarding, the user has to mandatorily \[MAKE CONFIGURABLE] confirm their location - in order to make this easier, the user is prompted to confirm the location derived by IP (or GPS, if available)
4. The user can choose to confirm the suggested location (the suggested location will be provided if the IP based location suggestion is available. If not, there is no suggested location), or choose a State/ District from the values in the autocomplete dropdown \[a user can start typing to see suggestions or can use the drop down to see the list of possible values to select]
5. The location thus confirmed by the user is stored as the User Confirmed location against the device in the Device Profile DB

_When a user Signs up (self sign up) :: Determining Location for User Profile_

| Sign up by filling form | Sign Up with Google |
| ----------------------- | ------------------- |
|                         |                     |

1. Fill out the sign up form (Name, Phone/ Email, Password)
2. Get OTP, and submit it to complete account creation
3. Re-login

\| Login with Google | |

1. Go through On Boarding - Board, Medium, Class
2. Has to confirm location suggestion (as derived from Device profile), or choose a location from the autocomplete dropdown values

|

This causes the self signed up user Profile to be created with the location details as confirmed by the user.

**Note:**   In case of user accounts set up by the state (SSO, Shadow DB) where the state provides the school (sub-org) association of the user, this location detail will be used to populate the user profile. The user is not required to declare their location in such cases. Likewise, when a migration/ merge to the state tenant happens, the location values in the state tenant will be retained.

**PORTAL BEHAVIOUR** Pre-requisites: Portal Device duplication has to be resolved if this has to function in a predictable fashion (expected to be resolved as part of release 2.4)

The portal workflow can be initiated via

1. Portal browse
2. QR scan (using Dikhsa or a non-Diksha app)

Portal usage can happen on desktops as well as mobile devices (mobile web)

The rest of the flows (location determination, location storage against device, location storage against logged in user) remain the same as the app.

\[TBD : Offline desktop app  ]

**TELEMETRY STAMPING**

_Stamping of telemetry :: Telemetry attribution to a location - in the pipeline_

1. If usage is by a non-logged in user, derived location = device location
2. If usage is by a logged in user and user profile has location, derived location = user location
3. If usage is by a logged in user and user profile does not have location, the user is prompted to confirm their location using the device location as a suggestion. Once the user manually confirms their location, this is stored in the user profile.&#x20;

Stamping of usage telemetry is carried out using the derived location.

**Other points to note:**

* The default list of locations (State/ District) will be packaged with the app , and will periodically refreshed from the server - like the current Framework list that the app loads. The Platform will have to be the single source of District data for Diksha
* The list of Districts will have to be validated individually with states (What happens if I can’t find my District in the list?)
* Defaults for State/ District list will be loaded onto Diksha (Udise defaults) - these will be used to populate the State/ District dropdowns that the user will choose from.&#x20;

_**Link to workflows (**_ Detailed visualisation of the following workflows - w.r.t. deriving location)

> > App install and usage

> > New user sign up

> > Telemetry stamping

> > Portal based usage

* **Localization requirements**
* **Telemetry requirements**

How many users are seeing a location suggestion based on IP resolution?

How many users are accepting the suggestion without making any changes?

How many users are making changes to the suggestion and then saving the location?

How many have edited their location (State/ District) after providing it?

* **UX Designs:**

PORTAL :: [https://projects.invisionapp.com/d/main#/projects/prototypes/18613846](https://www.google.com/url?q=https://projects.invisionapp.com/d/main%23/projects/prototypes/18613846\&sa=D\&source=hangouts\&ust=1570270758687000\&usg=AFQjCNEBLSLBp2cxd18o-gQyWa29KWKMGg)

APP :: [![](../../../../PRD/prd-ed-td-req-3uo/images/storage)Location Permission](https://invis.io/U2TXHEOVHAE)

* Dependencies
* Impact on other products
* Impact on existing data &#x20;

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]

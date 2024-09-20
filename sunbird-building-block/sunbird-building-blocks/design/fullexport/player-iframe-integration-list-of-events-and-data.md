
### Introduction:
Player integration in sunbird-portal data exchange and telemetry log using window.postMessage() and window.addEventListener()


### Problem statement:
As per the web standards, the communication between iframe and window should be done via post messages.

Therefore


1. The player should emit all events using the iframe window.postMessage() API - targetWindow.postMessage(message, targetOrigin, \[transfer]);


1. The app/client integrating the player should listen for the player events using window.addEventListener("message", ...);


1. The message data should be namespaced properly to identify the event source and data.


1. Telemetry should be redirected via the container





For Dispatching event: targetWindow.postMessage(message, targetOrigin, \[transfer]);

For Listening event: window.addEventListener("message", (event) => { }, false);



Dispatch events list from portal to player:

|  **Event name/Signature**  |  **Description**  |  **Data(Sender)**  | 
|  --- |  --- |  --- | 
| renderer:preview:initialize | Initialize player and player its self start initializePreview() | Player Config | 



Listener events list from player to portal:

|  **Event name/Signature**  |  **Description**  |  **Data(Receiver)**  | 
|  --- |  --- |  --- | 
| renderer:question:submitscore |  For Logging assessment ASSESS Events | Assess event object for Score | 
| renderer:telemetry:event | Where we can log START, END, IMPRESSION, and all telemetry events | Telemetry object | 



Going forward Player and Portal should use the same event signature for data exchange between Portal and Player



*****

[[category.storage-team]] 
[[category.confluence]] 

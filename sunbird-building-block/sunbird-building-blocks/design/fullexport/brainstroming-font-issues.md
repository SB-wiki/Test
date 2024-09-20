# Brainstorming on expected UX and performance issues after more languages comes on board.

As more languages will get added to the portal, few anticipated challenges will need to be figured out before they surface -

Challenges expected -&#x20;

1. More languages will need more font files and hence more HTTP request which is going to impact the rendering time.
2. Font look up time - current implementation, applying fonts on body level all together, If a font for a language comes in last of the array then look up time will increase and hence the text may not render properly for few milli-seconds. which is expected to degrade UX.&#x20;
3. In some languages few characters may have common uni-code and may conflict.
4. APP - Size of app will increase significantly

Rough solutions -

1. upgrade to http2
2. merge  fonts
3. apply font in batches based on user
4. use a font which solves the problem

***

\[\[category.storage-team]] \[\[category.confluence]]

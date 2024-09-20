# Add-plugins-outward-relation-with-plugins,-which-has-used-in-the-content

**Ref: System JIRA2207a759-5bc8-39c5-9cd2-aa9ccc1f65ddSB-13629**

**Problem statement** :&#x20;

Presently to identify the plugins which are used in the content, we have to parse the complete body object & identify the id of the plugin exist in the plugin-manifest of the content. To do this, we have to run some java/node script on the server to find list of contents which are using the specific plugin.

It is very difficult parse below ECML to get plugin details and moreover it will not show some plugins which are not required while rendering..

\<!\[CDATA\[{"opacity":100,"strokeWidth":1,"stroke":"rgba(255, 255, 255, 0)","autoplay":false,"visible":true,"color":"#FFFFFF","genieControls":false,"instructions":""}]] >

\<org.ekstep.text x="10" y="20" minWidth="20" w="35" maxWidth="500" fill="#000000" fontStyle="normal" fontWeight="normal" stroke="rgba(255, 255, 255, 0)" strokeWidth="1" opacity="1" editable="" version="V2" offsetY="0.2" h="5.02" rotate="0" textType="text" lineHeight="1" z-index="0" font="'Noto Sans', 'Noto Sans Bengali', 'Noto Sans Malayalam', 'Noto Sans Gurmukhi', 'Noto Sans Devanagari', 'Noto Sans Gujarati', 'Noto Sans Telugu', 'Noto Sans Tamil', 'Noto Sans Kannada', 'Noto Sans Oriya', 'Noto Nastaliq Urdu', -apple-system, BlinkMacSystemFont, Roboto, Oxygen-Sans, Ubuntu, Cantarell, 'Helvetica Neue'" fontsize="48" weight="" id="b09e8e1c-b30a-4ca4-9ce0-7c0d856bc774">

\<!\[CDATA\[{"opacity":100,"strokeWidth":1,"stroke":"rgba(255, 255, 255, 0)","autoplay":false,"visible":true,"text":"Find area of below shape ?","color":"#000000","fontfamily":"'Noto Sans', 'Noto Sans Bengali', 'Noto Sans Malayalam', 'Noto Sans Gurmukhi', 'Noto Sans Devanagari', 'Noto Sans Gujarati', 'Noto Sans Telugu', 'Noto Sans Tamil', 'Noto Sans Kannada', 'Noto Sans Oriya', 'Noto Nastaliq Urdu', -apple-system, BlinkMacSystemFont, Roboto, Oxygen-Sans, Ubuntu, Cantarell, 'Helvetica Neue'","fontsize":18,"fontweight":false,"fontstyle":false,"align":"left"}]] >

\</org.ekstep.text>

\<!\[CDATA\[{"opacity":100,"strokeWidth":1,"stroke":"rgba(255, 255, 255, 0)","autoplay":false,"visible":true,"color":"#FF0000","sides":5,"points":\[{"x":50,"y":0},{"x":100,"y":34.5},{"x":79.4,"y":100},{"x":20.6,"y":100},{"x":0,"y":34.5}]}]] >

\<!\[CDATA\[{"opacity":100,"strokeWidth":1,"stroke":"rgba(255, 255, 255, 0)","autoplay":false,"visible":true,"color":"#FFFFFF","genieControls":false,"instructions":""}]] >

&#x20;

**Solution** :&#x20;

Add outward relations with content to the plugins used in the content. This helps to quickly identify the contents which are using the specific plugin.

* plugins field is inserted in the metadata of old published resources using node script.
* This is been handled in the request header, while creation/updation.
* Both Scenarios i.e Content editor and CBSE program have been covered.

**Format of plugins field in metadata of resource as follows** :

plugins: \[{ identifier: ' ' , semanticVersion: ' '  }]

For the above ECML content we have included new key 'plugins' in metadata of content as below:

```
"plugins":"\[{ "identifier ": "org.ekstep.stage ", "semanticVersion ": "1.0 "},

{ "identifier ": "org.ekstep.text ", "semanticVersion ": "1.2 "},

{ "identifier ": "org.ekstep.shape ", "semanticVersion ": "1.0 "},

"identifier ": "org.ekstep.navigation ", "semanticVersion ": "1.0 "}]"
```

***

\[\[category.storage-team]] \[\[category.confluence]]

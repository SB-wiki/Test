# Certificate-Creation-as-Self-Service-Utility

### Problem

As a system, Collections such as courses are associated with providing certificates in the way to acknowledge the user about his learning outcome. Since the certificates can be created by different entities like state-boards, universities etc.

Certificate template creation becomes a key. Addition of Dynamic content in these templates will be become evolving need.

### Present System

In the present system, these certificate templates are managed by Implementation team and UI team where they cater to the needs of different stakeholders by creating these templates on day to day basis. Any subsequent changes requested would mean the templates has to be modified manually and again loaded onto the system to configure as certificates. Any Addition of attributes in the certificate would mean more programmatic effort to get it right on the API as well.

### Proposed System

In the proposed system, intent is to make creation of certificate to be a self serviced utility. Allow the users to load the a base template in the form of png, jpg. Allow inline editing of the images/templates in the system so that it can be managed well.

Allow users to upload, manage and modify any number of additional templates.

### Solution 1

Solution intends to accept png/jpeg file as preconfigured template. Allow users to make dynamic edits on the canvas

InputAs a part of proposed following formats can be inputs :

* PNG (Need to have some limits on memory size)
* JPEG

Diagram (Dynamic Canvas Editing from PNG)![](../../../../Consumption/Fullexport/images/storage/PNG\_to\_SVG.png)

Tools to be used : FabricFabric provides interactive object model on top of canvas element, also has SVG-to-canvas (and canvas-to-SVG) parser.

ngx-tui-image-editorPlugin Available in Open Source to allow editing of Canvas.

Steps for plugin integration:

```
<tui-image-editor (addText)="addTextToCanvas" (textEditing)="editText(opts)" objectAdded="objectAdded" objectMoved="objectMoved(opts)"></tui-image-editor>
```

Additional Plugin Fabric Overrides to be created

```
    //Editor Component
    this.editorComponent;
    
    //Overrides of the fabric in order to export images to Base64
     fabric.Image.prototype.getSvgSrc = function() {
      return this.toDataURLforSVG();
    };
    
    fabric.Image.prototype.toDataURLforSVG = function(options) {
      var el = fabric.util.createCanvasElement();
            el.width  = this._element.naturalWidth || this._element.width;
            el.height = this._element.naturalHeight || this._element.height;
      el.getContext("2d").drawImage(this._element, 0, 0);
      var data = el.toDataURL(options);
      return data;
    };
```

**Risks and Limitations**

* There needs to be explicit limit in terms of image sizes in order to control svg output size.
* Some Hand holding is required for the user to create/modify his own templates.

#### Solution 2:

It is also possible to the group all the templates as svg inputs into the system. This can be controlled with preconfigured templates with preconfigured set of data attributes to be added dynamically into the system.

Each Template Layout will have a necessary information associated with it.

```
{
"templateID" : "<template-id>",
"svgContent" : "<svg></svg>",
"templateAttributes":[{
    "type": "text",
    "id": "title"
    "content": "htmlString",
    "fontSize": "14",
    "color" : "#FCFCFC"
},{
    "type": "image",
    "id" : "logo"
    "content": "htmlString"
},{
    "type": "image",
    "id" : "logo1"
    "content": "htmlString"
},{
    "type": "image",
    "id" : "logo2"
    "content": "htmlString",
    "fontSize": "14",
    "color" : "#FCFCFC"
},{
    "type": "image",
    "id" : "logo3"
    "content": "htmlString",
    "fontSize": "14",
    "color" : "#FCFCFC"
},{
    "type": "text",
    "id": "subtitle"
    "content": "htmlString",
    "fontSize": "14",
    "color" : "#FCFCFC"
},{
    "type": "text",
    "id": "description"
    "content": "htmlString",
    "fontSize": "14",
    "color" : "#FCFCFC"
},{
    "type": "image",
    "id": "signImage1"
    "src": "htmlString"
},{
    "type": "image",
    "id": "signImage2"
    "content": "htmlString"
},{
    "type": "image",
    "id": "signImage3"
    "content": "htmlString"
}]
}
```

![](../../../../Consumption/Fullexport/images/storage/image-20210601-114027.png)Auto Generate the forms based on template chosen

Mapping Logic:

a) Fetch the list of text and image elements and dynamically generate the form.

![](../../../../Consumption/Fullexport/images/storage/image-20210601-120128.png)

b) Dynamically generate the form on the portal based on text and image elements in the svg.

Every Text Element recognised can have additional option of increasing / decreasing the font size, Changing Color

Every Image element can have option of getting replaced.

***

\[\[category.storage-team]] \[\[category.confluence]]

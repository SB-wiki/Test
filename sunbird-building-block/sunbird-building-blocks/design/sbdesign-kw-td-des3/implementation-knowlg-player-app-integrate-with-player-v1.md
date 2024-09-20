
# Background
Currently, we are showing pdf, epub, and video players in the knowledge player app. To display the interactive, HTML, h5p, and youtube content, we need to integrate the v1 player in the knowledge player app.


# Design
To integrate the v1 player for the knowledge app we need some changes in the following component

services/data.tsOld code:


```
playersArray: [{
        name: 'pdf',
        mimeType: 'pdf'}]] ]></ac:plain-text-body></ac:structured-macro><p>Changes: </p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="37939870-657c-4b6a-b880-deb05504d47a"><ac:plain-text-body><![CDATA[playersArray: [{
        name: 'pdf', // Name to display
        mimeType: 'application/pdf', // Actul mimeType for search api call
        playerType: 'pdf', // to get the player info
        playerRedirectURL: "players/pdf" // for routing 
      },
      {
        name: 'epub',
        mimeType: 'application/epub',
        playerType: 'epub',
        playerRedirectURL: "player/pdf"
      },
      {
        name: 'video',
        mimeType: '["video/mp4"]',
        playerType: 'video',
        playerRedirectURL: "player/pdf"
      },
      {
        name: 'ecml',
        mimeType: 'application/vnd.ekstep.ecml-archive',
        playerType: 'ecml',
        playerRedirectURL: "player/ecml"
      },
      {
        name: 'html',
        mimeType: 'application/vnd.ekstep.html-archive',
        playerType: 'html',
        playerRedirectURL: "player/html"
      }
```
services/content.service.ts
```
getMimeType(playerType){
      return data.playersArray['playerType'].mimeType;
}
playerRedirectURL(playerType: string){
      return data.playersArray['playerType'].playerRedirectURL;
  }
```

## Redirect to the V1 and v2 player

### Solution 1:
Create the New component for the v1 player 

player-routing.module.ts (existing routing module change)


```
{
    path: 'player/interactive/:mimeType/:id', component: playerv1Component,
}
```
v1-player.component.html


```
<iframe #preview id="contentPlayer" src="/content/preview/preview.html?webview=true"></iframe>
```
v1-player.component.ts


```
 @ViewChild('preview', { static: false }) previewElement: ElementRef;
....
ngAfterViewInit() {
    this.previewElement.nativeElement.onload = () => {
        this.previewElement.nativeElement.contentWindow.initializePreview(this.playerConfig);
        this.previewElement.nativeElement.contentWindow.addEventListener('message', resp => {
         ....
         };
    };
  }
  
  ....

ngOnInit(): void {
    // get queryParams.identifier
    // set the content metadata
  }

```
Pros:
* Easy to maintain - easy to differentiate the config between the v1 and v2 player


* Easy to redirect and get the action on different types of events



Cons:
* Need to maintain a separate component for the v1 player




### Solution 2:
Add one more player in the lib-player 

player-routing.module.ts (existing routing module change)


```
{
    path: 'player/:mimeType/:id', component: playerv1Component,
}
```

## lib-player component

* player.component.html




```
<div *ngSwitchCase="'application/vnd.ekstep.ecml-archive'" class="player">
        ...
        <iframe #preview id="contentPlayer" src="/content/preview/preview.html?webview=true"></iframe>
    </div>
```

* player.component.ts




```
  ngAfterViewInit() {
    this.previewElement.nativeElement.onload = () => {
        this.previewElement.nativeElement.contentWindow.initializePreview(this.playerConfig);
        this.previewElement.nativeElement.contentWindow.addEventListener('message', resp => {
         ....
         };
    };
  }
```
Pros:
* No need to create the separate component



Cons:
* Difficult to maintain - if we need to switch the different versions of the player for the same mimeType




# Conclusion

* Combine the two solutions to create a separate component (v1-player) in the shared module.





*****

[[category.storage-team]] 
[[category.confluence]] 


# Background 
Currently, When we click on the player list item - it redirects to the default content without showing the list of live contents of a specific player.


# Design

## playerList component

* navigateToPdf() -  redirect to playerContentList component - this.router.navigate(\['players/player-content-list/:mimeType']); mimeType = pdf


* navigateToEpub() - redirect to playerContentList component - this.router.navigate(\['players/player-content-list/:mimeType']); mimeType = epub


* navigateToVideo() - redirect to playerContentList component - this.router.navigate(\['players/player-content-list/:mimeType']); mimeType = video


* navigateToEcml() - redirect to playerContentList component - this.router.navigate(\['players/player-content-list/:mimeType']); mimeType = ecml


* naviagteToCollectionPlayer()- redirect to playerContentList component - this.router.navigate(\['players/player-content-list/:mimeType']); mimeType = collection




## playerContentList component  (New component)

* Add and import lib-contentList




```
<lib-contentlist [contentList]="contentList" (contentSelect)= "navigateToPlayer($event)"> </lib-contentlist>
```

* ngOnInit - get the query param player and set the player for redirect


* contentSearch() - to search the live contents of the player and set contnetList




```
contentSearch() {
    // set  contnetList array;
}
```

* navigateToPlayer()- To navigate to the player by passing the content id




```
navigateToPlayer() {
  // get the playerRedirectURL from config
  // redirect to the playerRedirectURL
}
```

* goBack() - To return to the player's list




```
goBack() {
    // redirect to the players list
  }
```

* Integrate the pagination component in lib-contentList




```
import {PageEvent} from '@angular/material/paginator';
...
// MatPaginator
  pagelength = [];
  pageSize = 5;
  pageIndex = 0;
  pageSizeOptions: number[] = [5, 10, 25, 100];
  pageEvent: PageEvent;
  ....
  
```

* handlePageEvent()- To handle the pagination events




```
handlePageEvent(event: PageEvent) {
   // search the content based on the paginations events
  }
```

* Generate telemetry on events 




## Collection-player component

* goBack() - To return to the player's list




```
goBack() {
    // redirect to the content list
  }
```

## Players header component

* goBack() - To return to the player's list




```
goBack() {
    // redirect to the content list
  }
```

## Lib-contentList component

* Adjust the card as per the screen sizes





*****

[[category.storage-team]] 
[[category.confluence]] 

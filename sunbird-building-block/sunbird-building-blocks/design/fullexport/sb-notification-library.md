 **Background** 

The notification feature is being used by both mobile and the portal. The same boilerplate code is there in both, so to reduce the boilerplate code “sb-notification“ library is created.

 **Implementation** 


```typescript
export interface SbNotificationService {
   getNotifications(): Promise<NotificationFeedEntry<Notification>;
  
   handleNotification(notificationData: EventNotification): void;
  
   deleteNotification(notificationData: EventNotification): Promise<boolean>;
  
   clearAllNotifications(notificationListData: EventNotificationList): Promise<boolean>;
}
```

* The library requires  NotificationService implementation to handle all the notification functionality. 


* It's the client’s responsibility to provide all the data required by the “sb-notiifcation” library to perform an action on the notifications.



 **Methods** 


* getNotifications: Required to render the notification list


* handleNotification: Required to handle the notification


* deleteNotification: Required to delete a notification


* clearAllNotifications: Required to clear all the notifications



 **Usage** 

Create a class that implements NotificationService from the notification library.


```
@Injectable({
  providedIn: 'root'
})
export class NotificationServiceImpl implements NotificationService {

  getNotifications(): Promise<NotificationFeedEntry<Notification>[]> {
   // Business logic to get the notification
  }

  handleNotification(notificationData: any) {
  // Business logic to handle notifications
  }

  deleteNotification(notificationData): Promise<boolean> {
  // Business logic to delete a notification
  }

  clearAllNotifications(notificationListData: any): Promise<boolean> {
  // Business logic to clear all notifications
  }
}
```
In the app module import the NotificationModule and declare   NotificationServiceImpl as a provider like following


```typescript
@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
   ...
    NotificationModule
   ...
  ],
  entryComponents: [AppComponent],
  bootstrap: [AppComponent],
  providers: [
    ...
    { provide: 'NOTIFICATION_SERVICE', useClass: NotificationServiceImpl }
    ...
  ]
})
```


*****

[[category.storage-team]] 
[[category.confluence]] 


# Awesome Notifications - Flutter

![](https://raw.githubusercontent.com/rafaelsetragni/awesome_notifications/master/example/assets/readme/awesome-notifications.jpg)



### Features

- Create **Local Notifications** on Android, iOS and Web using Flutter.
- Create **Push notifications** using services as **Firebase** or any another one, **simultaneously**;
- Easy to use and highly customizable.
- Add **images**, **sounds**, **buttons** and different layouts on your notifications.
- Notifications could be created at **any moment** (on Foreground, Background or even when the application is terminated/killed).
- **High trustworthy** on receive notifications in any Application lifecycle.
- High quality **data analytics** about when the notification was created, where it came from and when the user taps on it. Ideal for applying **AB tests** approaches, etc, increasing the users engagement.
- Notifications are received on **Flutter level code** when they are created, displayed, dismissed or even tapped by the user.
- Notifications could be **scheduled** repeatedly using a list or precise dates or even **Cron rules**, such linux does, with seconds precision.
<br>

*Some **android** notification examples:*
![](https://raw.githubusercontent.com/rafaelsetragni/awesome_notifications/master/example/assets/readme/awesome-notifications-android-examples.jpg)
<br>

*Some **iOS** notification examples **(work in progress)**:*
![](https://raw.githubusercontent.com/rafaelsetragni/awesome_notifications/master/example/assets/readme/awesome-notifications-ios-examples.jpg)
<br>

### Notification Types Available

- Basic notification
- Big picture notification
- Media notification
- Big Text notification
- Inbox notification
- Notifications with action buttons
- Grouped notifications
- Progress bar notifications

All notifications could be created locally or via Firebase services, with all the features.

<br>

## ATENTION - PLUGIN UNDER CONSTRUCTION

![](https://raw.githubusercontent.com/rafaelsetragni/awesome_notifications/master/example/assets/readme/awesome-notifications-atention.jpg)
![](https://raw.githubusercontent.com/rafaelsetragni/awesome_notifications/master/example/assets/readme/awesome-notifications-progress.jpg)

*Working progress percentages of awesome notifications plugin*
<br>

### Next steps

- Include Firebase support for iOS (In construction)
- Finish notifications features for iOS (In construction)
- Expiration date for notifications (not done yet due to iOS limitations) (https://github.com/rafaelsetragni/awesome_notifications/issues/7)
- Fix channel's updates on Android (https://github.com/rafaelsetragni/awesome_notifications/issues/3)
- Include Web support
- Include support for another push notification services (Wonderpush, One Signal, IBM, AWS, Azure, etc)
- Video layout for notifications
- Carousel layout for notifications
- Increase the tolerance in the json deserialization process, to accept different types and convert them to the expected.
<br>

## Main Philosophy

Considering all the many different devices available, with different hardware and software resources, this plugin ALWAYS shows the notification, trying to use the maximum resources available. If the resource is not available, the notification ignores that specific resource, but shows the rest of notification anyway.

**Example**: If the device has LED colored lights, use it. Otherwise, ignore the lights, but shows the notification with all another resources available. In last case, shows at least the most basic notification.

Also, the Notification Channels follows the same rule. If there is no channel segregation of notifications, use the channel configuration as only defaults configuration. If the device has channels, use it as expected to be.

And all notifications sent while the app was killed are registered and delivered as soon as possible to the Application, after the plugin initialziation, respecting the delivery order.

This way, your Application will receive **all notifications at Flutter level code**.

<br>

## How to show Local Notifications

<br>

1. Add *awesome_notifications* as a dependency in your pubspec.yaml file.

```yaml
  awesome_notifications: any
```

2. import the plugin package to your dart code

```dart
import 'package:awesome_notifications/awesome_notifications.dart';
```

3. Initialize the plugin on main.dart, with at least one native icon and one channel

```dart
AwesomeNotifications().initialize(
    'resource://drawable/app_icon',
    [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white
        )
    ]
);
```

4. On your main page, starts to listen the notification actions (to detect tap)

```dart
AwesomeNotifications().actionStream.listen(
    (receivedNotification){
    
        Navigator.of(context).pushName(context,
            '/NotificationPage',
            arguments: { id: receivedNotification.id } // your page params. I recomend to you to pass all *receivedNotification* object
        );
    
    }
);
```

5. In any place of your app, create a new notification

```dart
AwesomeNotifications().createNotification(
  content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: 'Simple Notification',
      body: 'Simple body'
  )
);
```

**THATS IT! CONGRATZ MY FRIEND!!!**

<br>

## Using Firebase Services (Optional)

To activate the Firebase Cloud Messaging service, please follow these steps:

### *Android*

First things first, to create your Firebase Cloud Message and send notifications even when your app is terminated (killed), go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.

After that, go to "Cloud Messaging" option and add an "Android app", put the packge name of your project (**certifies to put the correct one**) to generate the file ***google-services.json***.

Download the file and place it inside your android/app folder.

![](https://raw.githubusercontent.com/rafaelsetragni/awesome_notifications/master/example/assets/readme/google-json-path.jpg)

Add the classpath to the [project]/android/build.gradle file. (Firebase ones was already added by the plugin)

```editorconfig
dependencies {
    classpath 'com.android.tools.build:gradle:3.5.0'
    // Add the google services classpath
    classpath 'com.google.gms:google-services:4.3.3'
}
```

Add the apply plugin to the [project]/android/app/build.gradle file.

```editorconfig
// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

### *iOS*

In construction... 

I will deploy the other platforms as soon as possible. Im doing all by my own, with a lack of resources.
Please, be patient.

<br>

## Firebase Token

The firebase token is necessary to your sever send Push Notifications to the remote device. The token could eventually change and is created to every device installation on each application.

Every token created could be captured on Flutter by this plugin listen to ``

<br>

## Error: Invalid Firebase notification content

The notification sent via FCM services *MUST* respect the types of the respective Notification elements. Otherwise, your notification will be discarded as invalid one.
Also, all the payload elements *MUST* be a String, as the same way as you do in Local Notifications.

<br>

## Notification Life Cycle

Notifications are received by local code or Push service using native code, so the messages will appears immediately or at schedule time, independent of your application state.

![](https://raw.githubusercontent.com/rafaelsetragni/awesome_notifications/master/example/assets/readme/notification-life-cycle.png)

<br>

## Flutter Streams

The Flutter code will be called as soon as possible using [Dart Streams](https://dart.dev/tutorials/language/streams).

**createdStream**: Fires when a notification is created
**displayedStream**: Fires when a notification is displayed on system status bar
**actionStream**: Fires when a notification is tapped by the user
**dismissedStream**: Fires when a notification is dismissed by the user

<br>

|                             | App in Foreground | App in Background | App Terminated (Killed) |
| --------------------------: | ----------------- | ----------------- | -------------- |
| **Android** | Fires all streams immediately after occurs | Fires all streams immediately after occurs | Fires `createdStream`, `displayedStream` and `dismissedStream` after the plugin initializes, but fires `actionStream` immediately after occurs |
| **iOS**     | Fires all streams immediately after occurs | Fires all streams immediately after occurs | Fires `createdStream`, `displayedStream` and `dismissedStream` after the plugin initializes, but fires `actionStream` immediately after occurs |

<br>

## Notification Structures

### Notification Layout Types

To show any images on notification, at any place, you need to include the respective source prefix before the path.

Images can be defined using 4 prefix types:

- Default: The default layout. Also is the layout used in case of any failure found on other ones
- BigPicture: Is the layout that shows a big picture and/or a small image.
- BigText: Is the layout that shows more than 2 lines of text.
- Inbox: Is the layout who lists messages or items separated by lines
- ProgressBar: Is the layout that shows a progress bar, such as download progress bar
- Messaging: (in construction)
- MediaPlayer: Is the layout that shows a media controller with action buttons, that allows the user to send commands without brings the application to foreground.

<br>

### Media Source Types

To show any images on notification, at any place, you need to include the respective source prefix before the path.

Images can be defined using 4 prefix types:

- Asset: images access through Flutter asset method. **Example**: asset://path/to/image-asset.png
- Network: images access through internet connection. **Example**: http(s)://url.com/to/image-asset.png
- File: images access through files stored on device. **Example**: file://path/to/image-asset.png
- Resource: images access through drawable native resources. On Android, those files are stored inside [project]/android/app/src/main/res folder. **Example**: resource://url.com/to/image-asset.png

OBS: Unfortunately, icons can be only resource media types.

<br>

### Notification Action Button Types


Notifications action buttons could be classified in 4 types:

- Default: after user taps, the notification bar is closed and an action event is fired.
- InputField: after user taps, a input text field is displayed to capture input by the user.
- DisabledAction: after user taps, the notification bar is closed, but the respective action event is not fired.
- KeepOnTop: after user taps, the notification bar is not closed, but an action event is fired.

<br>


### Scheduling a notification


Notifications could be scheduled as you wish using two main options:

- initialDate: (YYYY-MM-DD hh:mm:ss) The initial date that schedule should be called by first time. This option has the highest priority  among other options.
- crontabSchedule: Crontab expression as repetition rule (with seconds precision), as described in [this article](https://www.baeldung.com/cron-expressions)
- allowWhileIdle: Determines if notification will send, even when the device is in critical situation, such as low battery.
- preciseSchedule: List of precise dates to schedule a notification multiple times. This option has the lowest priority  among other options.

OBS: All dates are set to use UTC timezone.

<br>


## How to send Push Notifications using Firebase Cloud Messaging (FCM)

To send a notification using Awesome Notifications and FCM Services, you need to send a POST request to the address https://fcm.googleapis.com/fcm/send.
Due to limitations on Notification body, you should use only the data field as bellow:

OBS: `actionButtons` and `schedule` are **optional**

```json
{
    "to" : "[YOUR APP TOKEN]",
    "collapse_key" : "type_a",
    "data" : {
        "content": {
            "id": 100,
            "channelKey": "big_picture",
            "title": "Huston!\nThe eagle has landed!",
            "body": "A small step for a man, but a giant leap to Flutter's community!",
            "notificationLayout": "BigPicture",
            "largeIcon": "https://avidabloga.files.wordpress.com/2012/08/emmemc3b3riadeneilarmstrong3.jpg",
            "bigPicture": "https://www.dw.com/image/49519617_303.jpg",
            "showWhen": true,
            "autoCancel": true,
            "privacy": "Private"
        },
        "actionButtons": [
            {
                "key": "REPLY",
                "label": "Reply",
                "autoCancel": true,
                "buttonType":  "InputField",
            },
            {
                "key": "ARCHIVE",
                "label": "Archive",
                "autoCancel": true
            }
        ],
        "schedule": {
            "initialDateTime": "2020-08-30 11:00:00",
            "crontabSchedule": "5 38 20 ? * MON-FRI *",
            "allowWhileIdle": true,
            "preciseSchedules": []
        }
    }
}
```

You can download a example of how to send Push Notifications through FCM using "Postman" [here](https://raw.githubusercontent.com/rafaelsetragni/awesome_notifications/master/example/assets/readme/Firebase_FCM_Example.postman_collection.json)



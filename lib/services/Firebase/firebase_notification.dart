import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {


  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }
  // Or do other work.
}

class FirebaseNotification {

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();
  final remoteMsgCtrl = StreamController<RemoteMessage>.broadcast();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
          (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
        streamCtlr.sink.add(message.data.toString());
        remoteMsgCtrl.sink.add(message);

        log("Notification Data");
        log(message.senderId.toString());
        log(message.category.toString());
        log(message.collapseKey.toString());
        log(message.contentAvailable.toString());
        log(message.data.toString());
        log(message.messageId.toString());
        log(message.messageType.toString());
        log(message.mutableContent.toString());
        log(message.notification!.toString());
        log(message.sentTime.toString());
        log(message.threadId.toString());
        log(message.ttl.toString());
      },
    );

    dispose() {
      streamCtlr.close();
      bodyCtlr.close();
      titleCtlr.close();
      remoteMsgCtrl.close();
    }
  }
}

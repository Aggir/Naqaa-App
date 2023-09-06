import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:naqaa/app/di/dependency_injection.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Payload ${message.data}');
  print('Title ${message.notification?.title}');
  print('Body ${message.notification?.body}');
}

class PermissionHandler {
  static Future<NotificationSettings> initNotifications() async {
    final firebaseMessaging = instance<FirebaseMessaging>();
    NotificationSettings response = await firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    return response;
  }
}

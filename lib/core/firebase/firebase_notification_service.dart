import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseNotificationService() {
    initialize();
  }
  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.subscribeToTopic('all');
  }
}

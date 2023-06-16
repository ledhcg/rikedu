import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class NotificationService extends GetxService {
  static NotificationService get to => Get.find();
  final FirebaseService firebaseService = Get.find();
  final StorageService storageService = Get.find();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int notificationIdCounter = 0;

  String userID = '';

  Future<NotificationService> init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('logo');
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _isAndroidPermissionGranted();
    _requestPermissions();
    getUserID();
    return this;
  }

  Future<void> getUserID() async {
    if (storageService.hasData(StorageConst.USER_ID)) {
      userID = await storageService.readData(StorageConst.USER_ID);
    }
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
    }
  }

  Future<void> showNotification(String title, String message) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification',
      'notification',
      channelDescription: 'notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    notificationIdCounter++;
    await _flutterLocalNotificationsPlugin.show(
        notificationIdCounter, title, message, platformChannelSpecifics);
  }

  void listenToNotificationChanges() {
    firebaseService
        .listenDataChange(FirebaseConst.USER_NOTIFICATION)
        .then((stream) {
      stream.listen((snapshot) {
        for (var change in snapshot.docChanges) {
          print("New notification: ${change.doc.data()}");
          if (change.type == DocumentChangeType.added) {
            final title = change.doc['title'];
            final message = change.doc['message'];
            final toUserId = change.doc['to_user_id'];
            print("User ID: $userID");
            print("ToUserId ID: $toUserId");
            print("New notification detail: ${change.doc['message']}");
            if (toUserId == userID) {
              showNotification(title, message);
            }
          }
        }
      });
    });
  }
}

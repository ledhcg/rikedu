import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/constants/roles_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class AppUsageProvider with ChangeNotifier {
  final FirebaseService firebaseService = Get.find();
  final StorageService storageService = Get.find();
  late Timer _timer;
  final RxString _studentID = ''.obs;
  String get studentID => _studentID.value;

  final RxString _userRole = ''.obs;
  String get userRole => _userRole.value;

  List<Map<String, dynamic>> listApp = [];

  Future<void> init() async {
    await getRoleUser();
    await getStudentID();
    if (userRole == RolesConst.STUDENT) {
      getListAppUsage();
      //Run it every 10 seconds
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        getListAppUsage();
      });
    }
  }

  Future<void> getStudentID() async {
    if (storageService.hasData(StorageConst.STUDENT_ID)) {
      _studentID.value = await storageService.readData(StorageConst.STUDENT_ID);
    }
  }

  Future<void> getRoleUser() async {
    if (storageService.hasData(StorageConst.USER_ROLE)) {
      _userRole.value = await storageService.readData(StorageConst.USER_ROLE);
    }
  }

  Future<Stream<DocumentSnapshot<Object?>>> streamAppUsage() async {
    return await firebaseService.streamData(
        FirebaseConst.STUDENT_APP_USAGE, studentID);
  }

  Future<void> getListAppUsage() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(days: 1));

    List<AppUsageInfo> appUsageInfoList =
        await AppUsage().getAppUsage(startDate, endDate);

    appUsageInfoList.sort(
        (a, b) => b.usage.inMilliseconds.compareTo(a.usage.inMilliseconds));

    List<Map<String, dynamic>> listApp = [];

    await Future.forEach(appUsageInfoList, (application) async {
      Application? app = await DeviceApps.getApp(application.packageName, true);
      Uint8List iconApp = app is ApplicationWithIcon ? app.icon : Uint8List(0);
      listApp.add({
        'appName': app!.appName,
        'usageTime': application.usage.inMinutes.toString(),
        'lastForeground': application.lastForeground.toString(),
        'iconApp': base64.encode(iconApp),
      });
    });
    print("LIST APP: $listApp");
    await firebaseService.setData(
      FirebaseConst.STUDENT_APP_USAGE,
      studentID,
      {
        'appUsage': listApp,
      },
      SetOptions(merge: true),
    );
  }
}

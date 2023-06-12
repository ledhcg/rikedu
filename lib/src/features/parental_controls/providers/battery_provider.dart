import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/constants/roles_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class BatteryProvider with ChangeNotifier {
  final FirebaseService firebaseService = Get.find();
  final StorageService storageService = Get.find();

  final Battery battery = Battery();

  final Rx<BatteryState> _batteryState = BatteryState.unknown.obs;
  BatteryState get batteryState => _batteryState.value;

  final RxInt _batteryLevel = 0.obs;
  int get batteryLevel => _batteryLevel.value;

  final RxString _studentID = ''.obs;
  String get studentID => _studentID.value;

  final RxString _userRole = ''.obs;
  String get userRole => _userRole.value;

  Future<void> init() async {
    await getRoleUser();
    await getStudentID();
    if (userRole == RolesConst.STUDENT) {
      _updateBatteryInfo();
      battery.onBatteryStateChanged.listen((BatteryState batteryState) {
        _updateBatteryInfo();
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

  Future<Stream<DocumentSnapshot<Object?>>> streamBattery() async {
    return await firebaseService.streamData(
        FirebaseConst.STUDENT_BATTERY, studentID);
  }

  void _updateBatteryInfo() async {
    _batteryLevel.value = await battery.batteryLevel;
    _batteryState.value = await battery.batteryState;
    await firebaseService.setData(
      FirebaseConst.STUDENT_BATTERY,
      studentID,
      {
        'batteryLevel': batteryLevel,
        'batteryState': batteryState.toString(),
      },
      SetOptions(merge: true),
    );
    notifyListeners();
  }
}

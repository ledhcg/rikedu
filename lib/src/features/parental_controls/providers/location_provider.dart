import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/constants/roles_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class LocationProvider with ChangeNotifier {
  final FirebaseService firebaseService = Get.find();
  final StorageService storageService = Get.find();

  final RxString _studentID = ''.obs;
  String get studentID => _studentID.value;

  final RxString _userRole = ''.obs;
  String get userRole => _userRole.value;

  final Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;

  Future<void> init() async {
    await getRoleUser();
    await getStudentID();
    if (userRole == RolesConst.STUDENT) {
      print("Hoat dong");
      await requestPermission();
      location.changeSettings(interval: 300, accuracy: LocationAccuracy.high);
      location.enableBackgroundMode(enable: true);
      listenLocation();
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

  Future<Stream<DocumentSnapshot<Object?>>> streamLocation() async {
    return await firebaseService.streamData(FirebaseConst.USER, studentID);
  }

  void listenLocation() {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      notifyListeners();
    }).listen((LocationData currentLocation) async {
      await firebaseService.setData(
        FirebaseConst.USER,
        studentID,
        {
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude,
        },
        SetOptions(merge: true),
      );
    });
  }

  void stopListening() {
    _locationSubscription?.cancel();
    notifyListeners();
  }

  Future<void> requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      await requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

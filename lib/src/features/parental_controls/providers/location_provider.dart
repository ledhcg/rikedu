import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class LocationProvider with ChangeNotifier {
  final FirebaseService firebaseService = Get.find();
  final StorageService storageService = Get.find();

  String _studentID = '';
  String get studentID => _studentID;

  final Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;

  LatLng _currentPosition = const LatLng(0, 0);
  LatLng get currentPosition => _currentPosition;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    await requestPermission();
    await getStudentID();
    location.changeSettings(interval: 300, accuracy: LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    await getLocation();
    _isLoading = false;
    await listenLocation();
  }

  Future<void> getStudentID() async {
    if (storageService.hasData(StorageConst.STUDENT_ID)) {
      final studentID = await storageService.readData(StorageConst.STUDENT_ID);
      _studentID =
          storageService.hasData(StorageConst.STUDENT_ID) ? studentID : '';
    }
  }

  Future<void> getLocation() async {
    try {
      final LocationData locationResult = await location.getLocation();
      await firebaseService.setData(
        FirebaseConst.USER,
        studentID,
        {
          'latitude': locationResult.latitude,
          'longitude': locationResult.longitude,
        },
        SetOptions(merge: true),
      );
      _currentPosition =
          LatLng(locationResult.latitude!, locationResult.longitude!);
    } catch (e) {
      print(e);
    }
  }

  Future<Stream<DocumentSnapshot<Object?>>> streamLocation() async {
    return await firebaseService.streamData(FirebaseConst.USER, studentID);
  }

  Future<void> listenLocation() async {
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
      _currentPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
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

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/parental_controls/providers/location_provider.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';
// import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'package:rikedu/src/utils/service/storage_service.dart';

class MapController extends GetxController {
  final locationProvider = Provider.of<LocationProvider>(Get.context!);

  final FirebaseService firebaseService = Get.find();
  final StorageService _storageService = Get.find();

  final RxString _studentID = ''.obs;
  String get studentID => _studentID.value;

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  final Rx<LatLng> _currentPosition = const LatLng(0, 0).obs;
  LatLng get currentPosition => _currentPosition.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    super.onInit();
    requestPermission();
    await _getStudentID();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    await getLocation();
    _isLoading.value = false;
    await listenLocation();
  }

  Future<void> _getStudentID() async {
    if (_storageService.hasData(StorageConst.STUDENT_ID)) {
      final studentID = await _storageService.readData(StorageConst.STUDENT_ID);
      _studentID.value =
          _storageService.hasData(StorageConst.STUDENT_ID) ? studentID : "";
    }
  }

  Future<void> getLocation() async {
    try {
      final loc.LocationData locationResult = await location.getLocation();
      await firebaseService.setData(
          FirebaseConst.USER,
          studentID,
          {
            'latitude': locationResult.latitude,
            'longitude': locationResult.longitude,
          },
          SetOptions(merge: true));
      _currentPosition.value =
          LatLng(locationResult.latitude!, locationResult.longitude!);
    } catch (e) {
      print(e);
    }
  }

  Future<void> listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      update();
    }).listen((loc.LocationData currentLocation) async {
      await firebaseService.setData(
          FirebaseConst.USER,
          studentID,
          {
            'latitude': currentLocation.latitude,
            'longitude': currentLocation.longitude,
          },
          SetOptions(merge: true));
      _currentPosition.value =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  void stopListening() {
    _locationSubscription?.cancel();
    update();
  }

  void requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class GMapController extends GetxController {
  final FirebaseService _firebaseService = Get.find();
  final StorageService _storageService = Get.find();

  Stream<DocumentSnapshot<Object?>>? _dataStream;

  final loc.Location location = loc.Location();

  late GoogleMapController _controllerGM;
  GoogleMapController get controllerGM => _controllerGM;
  set controllerGM(GoogleMapController value) => _controllerGM = value;

  BitmapDescriptor locationMarker = BitmapDescriptor.defaultMarker;

  final RxString _studentID = ''.obs;
  String get studentID => _studentID.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final Rx<LatLng> _currentPosition = const LatLng(0, 0).obs;
  LatLng get currentPosition => _currentPosition.value;

  @override
  void onInit() async {
    super.onInit();
    await _getStudentID();
    setLocationMarker();
    listenDataLocation();
    _isLoading.value = false;
  }

  Future<void> listenDataLocation() async {
    _dataStream =
        await _firebaseService.streamData(FirebaseConst.USER, studentID);
    _dataStream!.listen((snapshot) async {
      // Handle the received snapshot
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        _currentPosition.value = LatLng(data['latitude'], data['longitude']);
        print("LOCATION: ${data['latitude']} - ${data['longitude']}");
        animateCamera();
        // Process the data
      } else {
        // The document doesn't exist
      }
    }, onError: (error) {
      // Handle any errors that occur during streaming
    });
  }

  Future<void> _getStudentID() async {
    if (_storageService.hasData(StorageConst.STUDENT_ID)) {
      final studentID = await _storageService.readData(StorageConst.STUDENT_ID);
      _studentID.value =
          _storageService.hasData(StorageConst.STUDENT_ID) ? studentID : "";
    }
  }

  void setLocationMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      FilesConst.ICON_MARKER,
    ).then((marker) {
      locationMarker = marker;
    });
  }

  void animateCamera() {
    controllerGM.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentPosition,
        zoom: 16,
        tilt: 45.0,
      ),
    ));
  }

  void onMapCreated(String value) async {
    controllerGM.setMapStyle(value);
    controllerGM.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentPosition,
        zoom: 16,
        tilt: 45.0,
      ),
    ));
  }

  @override
  void onClose() {
    controllerGM.dispose();
    super.onClose();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:location/location.dart' as loc;
import 'package:rikedu/src/utils/constants/files_constants.dart';

class AboutController extends GetxController {
  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxString _appName = ''.obs;
  String get appName => _appName.value;

  final RxString _appVersion = ''.obs;
  String get appVersion => _appVersion.value;

  final RxString _description = ''.obs;
  String get description => _description.value;

  final loc.Location location = loc.Location();

  final Rx<Completer<GoogleMapController>> _controllerGM =
      Completer<GoogleMapController>().obs;
  Completer<GoogleMapController> get controllerGM => _controllerGM.value;
  set controllerGM(Completer<GoogleMapController> value) =>
      _controllerGM.value = value;

  BitmapDescriptor locationMarker = BitmapDescriptor.defaultMarker;
  final Rx<LatLng> _currentPosition = const LatLng(55.673296, 37.480067).obs;
  LatLng get currentPosition => _currentPosition.value;

  @override
  void onInit() async {
    super.onInit();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName.value = packageInfo.appName;
    _appVersion.value = packageInfo.version;
    _description.value =
        "This is a cross-platform Flutter application designed for parents, students, and teachers to manage student information.";
    setLocationMarker();
    _isLoading.value = false;
  }

  void setLocationMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      FilesConst.ICON_SCHOOL_MARKER,
    ).then((marker) {
      locationMarker = marker;
    });
  }

  void animateCamera() async {
    final GoogleMapController controller = await controllerGM.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentPosition,
        zoom: 17,
        tilt: 45.0,
      ),
    ));
  }

  void onMapCreated(String value) async {
    final GoogleMapController controller = await controllerGM.future;

    await controller.setMapStyle(value);
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentPosition,
        zoom: 17,
        tilt: 45.0,
      ),
    ));
  }
}

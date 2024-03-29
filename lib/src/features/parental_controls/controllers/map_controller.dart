import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/parental_controls/providers/location_provider.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';

class MapController extends GetxController {
  final locationProvider = Provider.of<LocationProvider>(Get.context!);

  Stream<DocumentSnapshot<Object?>>? _dataStream;

  final loc.Location location = loc.Location();

  final Rx<Completer<GoogleMapController>> _controllerGM =
      Completer<GoogleMapController>().obs;
  Completer<GoogleMapController> get controllerGM => _controllerGM.value;
  set controllerGM(Completer<GoogleMapController> value) =>
      _controllerGM.value = value;

  BitmapDescriptor locationMarker = BitmapDescriptor.defaultMarker;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final Rx<LatLng> _currentPosition =
      const LatLng(55.75420052657267, 37.62076578248755).obs;
  LatLng get currentPosition => _currentPosition.value;

  @override
  void onInit() async {
    super.onInit();
    listenDataLocation();
    setLocationMarker();
    _isLoading.value = false;
  }

  Future<void> listenDataLocation() async {
    _dataStream = await locationProvider.streamLocation();
    _dataStream!.listen((snapshot) async {
      // Handle the received snapshot
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        _currentPosition.value = LatLng(data['latitude'], data['longitude']);
        print("LOCATION: ${data['latitude']} - ${data['longitude']}");
        animateCamera();
      } else {
        print("The document doesn't exist");
      }
    }, onError: (error) {
      print(error);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void setLocationMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset(FilesConst.ICON_MARKER, 80);
    locationMarker = BitmapDescriptor.fromBytes(markerIcon);
  }

  void animateCamera() async {
    final GoogleMapController controller = await controllerGM.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentPosition,
        zoom: 16,
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
        zoom: 16,
        tilt: 45.0,
      ),
    ));
  }
}

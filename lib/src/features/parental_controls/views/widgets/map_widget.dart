import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rikedu/src/features/parental_controls/controllers/map_controller.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class MapWidget extends GetView<MapController> {
  const MapWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => controller.isLoading
          ? const LoadingWidget()
          : GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              compassEnabled: false,
              markers: {
                Marker(
                  position: controller.currentPosition,
                  markerId: const MarkerId('STUDENT'),
                  icon: controller.locationMarker,
                )
              },
              initialCameraPosition: CameraPosition(
                target: controller.currentPosition,
                zoom: 16,
                tilt: 45.0,
              ),
              onMapCreated: (GoogleMapController controllerGM) async {
                String value = await DefaultAssetBundle.of(context)
                    .loadString(FilesConst.MAP_LIGHT);
                controller.controllerGM.complete(controllerGM);
                controller.onMapCreated(value);
                controller.animateCamera();
              },
            ),
    ));
  }
}

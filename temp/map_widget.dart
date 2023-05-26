// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rikedu/src/features/parental_controls/controllers/map_controller.dart';

// class MapWidget extends GetView<MapController> {
//   const MapWidget({super.key});

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //       body: Obx(
//   //     () => controller.isLoading
//   //         ? const LoadingWidget()
//   //         : GoogleMap(
//   //             mapType: MapType.normal,
//   //             zoomControlsEnabled: false,
//   //             compassEnabled: false,
//   //             markers: controller.marker,
//   //             initialCameraPosition: CameraPosition(
//   //               target: LatLng(
//   //                 controller.latitude,
//   //                 controller.longitude,
//   //               ),
//   //               zoom: 16,
//   //               tilt: 45.0,
//   //             ),
//   //             onMapCreated: (GoogleMapController controllerGM) async {
//   //               String value = await DefaultAssetBundle.of(context)
//   //                   .loadString(FilesConst.MAP_LIGHT);
//   //               controller.controllerGM = controllerGM;
//   //               controller.initMap(value);
//   //               controller.isAdd = true;
//   //             },
//   //           ),
//   //   ));
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('live location tracker'),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//               onPressed: () {
//                 controller.getLocation();
//               },
//               child: const Text('add my location')),
//           TextButton(
//               onPressed: () {
//                 controller.listenLocation();
//               },
//               child: const Text('enable live location')),
//           TextButton(
//               onPressed: () {
//                 controller.stopListening();
//               },
//               child: const Text('stop live location')),
//         ],
//       ),
//     );
//   }
// }

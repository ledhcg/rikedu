import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rikedu/src/features/settings/controllers/about_controller.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class AboutModal extends GetView<AboutController> {
  const AboutModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const LoadingWidget()
          : Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: SizesConst.P0),
                  child: Image.asset(FilesConst.LOGO_ROUNDED),
                ),
                Text(
                  controller.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Version ${controller.appVersion}',
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: const SizedBox(
                    height: 160,
                    child: SchoolMap(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Полное наименование образовательной организации",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Государственное бюджетное общеобразовательное учреждение средняя общеобразовательная школа №164",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Сокращенное наименование образовательной организации",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "ГБОУ школа №164(RIKEDU)",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Режим и график работы школы",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Понедельник-пятница: с 8:00 до 20:00",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Суббота: с 8:00 до 15:00",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Контактная информация",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Телефон приёмной: (999) 999-89-89",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Электронная почта: info@rikedu.ru",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
    );
  }
}

class SchoolMap extends GetView<AboutController> {
  const SchoolMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      compassEnabled: false,
      markers: {
        Marker(
          position: controller.currentPosition,
          markerId: const MarkerId('SCHOOL'),
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
    );
  }
}

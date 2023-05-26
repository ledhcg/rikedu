import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/baterry_controller.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class BatteryWidget extends GetView<BatteryController> {
  const BatteryWidget({this.withText = true, super.key});

  final bool withText;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const LoadingWidget()
          : withText
              ? Row(children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: controller.iconBattery,
                  ),
                  Text(
                    "${controller.batteryLevel}%",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ])
              : SizedBox(
                  height: 32,
                  width: 32,
                  child: controller.iconBattery,
                ),
    );
  }
}

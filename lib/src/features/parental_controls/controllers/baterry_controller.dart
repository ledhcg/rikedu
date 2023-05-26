import 'package:battery_plus/battery_plus.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/parental_controls/providers/battery_provider.dart';
import 'package:rikedu/src/utils/constants/colors_constants.dart';

class BatteryController extends GetxController {
  final batteryProvider = Provider.of<BatteryProvider>(Get.context!);

  final Rx<Icon?> _iconBattery = Rx<Icon?>(null);
  Icon? get iconBattery => _iconBattery.value;

  final RxString _batteryState = "BatteryState.unknown".obs;
  String get batteryState => _batteryState.value;

  final RxInt _batteryLevel = 0.obs;
  int get batteryLevel => _batteryLevel.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    super.onInit();
    _batteryState.value = batteryProvider.batteryState.toString();
    _batteryLevel.value = batteryProvider.batteryLevel;
    print("Battery: $batteryState - $batteryLevel");
    _iconBattery.value = await setBatteryIcon(batteryLevel, batteryState);
    _isLoading.value = false;
  }

  Future<Icon> setBatteryIcon(int batteryLevel, String batteryState) async {
    if (batteryState == BatteryState.charging.toString()) {
      return const Icon(FluentIcons.battery_charge_24_regular,
          color: rikeGreenBattery);
    }
    if (batteryState == BatteryState.full.toString()) {
      return const Icon(FluentIcons.battery_0_24_filled,
          color: rikeGreenBattery);
    }

    if (batteryLevel >= 0 && batteryLevel <= 10) {
      return const Icon(
        FluentIcons.battery_0_24_regular,
        color: rikeRedBattery,
      );
    } else if (batteryLevel > 10 && batteryLevel <= 20) {
      return const Icon(
        FluentIcons.battery_1_24_regular,
        color: rikeRedBattery,
      );
    } else if (batteryLevel > 20 && batteryLevel <= 30) {
      return const Icon(
        FluentIcons.battery_2_24_regular,
        color: rikeYellowBattery,
      );
    } else if (batteryLevel > 30 && batteryLevel <= 40) {
      return const Icon(
        FluentIcons.battery_3_24_regular,
        color: rikeYellowBattery,
      );
    } else if (batteryLevel > 40 && batteryLevel <= 50) {
      return const Icon(
        FluentIcons.battery_4_24_regular,
        color: rikeYellowBattery,
      );
    } else if (batteryLevel > 50 && batteryLevel <= 60) {
      return const Icon(
        FluentIcons.battery_5_24_regular,
        color: rikeYellowBattery,
      );
    } else if (batteryLevel > 60 && batteryLevel <= 70) {
      return const Icon(
        FluentIcons.battery_6_24_regular,
        color: rikeGreenBattery,
      );
    } else if (batteryLevel > 70 && batteryLevel <= 80) {
      return const Icon(
        FluentIcons.battery_7_24_regular,
        color: rikeGreenBattery,
      );
    } else if (batteryLevel > 80 && batteryLevel <= 90) {
      return const Icon(
        FluentIcons.battery_9_24_regular,
        color: rikeGreenBattery,
      );
    } else if (batteryLevel > 90 && batteryLevel <= 100) {
      return const Icon(
        FluentIcons.battery_10_24_regular,
        color: rikeGreenBattery,
      );
    }
    return const Icon(
      FluentIcons.battery_warning_24_regular,
      color: rikeGreenBattery,
    );
  }
}

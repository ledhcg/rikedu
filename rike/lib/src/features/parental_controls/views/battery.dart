import 'dart:async';

import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:rike/src/constants/colors.dart';
import 'package:rike/src/features/parental_controls/views/widgets/phone_status.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  final Battery _battery = Battery();
  BatteryState? _batteryState;

  Icon? iconBattery;
  int _batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    _getBatteryInfo();
    _battery.onBatteryStateChanged.listen((BatteryState batteryState) {
      _getBatteryInfo();
    });
  }

  void _getBatteryInfo() async {
    int batteryLevel = await _battery.batteryLevel;
    BatteryState batteryState = await _battery.batteryState;
    setState(() {
      _batteryLevel = batteryLevel;
      _batteryState = batteryState;
      iconBattery = setBatteryIcon(_batteryLevel, _batteryState!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PhoneStatus(
        batteryLevel: _batteryLevel, online: true, iconBattery: iconBattery!);
  }

  Icon setBatteryIcon(int batteryLevel, BatteryState batteryState) {
    if (batteryState == BatteryState.charging) {
      return const Icon(FluentIcons.battery_charge_24_regular,
          color: rikeGreenBattery);
    }

    if (batteryState == BatteryState.full) {
      return const Icon(FluentIcons.battery_0_24_filled,
          color: rikeGreenBattery);
    }

    if (batteryLevel >= 0 && batteryLevel <= 10) {
      iconBattery = const Icon(
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

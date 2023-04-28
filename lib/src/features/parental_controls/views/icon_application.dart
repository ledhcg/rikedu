import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class IconApplication extends StatefulWidget {
  final String packageName;
  const IconApplication({Key? key, required this.packageName})
      : super(key: key);

  @override
  State<IconApplication> createState() => _IconApplicationState();
}

class _IconApplicationState extends State<IconApplication> {
  Uint8List? iconApplication;

  @override
  void initState() {
    super.initState();
    getAppIconFromPackageName(widget.packageName);
  }

  void getAppIconFromPackageName(String packageName) async {
    final Application? app = await DeviceApps.getApp(packageName, true);
    if (app is ApplicationWithIcon) {
      iconApplication = app.icon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.memory(iconApplication!);
  }
}

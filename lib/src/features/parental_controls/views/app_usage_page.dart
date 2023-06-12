import 'dart:convert';
import 'dart:typed_data';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/app_usage_controller.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class AppUsagePage extends GetView<AppUsageController> {
  const AppUsagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const LoadingWidget()
          : Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                automaticallyImplyLeading: true,
                backgroundColor: Colors.transparent,
                title: Text(
                  'App Usage'.tr,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                ),
                centerTitle: true,
                leading: Transform.translate(
                  offset: const Offset(SizesConst.P1, 0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    icon: const Icon(FluentIcons.chevron_left_48_filled),
                  ),
                ),
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  itemCount: controller.listApp.length,
                  itemBuilder: (context, index) {
                    final application = controller.listApp[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Theme.of(context).colorScheme.background,
                          child: ListTile(
                            leading: application["iconApp"] != Uint8List(0)
                                ? CircleAvatar(
                                    backgroundImage: MemoryImage(
                                        Uint8List.fromList(base64
                                            .decode(application["iconApp"])
                                            .cast<int>())))
                                : const CircleAvatar(child: Icon(Icons.apps)),
                            title: Text(application["appName"]),
                            subtitle: Text(
                              'Usage Time: X min'
                                  .trParams({'min': application["usageTime"]}),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

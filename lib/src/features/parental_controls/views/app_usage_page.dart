import 'dart:convert';
import 'dart:typed_data';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/app_usage_controller.dart';
import 'package:rikedu/src/utils/constants/colors_constants.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:skeletons/skeletons.dart';

class AppUsagePage extends GetView<AppUsageController> {
  const AppUsagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
          child: Skeleton(
            shimmerGradient: SkeletonColorStyle.ON_SHIMMER_LIGHT,
            isLoading: controller.isLoading,
            skeleton: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: const ListTile(
                        leading: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: SkeletonLine(
                          style: SkeletonLineStyle(
                              width: 150,
                              height: 15,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              alignment: Alignment.center),
                        ),
                        subtitle: SkeletonLine(
                          style: SkeletonLineStyle(
                              width: 250,
                              height: 10,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              alignment: Alignment.center),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
                                backgroundImage: MemoryImage(Uint8List.fromList(
                                    base64
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
      ),
    );
  }
}

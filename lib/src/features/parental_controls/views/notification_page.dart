import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/notification_controller.dart';
import 'package:rikedu/src/features/parental_controls/models/notification_dart.dart';

import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

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
                  'Notifications'.tr,
                  style: Theme.of(context).textTheme.headlineLarge,
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
              body: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DefaultTabController(
                    length: controller.tabs.length,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          padding: EdgeInsets.zero,
                          tabs: controller.tabs
                              .map((tab) => Tab(text: tab.tr))
                              .toList(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                              children: controller.tabs
                                  .map((tab) =>
                                      BuildItemsNotificationList(tab: tab))
                                  .toList()),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class BuildItemsNotificationList extends GetView<NotificationController> {
  const BuildItemsNotificationList({
    super.key,
    required this.tab,
  });

  final String tab;

  @override
  Widget build(BuildContext context) {
    List<Notifi> notificationItems = [];
    if (tab == 'School') {
      notificationItems = controller.notifications;
    } else {
      notificationItems = controller.notifications;
    }
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: notificationItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: ListTile(
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    FluentIcons.alert_urgent_24_regular,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(notificationItems[index].title),
                subtitle: Text(notificationItems[index].message),
                trailing: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    FluentIcons.mail_inbox_checkmark_28_regular,
                    size: 20,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                onLongPress: () =>
                    controller.markAsRead(notificationItems[index].id),
              ),
            ),
          ),
        );
      },
    );
  }
}

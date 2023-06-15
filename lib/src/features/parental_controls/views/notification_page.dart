import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/notification_controller.dart';
import 'package:rikedu/src/features/parental_controls/models/notification_model.dart';

import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:skeletons/skeletons.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                  Skeleton(
                    isLoading: controller.isLoading,
                    skeleton: SkeletonItem(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 100,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    alignment: Alignment.center),
                              ),
                              SizedBox(width: 20),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 100,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    alignment: Alignment.center),
                              ),
                            ]),
                      ),
                    ),
                    child: TabBar(
                      isScrollable: true,
                      padding: const EdgeInsets.only(bottom: 30),
                      tabs: controller.tabs
                          .map((tab) => Tab(text: tab.tr))
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: controller.tabs
                            .map((tab) => BuildItemsNotificationList(
                                  tab: tab,
                                  isLoading: controller.isLoading,
                                ))
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
    required this.isLoading,
  });

  final String tab;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    List<Notifi> notificationItems = [];
    if (tab == 'School') {
      notificationItems = controller.notifications;
    } else {
      notificationItems = controller.notificationsRealtime;
    }
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: isLoading ? 10 : notificationItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: isLoading
                  ? ListTile(
                      leading: const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 30, height: 30),
                      ),
                      title: const SkeletonLine(
                        style: SkeletonLineStyle(
                            width: 250,
                            height: 20,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            padding: EdgeInsets.only(bottom: 10)),
                      ),
                      subtitle: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 3,
                            spacing: 5,
                            padding: const EdgeInsets.all(0),
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(10),
                              minLength: MediaQuery.of(context).size.width / 2,
                            )),
                      ),
                      trailing: const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 30, height: 30),
                      ),
                    )
                  : ListTile(
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

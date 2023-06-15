import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/news/views/widgets/image_container_widget.dart';
import 'package:rikedu/src/features/parental_controls/controllers/group_controller.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:skeletons/skeletons.dart';

class GroupPage extends GetView<GroupController> {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Group X'.trParams({'groupName': controller.groupName}),
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
                        children: controller.tabs
                            .map((tab) => BuildItemsGroupList(
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

class BuildItemsGroupList extends GetView<GroupController> {
  const BuildItemsGroupList({
    super.key,
    required this.tab,
    required this.isLoading,
  });

  final String tab;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    List<User> userItems = [];
    if (tab == 'Students') {
      userItems = controller.students;
    } else {
      userItems = controller.teachers;
    }
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: isLoading ? 10 : userItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: isLoading
                  ? const ListTile(
                      leading: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 50, height: 50),
                      ),
                      title: SkeletonLine(
                        style: SkeletonLineStyle(
                            width: 250,
                            height: 20,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            padding: EdgeInsets.only(bottom: 10)),
                      ),
                      subtitle: SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 200,
                          height: 15,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  : ListTile(
                      leading: ImageContainer(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.all(0),
                        borderRadius: 25,
                        isLoading: isLoading,
                        imageUrl: userItems[index].avatarUrl,
                      ),
                      title: Text(userItems[index].fullName),
                      subtitle: Text(userItems[index].email),
                    ),
            ),
          ),
        );
      },
    );
  }
}

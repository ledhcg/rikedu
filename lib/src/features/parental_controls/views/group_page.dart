import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/parental_controls/controllers/group_controller.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class GroupPage extends GetView<GroupController> {
  const GroupPage({super.key});

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
                                  .map((tab) => BuildItemsGroupList(tab: tab))
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
  });

  final String tab;

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
      itemCount: userItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: ListTile(
                leading: CircleAvatar(
                    child: Image.network(userItems[index].avatarUrl)),
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

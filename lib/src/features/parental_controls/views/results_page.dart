import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/parental_controls/controllers/results_controller.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:skeletons/skeletons.dart';

class ResultsPage extends GetView<ResultsController> {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> listLoading = List.generate(20, (index) => null);
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          title: BoxStudent(student: controller.student),
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
        body: Skeleton(
          isLoading: controller.isLoading,
          skeleton: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 100,
                          height: 30,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          alignment: Alignment.center),
                    ),
                    SizedBox(width: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 100,
                          height: 30,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          alignment: Alignment.center),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 200,
                          height: 30,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          alignment: Alignment.center),
                    ),
                    SizedBox(width: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 40,
                          height: 30,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          alignment: Alignment.center),
                    ),
                    SizedBox(width: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 40,
                          height: 30,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          alignment: Alignment.center),
                    ),
                    SizedBox(width: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 40,
                          height: 30,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          alignment: Alignment.center),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listLoading
                    .map(
                      (result) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  width: 200,
                                  height: 20,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  alignment: Alignment.center),
                            ),
                            SizedBox(width: 20),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  width: 40,
                                  height: 20,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  alignment: Alignment.center),
                            ),
                            SizedBox(width: 20),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  width: 40,
                                  height: 20,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  alignment: Alignment.center),
                            ),
                            SizedBox(width: 20),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  width: 40,
                                  height: 20,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  alignment: Alignment.center),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DefaultTabController(
                length: controller.tabs.length,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      padding: const EdgeInsets.only(bottom: 30),
                      tabs: controller.tabs
                          .map((tab) => Tab(text: tab.tr))
                          .toList(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                          children: controller.tabs
                              .map(
                                (tab) => TabContent(tab: tab),
                              )
                              .toList()),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabContent extends GetView<ResultsController> {
  const TabContent({
    super.key,
    required this.tab,
  });

  final String tab;

  @override
  Widget build(BuildContext context) {
    if (tab == 'Performance Table') {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text(
              'Subject'.tr.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'T1',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'T2',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'T3',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'AT',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'FE',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'Review'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
          ],
          rows: controller.results
              .map((result) => DataRow(cells: [
                    DataCell(Text(result.subjectName)),
                    DataCell(Text(result.exam1.toString())),
                    DataCell(Text(result.exam2.toString())),
                    DataCell(Text(result.exam3.toString())),
                    DataCell(Text(result.active.toString())),
                    DataCell(Text(result.finalExam.toString())),
                    DataCell(Text(result.review)),
                  ]))
              .toList(),
        ),
      );
    }
    if (tab == 'Exams') {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text(
              'Subject'.tr.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'Title'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'Mark'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'Review'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'Description'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
          ],
          rows: controller.exams
              .map((exam) => DataRow(cells: [
                    DataCell(Text(exam.subjectName)),
                    DataCell(Text(exam.title)),
                    DataCell(Text(exam.mark.toString())),
                    DataCell(Text(exam.review)),
                    DataCell(Text(exam.description)),
                  ]))
              .toList(),
        ),
      );
    }
    return Center(
      child: Text('Data not found!'.tr),
    );
  }
}

class BoxStudent extends StatelessWidget {
  const BoxStudent({
    required this.student,
    super.key,
  });

  final User student;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
              radius: 10, backgroundImage: NetworkImage(student.avatarUrl)),
          const SizedBox(width: 10),
          Text(
            student.fullName,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          )
        ],
      ),
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/exercise_controller.dart';
import 'package:rikedu/src/features/parental_controls/models/exercise_model.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';

class ExerciseDetailPage extends GetView<ExerciseController> {
  const ExerciseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    final exercise = data[0] as Exercise;
    final index = data[1];
    controller.resetDataDefault(true);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
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
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              SubjectWidget(
                subject: exercise.subjectName,
              ),
              const SizedBox(height: 16),
              Text(
                exercise.topic,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                exercise.note,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Deadline'.tr,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${exercise.deadline.day.toString().padLeft(2, '0')}/${exercise.deadline.month.toString().padLeft(2, '0')}/${exercise.deadline.year.toString()}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Obx(() {
                if (exercise.mark == 0) {
                  controller.markController.text = 'No reviews yet.'.tr;
                  controller.reviewController.text = 'No reviews yet.'.tr;
                } else {
                  controller.markController.text = exercise.mark.toString();
                  controller.reviewController.text = exercise.review;
                }
                return exercise.file != ''
                    ? ContainerResult(exercise: exercise)
                    : controller.hasDataSubmit
                        ? ContainerResult(exercise: controller.exerciseSubmit)
                        : GestureDetector(
                            onTap: controller.selectFile,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(20),
                                  dashPattern: const [10, 4],
                                  strokeCap: StrokeCap.round,
                                  color: Colors.blue.shade400,
                                  child: Container(
                                    width: double.infinity,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.blue.shade50.withOpacity(.3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() {
                                          if (controller.platformFile != null) {
                                            return const SizedBox(
                                              height: 30,
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              controller.platformFile != null
                                                  ? controller.icon!
                                                  : const Icon(
                                                      FluentIcons
                                                          .document_queue_24_filled,
                                                      color: Colors.blue,
                                                      size: 40,
                                                    ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              controller.platformFile != null
                                                  ? Text(
                                                      controller
                                                          .platformFile!.name,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      'Upload your file'.tr,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                              controller.platformFile != null
                                                  ? Text(
                                                      '${(controller.platformFile!.size / 1024).ceil()} KB',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.blue),
                                                    )
                                                  : Text(
                                                      'File should be *.pdf, *.doc'
                                                          .tr,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.blue),
                                                    ),
                                            ]),
                                        Obx(() {
                                          if (controller.platformFile != null) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                20,
                                                0,
                                                20,
                                                20,
                                              ),
                                              child: Container(
                                                height: 10,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.blue.shade50,
                                                ),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      controller.loadingValue,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                      ],
                                    ),
                                  ),
                                )),
                          );
              }),
              Obx(() {
                if (controller.platformFile != null) {
                  return SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => controller.onSubmit(exercise.id, index),
                      child: controller.isLoadingSubmit
                          ? Text('Loading'.tr)
                          : Text('Submit'.tr),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerResult extends GetView<ExerciseController> {
  const ContainerResult({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue.shade400, //color of border
                width: 1, //width of border
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.blue.shade50.withOpacity(.3),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FluentIcons.document_checkmark_24_filled,
                          color: Colors.blue,
                          size: 40,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'The file has been uploaded.'.tr,
                          style:
                              const TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ]),
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => controller.openFile(exercise),
                        child: Text('Open'.tr),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            TextField(
              controller: controller.markController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Mark'.tr,
                prefixIcon: const Icon(FluentIcons.target_arrow_24_regular),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller.reviewController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Review'.tr,
                prefixIcon: const Icon(FluentIcons.note_24_regular),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({
    required this.subject,
    super.key,
  });

  final String subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          subject,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}

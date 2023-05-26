import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/parental_controls/controllers/exercise_controller.dart';
import 'package:rikedu/src/features/parental_controls/models/exercise_model.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class ExercisePage extends GetView<ExerciseController> {
  const ExercisePage({super.key});

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
                  'Exercises'.tr,
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
                  Column(
                    children: const [
                      BuildItemsExerciseList(),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

class BuildItemsExerciseList extends GetView<ExerciseController> {
  const BuildItemsExerciseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Exercise> exerciseItems = controller.exercises;
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: exerciseItems.length,
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
                    FluentIcons.box_24_filled,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(exerciseItems[index].topic),
                subtitle: Text(exerciseItems[index].note),
                trailing: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    FluentIcons.chevron_right_48_filled,
                    size: 20,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                onTap: () => Get.toNamed(Routes.EXERCISE_DETAIL,
                    arguments: exerciseItems[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}

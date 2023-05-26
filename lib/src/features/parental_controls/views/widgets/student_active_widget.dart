import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/student_active_controller.dart';
import 'package:rikedu/src/utils/constants/colors_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class StudentActiveWidget extends GetView<StudentActiveController> {
  const StudentActiveWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const LoadingWidget()
          : Row(
              children: [
                Container(
                  height: 6.0,
                  width: 6.0,
                  decoration: BoxDecoration(
                    color: controller.studentIsActive
                        ? rikeIndicatorBubble
                        : rikeDisabledColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    controller.studentIsActive ? 'Online'.tr : 'Offline'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
    );
  }
}

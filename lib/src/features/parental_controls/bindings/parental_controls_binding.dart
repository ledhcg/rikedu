import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/exercise_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/group_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/map_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/notification_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/results_controller.dart';

class ParentalControlsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupController>(() => GroupController());
    Get.lazyPut<ResultsController>(() => ResultsController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<ExerciseController>(() => ExerciseController());
    Get.lazyPut<MapController>(() => MapController());
  }
}

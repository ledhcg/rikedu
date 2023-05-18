import 'package:get/get.dart';
import 'package:rikedu/src/features/timetable/controllers/timetable_controller.dart';

class TimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimetableController>(() => TimetableController());
  }
}

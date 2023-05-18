import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rikedu/src/features/timetable/models/lesson_model.dart';
import 'package:rikedu/src/utils/helpers/schedule_helper.dart';

class TimetableController extends GetxController {
  final localStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
  }

  List<Lesson> convertDataToLessons(List<Map<String, String>> data) {
    final List<Lesson> lessons = [];

    data.forEach((subject) {
      final timeStart =
          ScheduleHelper.schoolTimesStart.keys.toList()[data.indexOf(subject)];
      final timeEnd =
          ScheduleHelper.schoolTimesEnd.keys.toList()[data.indexOf(subject)];
      final lesson = Lesson(
        subject: subject['subject']!,
        timeStart: timeStart,
        timeEnd: timeEnd,
        room: subject['room']!,
        teacher: subject['teacher']!,
      );
      lessons.add(lesson);
    });

    return lessons;
  }
}

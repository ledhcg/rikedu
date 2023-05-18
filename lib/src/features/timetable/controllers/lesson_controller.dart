import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/timetable/models/lesson_model.dart';
import 'package:rikedu/src/utils/helpers/schedule_helper.dart';

class LessonController extends GetxController {
  static LessonController get instance => Get.find();

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

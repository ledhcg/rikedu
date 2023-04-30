import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/timetable/models/lesson.dart';
import 'package:rikedu/src/utils/calendar/schedule_utlis.dart';

class LessonController extends GetxController {
  static LessonController get instance => Get.find();

  List<Lesson> convertDataToLessons(List<Map<String, String>> data) {
    final List<Lesson> lessons = [];

    data.forEach((subject) {
      final timeStart =
          ScheduleUtils.schoolTimesStart.keys.toList()[data.indexOf(subject)];
      final timeEnd =
          ScheduleUtils.schoolTimesEnd.keys.toList()[data.indexOf(subject)];
      final lesson = Lesson(
        subject: subject['subject']!,
        timeStart: timeStart,
        timeEnd: timeEnd,
        room: subject['room']!,
      );
      lessons.add(lesson);
    });

    return lessons;
  }
}

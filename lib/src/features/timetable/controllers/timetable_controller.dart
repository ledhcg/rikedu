import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/settings/providers/locale_provider.dart';
import 'package:rikedu/src/features/timetable/models/lesson_card_model.dart';
import 'package:rikedu/src/features/timetable/models/timetable_modal.dart';
import 'package:rikedu/src/features/timetable/providers/timetable_provider.dart';
import 'package:rikedu/src/utils/helpers/schedule_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class TimetableController extends GetxController {
  final timetableProvider = Provider.of<TimetableProvider>(Get.context!);
  final localProvider = Provider.of<LocaleProvider>(Get.context!, listen: true);

  //CONST
  Timetable _timetable = Timetable.defaultTimetable();

  final CalendarFormat _calendarFormat = CalendarFormat.week;
  final PageController _pageController = PageController(
      initialPage: DateTime.now().difference(DateTime.now()).inDays);

  final DateTime _firstDay = DateTime.utc(2023, 02, 01);
  final DateTime _lastDay = DateTime.utc(2023, 07, 15);

  Timetable get timetable => _timetable;
  CalendarFormat get calendarFormat => _calendarFormat;
  DateTime get firstDay => _firstDay;
  DateTime get lastDay => _lastDay;
  PageController get pageController => _pageController;

  //ON CHANGE

  final RxBool _isLoading = true.obs;

  late Rx<DateTime> _focusedDay;
  late Rx<DateTime> _selectedDay;
  late RxInt _selectedPage;

  bool get isLoading => _isLoading.value;
  DateTime get focusedDay => _focusedDay.value;
  DateTime get selectedDay => _selectedDay.value;
  int get selectedPage => _selectedPage.value;

  set focusedDay(DateTime value) => _focusedDay.value = value;
  set selectedDay(DateTime value) => _selectedDay.value = value;
  set selectedPage(int value) => _selectedPage.value = value;

  @override
  void onInit() async {
    super.onInit();
    getInit();

    if (!timetableProvider.isExist) {
      await timetableProvider.getGroupID();
      await timetableProvider.fetchData();
    }
    _timetable = timetableProvider.timetable;
    _isLoading.value = false;
  }

  void getInit() {
    _focusedDay = DateTime.now().obs;
    _selectedDay = DateTime.now().obs;
    _selectedPage = DateTime.now().difference(selectedDay).inDays.obs;
  }

  void getListDays(Data data) {
    final dataJson = data.toJson();
    for (var day in dataJson.values) {
      getListLessons(day);
    }
  }

  List<LessonCard> getListLessons(List<dynamic> data) {
    final List<LessonCard> lessons = [];

    for (var subject in data) {
      final timeStart =
          ScheduleHelper.schoolTimesStart.keys.toList()[data.indexOf(subject)];
      final timeEnd =
          ScheduleHelper.schoolTimesEnd.keys.toList()[data.indexOf(subject)];
      final lesson = LessonCard(
        subject: subject['subject']!,
        timeStart: timeStart,
        timeEnd: timeEnd,
        room: subject['room']!,
        teacher: subject['teacher']!,
      );
      lessons.add(lesson);
    }
    return lessons;
  }
}

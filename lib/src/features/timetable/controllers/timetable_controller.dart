import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/timetable/models/lesson_card_model.dart';
import 'package:rikedu/src/features/timetable/models/timetable_modal.dart';
import 'package:rikedu/src/features/timetable/providers/timetable_provider.dart';
import 'package:rikedu/src/utils/helpers/schedule_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class TimetableController extends GetxController {
  final timetableProvider = Provider.of<TimetableProvider>(Get.context!);

  //CONST
  Timetable _timetable = Timetable.defaultTimetable();

  final CalendarFormat _calendarFormat = CalendarFormat.week;
  final PageController _pageController = PageController(
      initialPage: DateTime.now().difference(DateTime.now()).inDays);

  final DateTime _firstDay = DateTime.utc(2023, 02, 01);
  final DateTime _lastDay = DateTime.utc(2023, 07, 15);

  final double _textSizeDayOfWeek = 12.0;
  final double _textSizeDay = 25.0;
  final double _textSizeHeader = 40.0;
  final double _textSizeSubHeader = 16.0;
  final double _sizeHeightRowCalendar = 50.0;
  final double _sizeHeightDayOfWeekCalendar = 20.0;

  final Color _todayColorCalendar =
      Theme.of(Get.context!).colorScheme.secondary;
  final Color _dayOfWeekColorCalendar =
      Theme.of(Get.context!).colorScheme.onBackground;
  final Color _selectedColorCalendar =
      Theme.of(Get.context!).colorScheme.primary;
  final Color _headerColorCalendar =
      Theme.of(Get.context!).colorScheme.onBackground;
  final Color _disabledColorCalendar = Theme.of(Get.context!).colorScheme.scrim;
  final Color _outsideColorCalendar =
      Theme.of(Get.context!).colorScheme.surface;
  final Color _defaultColorCalendar =
      Theme.of(Get.context!).colorScheme.onBackground;
  final Color _cardColorCalendar =
      Theme.of(Get.context!).colorScheme.primaryContainer;
  final Color _onCardColorCalendar =
      Theme.of(Get.context!).colorScheme.onSurface;

  Timetable get timetable => _timetable;
  CalendarFormat get calendarFormat => _calendarFormat;
  DateTime get firstDay => _firstDay;
  DateTime get lastDay => _lastDay;
  PageController get pageController => _pageController;

  Color get todayColorCalendar => _todayColorCalendar;
  Color get dayOfWeekColorCalendar => _dayOfWeekColorCalendar;
  Color get selectedColorCalendar => _selectedColorCalendar;
  Color get headerColorCalendar => _headerColorCalendar;
  Color get disabledColorCalendar => _disabledColorCalendar;
  Color get outsideColorCalendar => _outsideColorCalendar;
  Color get defaultColorCalendar => _defaultColorCalendar;
  Color get cardColorCalendar => _cardColorCalendar;
  Color get onCardColorCalendar => _onCardColorCalendar;

  double get textSizeDayOfWeek => _textSizeDayOfWeek;
  double get textSizeDay => _textSizeDay;
  double get textSizeHeader => _textSizeHeader;
  double get textSizeSubHeader => _textSizeSubHeader;

  double get sizeHeightRowCalendar => _sizeHeightRowCalendar;
  double get sizeHeightDayOfWeekCalendar => _sizeHeightDayOfWeekCalendar;

  //ON CHANGE
  final RxBool _isLoading = true.obs;
  final RxString _locale = Get.locale.toString().obs;

  late Rx<DateTime> _focusedDay;
  late Rx<DateTime> _selectedDay;
  late RxInt _selectedPage;

  bool get isLoading => _isLoading.value;
  String get locale => _locale.value;
  DateTime get focusedDay => _focusedDay.value;
  DateTime get selectedDay => _selectedDay.value;
  int get selectedPage => _selectedPage.value;

  set locale(String value) => _locale.value = value;
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

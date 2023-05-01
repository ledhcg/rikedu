import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rikedu/src/constants/colors.dart';
import 'package:rikedu/src/features/timetable/controllers/lesson_controller.dart';
import 'package:rikedu/src/features/timetable/models/lesson.dart';
import 'package:rikedu/src/features/timetable/views/widgets/lesson_card.dart';
import 'package:rikedu/src/features/timetable/views/widgets/weekend.dart';
import 'package:table_calendar/table_calendar.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final lessonController = Get.put(LessonController());

  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late PageController _pageController;
  late int _selectedPage;

  late Color _todayColorCalendar;
  late Color _dayOfWeekColorCalendar;
  late Color _selectedColorCalendar;
  late Color _headerColorCalendar;
  late Color _disabledColorCalendar;
  late Color _outsideColorCalendar;
  late Color _defaultColorCalendar;
  late Color _cardColorCalendar;
  late Color _onCardColorCalendar;

  final Map<String, List<Map<String, String>>> lessonsInWeek = {
    "Monday": [
      {"subject": "Биология", "room": "310", "teacher": "Светлана А.К."},
      {"subject": "Математика", "room": "205", "teacher": "Игорь П.В."},
      {"subject": "Математика", "room": "205", "teacher": "Константин В.Л."},
      {"subject": "Физика", "room": "111", "teacher": "Роман А.Д."},
      {"subject": "Химия", "room": "212", "teacher": "Оксана М.С."},
      {"subject": "Химия", "room": "212", "teacher": "Оксана М.С."},
      {"subject": "Русский язык", "room": "110", "teacher": "Александр И.Р."}
    ],
    "Tuesday": [
      {"subject": "История", "room": "110", "teacher": "Елена В.К."},
      {"subject": "Русский язык", "room": "205", "teacher": "Михаил С.К."},
      {"subject": "Биология", "room": "310", "teacher": "Светлана А.К."},
      {
        "subject": "Физическая культура",
        "room": "109",
        "teacher": "Светлана А.К."
      },
      {"subject": "Обществознание", "room": "213", "teacher": "Наталья Д.З."},
      {"subject": "История", "room": "110", "teacher": "Наталья Д.З."},
      {"subject": "Математика", "room": "205", "teacher": "Алексей С.К."}
    ],
    "Wednesday": [
      {"subject": "Физическая культура", "room": "112", "teacher": "Юлия Н.В."},
      {"subject": "Иностранный язык", "room": "205", "teacher": "Юлия Н.В."},
      {"subject": "Литература", "room": "202", "teacher": "Светлана А.К."},
      {"subject": "Математика", "room": "108", "teacher": "Константин В.Л."},
      {"subject": "Информатика", "room": "107", "teacher": "Анастасия А.М."},
      {"subject": "Физика", "room": "113", "teacher": "Людмила А.С."},
      {"subject": "Иностранный язык", "room": "207", "teacher": "Юлия Н.В."}
    ],
    "Thursday": [
      {"subject": "Физика", "room": "111", "teacher": "Роман А.Д."},
      {"subject": "X", "room": "0", "teacher": "X"},
      {"subject": "Химия", "room": "209", "teacher": "Елена С.Т."},
      {"subject": "Русский язык", "room": "101", "teacher": "Александр И.Р."},
      {"subject": "Информатика", "room": "107", "teacher": "Алёна В.Л."},
      {"subject": "География", "room": "111", "teacher": "Василий И.М."},
      {"subject": "Литература", "room": "209", "teacher": "Надежда С.Б."}
    ],
    "Friday": [
      {"subject": "Русский язык", "room": "110", "teacher": "Анна С.И."},
      {"subject": "Математика", "room": "205", "teacher": "Алексей С.К."},
      {"subject": "Математика", "room": "101", "teacher": "Марина Г.Б."},
      {"subject": "География", "room": "109", "teacher": "Марина Г.Б."},
      {"subject": "Информатика", "room": "107", "teacher": "Анастасия А.М."},
      {"subject": "Обществознание", "room": "214", "teacher": "Анна С.И."},
      {"subject": "Литература", "room": "105", "teacher": "Мария А.К."}
    ],
    "Saturday": [],
    "Sunday": []
  };

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _firstDay = DateTime.utc(2023, 02, 01);
    _lastDay = DateTime.utc(2023, 07, 15);
    _calendarFormat = CalendarFormat.week;
    _selectedPage = DateTime.now().difference(_selectedDay).inDays;
    _pageController = PageController(initialPage: _selectedPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _todayColorCalendar = Theme.of(context).colorScheme.secondary;
    _dayOfWeekColorCalendar = Theme.of(context).colorScheme.onBackground;
    _selectedColorCalendar = Theme.of(context).colorScheme.primary;
    _headerColorCalendar = Theme.of(context).colorScheme.onBackground;
    _disabledColorCalendar = Theme.of(context).colorScheme.scrim;
    _outsideColorCalendar = Theme.of(context).colorScheme.surface;
    _defaultColorCalendar = Theme.of(context).colorScheme.onBackground;
    _cardColorCalendar = Theme.of(context).colorScheme.primaryContainer;
    _onCardColorCalendar = Theme.of(context).colorScheme.onSurface;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TableCalendar(
                locale: 'ru_RU',
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedPage = selectedDay.difference(_firstDay).inDays;
                    _pageController.jumpToPage(selectedDay.weekday - 1);
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) => Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          day.day.toString().toUpperCase(),
                          style: TextStyle(
                            color: _defaultColorCalendar,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  outsideBuilder: (context, outsideDay, focusedDay) => Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          outsideDay.day.toString().toUpperCase(),
                          style: TextStyle(
                            color: _outsideColorCalendar,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  disabledBuilder: (context, disabledDay, focusedDay) => Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          disabledDay.day.toString().toUpperCase(),
                          style: TextStyle(
                            color: _disabledColorCalendar,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  dowBuilder: (context, dayOfWeek) {
                    DateTime today = DateTime.now();
                    if (dayOfWeek.day == _selectedDay.day &&
                        dayOfWeek.weekday == _selectedDay.weekday &&
                        dayOfWeek.year == _selectedDay.year) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat('EEE', 'ru_RU')
                                  .format(dayOfWeek)
                                  .toUpperCase(),
                              style: TextStyle(
                                color: _selectedColorCalendar,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (dayOfWeek.day == today.day &&
                        dayOfWeek.weekday == today.weekday &&
                        dayOfWeek.year == today.year) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat('EEE', 'ru_RU')
                                  .format(dayOfWeek)
                                  .toUpperCase(),
                              style: TextStyle(
                                color: _todayColorCalendar,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat('EEE', 'ru_RU')
                                  .format(dayOfWeek)
                                  .toUpperCase(),
                              style: TextStyle(
                                color: _dayOfWeekColorCalendar,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                  todayBuilder: (context, today, focusedDay) => Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          today.day.toString().toUpperCase(),
                          style: TextStyle(
                            color: _todayColorCalendar,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: _todayColorCalendar,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  selectedBuilder: (context, selectDay, focusedDay) => Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          selectDay.day.toString().toUpperCase(),
                          style: TextStyle(
                            color: _selectedColorCalendar,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: _selectedColorCalendar,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonShowsNext: false,
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: _headerColorCalendar,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0, right: 10.0, left: 10.0),
                child: PageView.builder(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  itemCount: lessonsInWeek.length,
                  itemBuilder: (context, index) {
                    return _buildLessonList(
                        lessonController.convertDataToLessons(
                            lessonsInWeek.values.elementAt(index)),
                        index);
                  },
                  onPageChanged: (index) {
                    DateTime newSelectedDay = _selectedDay;
                    if (index == 6) {
                      int difference = 7 - newSelectedDay.weekday;
                      newSelectedDay =
                          newSelectedDay.add(Duration(days: difference));
                    } else {
                      if (newSelectedDay.weekday != index + 1) {
                        newSelectedDay = newSelectedDay.subtract(Duration(
                            days: newSelectedDay.weekday - (index + 1)));
                      }
                    }
                    setState(() {
                      _selectedDay = newSelectedDay;
                      _focusedDay = newSelectedDay;
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLessonList(List<Lesson> lessons, int day) {
    if (day == 5 || day == 6) {
      return WeekendTimetable(
        cardColor: _cardColorCalendar,
        textColor: _onCardColorCalendar,
      );
    }
    return Card(
      color: _cardColorCalendar,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                if (lessons[index].subject == 'X') {
                  return EmptyLessonCard(
                      timeStart: lessons[index].timeStart,
                      timeEnd: lessons[index].timeEnd);
                } else {
                  return LessonCard(
                    subject: lessons[index].subject,
                    room: lessons[index].room,
                    timeStart: lessons[index].timeStart,
                    timeEnd: lessons[index].timeEnd,
                    teacher: lessons[index].teacher,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  // late List<Lesson> _lessons;

  // final Map<String, List<Object>> lessonsByDay = {
  //   "Monday": [
  //     {"subject": "Language", "room": "A1"},
  //     {"subject": "Language", "room": "A1"},
  //     {"subject": "Language", "room": "A1"},
  //     {"subject": "Language", "room": "A1"},
  //     {"subject": "Language", "room": "A1"},
  //     // "Biology",
  //     // "Language",
  //     // "Chemistry",
  //     // "X"
  //   ],
  //   "Tuesday": ["X", "Math", "Math", "Math", "Language"],
  //   "Wednesday": ["History", "Language", "Physics", "Language", "Math"],
  //   "Thursday": ["Chemistry", "Geography", "Physics", "Math", "Language"],
  //   "Friday": ["X", "Math", "Math", "Language", "Biology"],
  //   "Weekend": ["Ngày nghỉ"],
  // };

  final Map<String, List<Map<String, String>>> lessonsInWeek = {
    "Monday": [
      {"subject": "Math", "room": "107"},
      {"subject": "Language", "room": "206"},
      {"subject": "Language", "room": "208"},
      {"subject": "Language", "room": "206"},
      {"subject": "Math", "room": "108"}
    ],
    "Tuesday": [
      {"subject": "Math", "room": "108"},
      {"subject": "Math", "room": "100"},
      {"subject": "Language", "room": "202"},
      {"subject": "X", "room": "0"},
      {"subject": "Language", "room": "207"}
    ],
    "Wednesday": [
      {"subject": "X", "room": "0"},
      {"subject": "Math", "room": "101"},
      {"subject": "Biology", "room": "309"},
      {"subject": "X", "room": "0"},
      {"subject": "Chemistry", "room": "209"}
    ],
    "Thursday": [
      {"subject": "Chemistry", "room": "209"},
      {"subject": "Biology", "room": "309"},
      {"subject": "Language", "room": "207"},
      {"subject": "Math", "room": "101"},
      {"subject": "Physics", "room": "112"}
    ],
    "Friday": [
      {"subject": "Math", "room": "105"},
      {"subject": "History", "room": "318"},
      {"subject": "Geography", "room": "316"},
      {"subject": "Language", "room": "203"},
      {"subject": "Physics", "room": "112"}
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
    _lastDay = DateTime.utc(2023, 17, 15);
    _calendarFormat = CalendarFormat.week;
    _selectedPage = DateTime.now().difference(_firstDay).inDays;
    _pageController = PageController(initialPage: _selectedPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                locale: 'ru_RU',
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
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
                  markerBuilder: (context, day, events) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        events.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                            decoration: const BoxDecoration(
                              color: rikePrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                headerStyle: const HeaderStyle(
                  formatButtonShowsNext: false,
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                rowHeight: 70,
                eventLoader: (day) {
                  if (day.weekday == DateTime.monday) {
                    return lessonController.convertDataToLessons(
                        lessonsInWeek.values.elementAt(0));
                  } else if (day.weekday == DateTime.tuesday) {
                    return lessonController.convertDataToLessons(
                        lessonsInWeek.values.elementAt(1));
                  } else if (day.weekday == DateTime.wednesday) {
                    return lessonController.convertDataToLessons(
                        lessonsInWeek.values.elementAt(2));
                  } else if (day.weekday == DateTime.thursday) {
                    return lessonController.convertDataToLessons(
                        lessonsInWeek.values.elementAt(3));
                  } else if (day.weekday == DateTime.friday) {
                    return lessonController.convertDataToLessons(
                        lessonsInWeek.values.elementAt(4));
                  }
                  return [];
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageView.builder(
                  controller: _pageController,
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
      return const WeekendTimetable();
    }
    return ListView.builder(
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
              timeEnd: lessons[index].timeEnd);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/news/views/widgets/image_container_widget.dart';
import 'package:rikedu/src/features/settings/providers/locale_provider.dart';
import 'package:rikedu/src/features/timetable/controllers/timetable_controller.dart';
import 'package:rikedu/src/features/timetable/models/lesson_card_model.dart';
import 'package:rikedu/src/features/timetable/views/widgets/lesson_card_widget.dart';
import 'package:rikedu/src/features/timetable/views/widgets/weekend.dart';
import 'package:skeletons/skeletons.dart';
import 'package:table_calendar/table_calendar.dart';

class TimetablePage extends GetView<TimetableController> {
  TimetablePage({super.key});

  late Color cardColorCalendar;
  late Color onCardColorCalendar;

  @override
  Widget build(BuildContext context) {
    String locale = context.watch<LocaleProvider>().locale.toString();
    double textSizeDayOfWeek = 12.0;
    double textSizeDay = 25.0;
    double textSizeHeader = 40.0;
    double textSizeSubHeader = 16.0;
    double sizeHeightRowCalendar = 50.0;
    double sizeHeightDayOfWeekCalendar = 20.0;

    Color todayColorCalendar = Theme.of(context).colorScheme.secondary;
    Color dayOfWeekColorCalendar = Theme.of(context).colorScheme.onBackground;
    Color selectedColorCalendar = Theme.of(context).colorScheme.primary;
    Color headerColorCalendar = Theme.of(context).colorScheme.onBackground;
    Color disabledColorCalendar = Theme.of(context).colorScheme.scrim;
    Color outsideColorCalendar = Theme.of(context).colorScheme.surface;
    Color defaultColorCalendar = Theme.of(context).colorScheme.onBackground;
    cardColorCalendar = Theme.of(context).colorScheme.primaryContainer;
    onCardColorCalendar = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Skeleton(
          isLoading: controller.isLoading,
          skeleton: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 200,
                                        height: 20,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        padding: EdgeInsets.only(bottom: 10)),
                                  ),
                                ],
                              ),
                              const SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 250,
                                    height: 40,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    padding: EdgeInsets.only(bottom: 15)),
                              ),
                            ],
                          ),
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: 50,
                              height: 50,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: const [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 15,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 15,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 15,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 15,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 15,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 15,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 15,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 30,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    padding: EdgeInsets.only(bottom: 10)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                        child: Container(
                          // color: cardColorCalendar,
                          padding: const EdgeInsets.all(25),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      width: double.infinity,
                                      height: 90,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TableCalendar(
                    locale: locale,
                    firstDay: controller.firstDay,
                    lastDay: controller.lastDay,
                    focusedDay: controller.focusedDay,
                    calendarFormat: controller.calendarFormat,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    selectedDayPredicate: (day) {
                      return isSameDay(controller.selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.selectedDay = selectedDay;
                      controller.focusedDay = focusedDay;
                      controller.selectedPage =
                          selectedDay.difference(controller.firstDay).inDays;
                      controller.pageController
                          .jumpToPage(selectedDay.weekday - 1);
                    },
                    onPageChanged: (focusedDay) {
                      controller.focusedDay = focusedDay;
                    },
                    rowHeight: sizeHeightRowCalendar,
                    daysOfWeekHeight: sizeHeightDayOfWeekCalendar,
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) => Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              day.day.toString().toUpperCase(),
                              style: TextStyle(
                                color: defaultColorCalendar,
                                fontSize: textSizeDay,
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
                      outsideBuilder: (context, outsideDay, focusedDay) =>
                          Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              outsideDay.day.toString().toUpperCase(),
                              style: TextStyle(
                                color: outsideColorCalendar,
                                fontSize: textSizeDay,
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
                      disabledBuilder: (context, disabledDay, focusedDay) =>
                          Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              disabledDay.day.toString().toUpperCase(),
                              style: TextStyle(
                                color: disabledColorCalendar,
                                fontSize: textSizeDay,
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
                        if (dayOfWeek.day == controller.selectedDay.day &&
                            dayOfWeek.weekday ==
                                controller.selectedDay.weekday &&
                            dayOfWeek.year == controller.selectedDay.year) {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  DateFormat('EEE', locale)
                                      .format(dayOfWeek)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: selectedColorCalendar,
                                    fontSize: textSizeDayOfWeek,
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
                                  DateFormat('EEE', locale)
                                      .format(dayOfWeek)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: todayColorCalendar,
                                    fontSize: textSizeDayOfWeek,
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
                                  DateFormat('EEE', locale)
                                      .format(dayOfWeek)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: dayOfWeekColorCalendar,
                                    fontSize: textSizeDayOfWeek,
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
                                color: todayColorCalendar,
                                fontSize: textSizeDay,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: todayColorCalendar,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      selectedBuilder: (context, selectDay, focusedDay) =>
                          Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              selectDay.day.toString().toUpperCase(),
                              style: TextStyle(
                                color: selectedColorCalendar,
                                fontSize: textSizeDay,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: selectedColorCalendar,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      headerTitleBuilder: (context, day) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${controller.timetable.group} - ${DateFormat.yMMMM(locale).format(day).toUpperCase()}",
                                      style: TextStyle(
                                        color: defaultColorCalendar,
                                        fontSize: textSizeSubHeader,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Timetable'.tr,
                                  style: TextStyle(
                                    color: defaultColorCalendar,
                                    fontSize: textSizeHeader,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            ImageContainer(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(0),
                              borderRadius: 25,
                              isLoading: false,
                              imageUrl: controller.student.avatarUrl,
                            ),
                          ],
                        ),
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      formatButtonShowsNext: false,
                      formatButtonVisible: false,
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: const ClampingScrollPhysics(),
                    itemCount: controller.timetable.data.toJson().values.length,
                    itemBuilder: (context, index) {
                      final days = controller.timetable.data.toJson();
                      return _buildLessonList(
                          controller
                              .getListLessons(days.values.elementAt(index)),
                          index);
                    },
                    onPageChanged: (index) {
                      DateTime newSelectedDay = controller.selectedDay;
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
                      controller.selectedDay = newSelectedDay;
                      controller.focusedDay = newSelectedDay;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonList(List<LessonCard> lessons, int day) {
    if (day == 5 || day == 6) {
      return WeekendTimetable(
        cardColor: cardColorCalendar,
        textColor: onCardColorCalendar,
      );
    }
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
      child: Container(
        color: cardColorCalendar,
        padding: const EdgeInsets.all(25),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              if (lessons[index].subject == 'X') {
                return EmptyLessonCard(
                    timeStart: lessons[index].timeStart,
                    timeEnd: lessons[index].timeEnd);
              } else {
                return LessonCardWidget(
                  subject: lessons[index].subject,
                  room: lessons[index].room,
                  timeStart: lessons[index].timeStart,
                  timeEnd: lessons[index].timeEnd,
                  teacherImage: lessons[index].teacherImage,
                  teacherName: lessons[index].teacherName,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

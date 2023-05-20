import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rikedu/src/features/timetable/controllers/timetable_controller.dart';
import 'package:rikedu/src/features/timetable/models/lesson_card_model.dart';
import 'package:rikedu/src/features/timetable/views/widgets/lesson_card_widget.dart';
import 'package:rikedu/src/features/timetable/views/widgets/weekend.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class TimetablePage extends GetView<TimetableController> {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => controller.isLoading
            ? const LoadingWidget()
            : Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TableCalendar(
                        locale: controller.locale,
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
                          controller.selectedPage = selectedDay
                              .difference(controller.firstDay)
                              .inDays;
                          controller.pageController
                              .jumpToPage(selectedDay.weekday - 1);
                        },
                        onPageChanged: (focusedDay) {
                          controller.focusedDay = focusedDay;
                        },
                        rowHeight: controller.sizeHeightRowCalendar,
                        daysOfWeekHeight:
                            controller.sizeHeightDayOfWeekCalendar,
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) => Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  day.day.toString().toUpperCase(),
                                  style: TextStyle(
                                    color: controller.defaultColorCalendar,
                                    fontSize: controller.textSizeDay,
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
                                    color: controller.outsideColorCalendar,
                                    fontSize: controller.textSizeDay,
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
                                    color: controller.disabledColorCalendar,
                                    fontSize: controller.textSizeDay,
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
                                      DateFormat('EEE', controller.locale)
                                          .format(dayOfWeek)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: controller.selectedColorCalendar,
                                        fontSize: controller.textSizeDayOfWeek,
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
                                      DateFormat('EEE', controller.locale)
                                          .format(dayOfWeek)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: controller.todayColorCalendar,
                                        fontSize: controller.textSizeDayOfWeek,
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
                                      DateFormat('EEE', controller.locale)
                                          .format(dayOfWeek)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color:
                                            controller.dayOfWeekColorCalendar,
                                        fontSize: controller.textSizeDayOfWeek,
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
                                    color: controller.todayColorCalendar,
                                    fontSize: controller.textSizeDay,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: controller.todayColorCalendar,
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
                                    color: controller.selectedColorCalendar,
                                    fontSize: controller.textSizeDay,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: controller.selectedColorCalendar,
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
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${controller.timetable.group} - ${DateFormat.yMMMM(controller.locale).format(day).toUpperCase()}",
                                          style: TextStyle(
                                            color:
                                                controller.defaultColorCalendar,
                                            fontSize:
                                                controller.textSizeSubHeader,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Timetable'.tr,
                                      style: TextStyle(
                                        color: controller.defaultColorCalendar,
                                        fontSize: controller.textSizeHeader,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(126.0),
                                          child: Image.asset(
                                              FilesConst.AVATAR_DEFAULT)),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                )
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
                        itemCount:
                            controller.timetable.data.toJson().values.length,
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
    );
  }

  Widget _buildLessonList(List<LessonCard> lessons, int day) {
    if (day == 5 || day == 6) {
      return WeekendTimetable(
        cardColor: controller.cardColorCalendar,
        textColor: controller.onCardColorCalendar,
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
        color: controller.cardColorCalendar,
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
                  teacher: lessons[index].teacher,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

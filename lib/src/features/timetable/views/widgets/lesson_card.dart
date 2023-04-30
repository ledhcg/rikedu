import 'package:flutter/material.dart';
import 'package:rikedu/src/constants/colors.dart';

class LessonCard extends StatelessWidget {
  final String subject;
  final String room;
  final String timeStart;
  final String timeEnd;

  const LessonCard({
    Key? key,
    required this.subject,
    required this.room,
    required this.timeStart,
    required this.timeEnd,
  }) : super(key: key);

  // static Color getColorByType(String lessonType) {
  //   if (lessonType.contains('лк') || lessonType.contains('лек')) {
  //     return AppTheme.colors.colorful01;
  //   } else if (lessonType.contains('лб') || lessonType.contains('лаб')) {
  //     return AppTheme.colors.colorful07;
  //   } else if (lessonType.contains('с/р')) {
  //     return AppTheme.colors.colorful02;
  //   } else {
  //     return AppTheme.colors.colorful03;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: rikePrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 75),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    timeStart,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    timeEnd,
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    room,
                  ),
                ],
              ),
            ),
            Container(),
            Container(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: rikePrimaryColor),
                height: 24,
                // width: 10 * 7,
                child: Text(room),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyLessonCard extends StatelessWidget {
  final String timeStart;
  final String timeEnd;

  const EmptyLessonCard({
    Key? key,
    required this.timeStart,
    required this.timeEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: rikePrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 55),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    timeStart,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    timeEnd,
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 25,
                  height: 1,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 25,
                  height: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

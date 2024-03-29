import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/news/views/widgets/image_container_widget.dart';

class LessonCardWidget extends StatelessWidget {
  final String subject;
  final String room;
  final String timeStart;
  final String timeEnd;
  final String teacherImage;
  final String teacherName;

  const LessonCardWidget({
    Key? key,
    required this.subject,
    required this.room,
    required this.timeStart,
    required this.timeEnd,
    required this.teacherImage,
    required this.teacherName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 75),
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        timeStart,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        timeEnd,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          subject,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            ImageContainer(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.all(0),
                              borderRadius: 10,
                              isLoading: false,
                              imageUrl: teacherImage,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              teacherName,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      height: 24,
                      // width: 10 * 7,
                      child: Text(
                        'каб. $room'.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 45),
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        timeStart,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        timeEnd,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Free time'.tr,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

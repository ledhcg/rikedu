import 'package:equatable/equatable.dart';

class LessonCard extends Equatable {
  const LessonCard({
    required this.subject,
    required this.timeStart,
    required this.timeEnd,
    required this.room,
    required this.teacherImage,
    required this.teacherName,
  });

  final String subject;
  final String timeStart;
  final String timeEnd;
  final String room;
  final String teacherImage;
  final String teacherName;

  @override
  List<Object?> get props =>
      [subject, timeStart, timeEnd, room, teacherImage, teacherName];
}

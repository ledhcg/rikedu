import 'package:equatable/equatable.dart';

class LessonCard extends Equatable {
  const LessonCard({
    required this.subject,
    required this.timeStart,
    required this.timeEnd,
    required this.room,
    required this.teacher,
  });

  final String subject;
  final String timeStart;
  final String timeEnd;
  final String room;
  final String teacher;

  @override
  List<Object?> get props => [subject, timeStart, timeEnd, room, teacher];
}
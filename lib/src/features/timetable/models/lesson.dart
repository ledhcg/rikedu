import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  const Lesson({
    required this.subject,
    required this.timeStart,
    required this.timeEnd,
    required this.room,
  });

  final String subject;
  final String timeStart;
  final String timeEnd;
  final String room;

  @override
  List<Object?> get props => [subject, timeStart, timeEnd, room];
}

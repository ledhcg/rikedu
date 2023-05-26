// To parse this JSON data, do
//
//     final exercise = exerciseFromJson(jsonString);

import 'dart:convert';

class Exercise {
  final String id;
  final String subjectName;
  final String topic;
  final String note;
  final String file;
  final DateTime deadline;
  final int isSubmit;
  final int mark;
  final String review;

  Exercise({
    required this.id,
    required this.subjectName,
    required this.topic,
    required this.note,
    required this.file,
    required this.deadline,
    required this.isSubmit,
    required this.mark,
    required this.review,
  });

  factory Exercise.defaultExercise() => Exercise(
        id: '',
        subjectName: '',
        topic: '',
        note: '',
        file: '',
        deadline: DateTime.now(),
        isSubmit: 0,
        mark: 0,
        review: '',
      );

  factory Exercise.fromRawJson(String str) =>
      Exercise.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        subjectName: json["subject_name"],
        topic: json["topic"],
        note: json["note"],
        file: json["file"] ?? "",
        deadline: DateTime.parse(json["deadline"]),
        isSubmit: json["is_submit"],
        mark: json["mark"] ?? 0,
        review: json["review"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_name": subjectName,
        "topic": topic,
        "note": note,
        "file": file,
        "deadline":
            "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "is_submit": isSubmit,
        "mark": mark,
        "review": review,
      };
}

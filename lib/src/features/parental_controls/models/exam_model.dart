// To parse this JSON data, do
//
//     final exam = examFromJson(jsonString);

import 'dart:convert';

class Exam {
  final String id;
  final String subjectName;
  final String title;
  final String description;
  final int mark;
  final String review;

  Exam({
    required this.id,
    required this.subjectName,
    required this.title,
    required this.description,
    required this.mark,
    required this.review,
  });

  factory Exam.defaultExam() => Exam(
        id: '',
        subjectName: '',
        title: '',
        description: '',
        mark: 0,
        review: '',
      );

  factory Exam.fromRawJson(String str) => Exam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        subjectName: json["subject_name"],
        title: json["title"],
        description: json["description"],
        mark: json["mark"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_name": subjectName,
        "title": title,
        "description": description,
        "mark": mark,
        "review": review,
      };
}

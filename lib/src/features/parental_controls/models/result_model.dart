// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

class Result {
  final String id;
  final String subjectName;
  final int exam1;
  final int exam2;
  final int exam3;
  final int active;
  final int finalExam;
  final String review;

  Result({
    required this.id,
    required this.subjectName,
    required this.exam1,
    required this.exam2,
    required this.exam3,
    required this.active,
    required this.finalExam,
    required this.review,
  });

  factory Result.defaultResult() => Result(
        id: '',
        subjectName: '',
        exam1: 0,
        exam2: 0,
        exam3: 0,
        active: 0,
        finalExam: 0,
        review: '',
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        subjectName: json["subject_name"],
        exam1: json["exam_1"],
        exam2: json["exam_2"],
        exam3: json["exam_3"],
        active: json["active"],
        finalExam: json["final_exam"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_name": subjectName,
        "exam_1": exam1,
        "exam_2": exam2,
        "exam_3": exam3,
        "active": active,
        "final_exam": finalExam,
        "review": review,
      };
}

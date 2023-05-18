import 'dart:convert';

class Group {
  final String id;
  final String name;
  final int grade;
  final String time;
  final String description;

  Group({
    required this.id,
    required this.name,
    required this.grade,
    required this.time,
    required this.description,
  });

  factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        grade: json["grade"],
        time: json["time"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "grade": grade,
        "time": time,
        "description": description,
      };
}

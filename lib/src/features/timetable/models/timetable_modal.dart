import 'dart:convert';

class Timetable {
  final String id;
  final String group;
  final Data data;

  Timetable({
    required this.id,
    required this.group,
    required this.data,
  });

  factory Timetable.defaultTimetable() => Timetable(
        id: '',
        group: '',
        data: Data.defaultData(),
      );

  factory Timetable.fromRawJson(String str) =>
      Timetable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        id: json["id"],
        group: json["group"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group": group,
        "data": data.toJson(),
      };
}

class Data {
  final List<Lesson> monday;
  final List<Lesson> tuesday;
  final List<Lesson> wednesday;
  final List<Lesson> thursday;
  final List<Lesson> friday;
  final List<dynamic> saturday;
  final List<dynamic> sunday;

  Data({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory Data.defaultData() => Data(
        monday: [],
        tuesday: [],
        wednesday: [],
        thursday: [],
        friday: [],
        saturday: [],
        sunday: [],
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        monday:
            List<Lesson>.from(json["Monday"].map((x) => Lesson.fromJson(x))),
        tuesday:
            List<Lesson>.from(json["Tuesday"].map((x) => Lesson.fromJson(x))),
        wednesday:
            List<Lesson>.from(json["Wednesday"].map((x) => Lesson.fromJson(x))),
        thursday:
            List<Lesson>.from(json["Thursday"].map((x) => Lesson.fromJson(x))),
        friday:
            List<Lesson>.from(json["Friday"].map((x) => Lesson.fromJson(x))),
        saturday: [],
        sunday: [],
      );

  Map<String, dynamic> toJson() => {
        "Monday": List<dynamic>.from(monday.map((x) => x.toJson())),
        "Tuesday": List<dynamic>.from(tuesday.map((x) => x.toJson())),
        "Wednesday": List<dynamic>.from(wednesday.map((x) => x.toJson())),
        "Thursday": List<dynamic>.from(thursday.map((x) => x.toJson())),
        "Friday": List<dynamic>.from(friday.map((x) => x.toJson())),
        "Saturday": [],
        "Sunday": [],
      };
}

class Lesson {
  final String subject;
  final String room;
  final String teacher;

  Lesson({
    required this.subject,
    required this.room,
    required this.teacher,
  });

  factory Lesson.fromRawJson(String str) => Lesson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        subject: json["subject"],
        room: json["room"],
        teacher: json["teacher"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "room": room,
        "teacher": teacher,
      };
}

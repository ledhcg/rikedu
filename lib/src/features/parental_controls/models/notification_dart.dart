import 'dart:convert';

class Notifi {
  final String id;
  final String title;
  final String message;
  final String toUserId;
  final String from;
  final int isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notifi({
    required this.id,
    required this.title,
    required this.message,
    required this.toUserId,
    required this.from,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notifi.defaultNotifi() => Notifi(
        id: '',
        title: '',
        message: '',
        toUserId: '',
        from: '',
        isRead: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory Notifi.fromRawJson(String str) => Notifi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notifi.fromJson(Map<String, dynamic> json) => Notifi(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        toUserId: json["to_user_id"],
        from: json["from"],
        isRead: json["is_read"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "to_user_id": toUserId,
        "from": from,
        "is_read": isRead,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

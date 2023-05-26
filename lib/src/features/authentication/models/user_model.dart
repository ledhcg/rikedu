import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String avatarUrl;
  final String gender;
  final DateTime dateOfBirth;
  final String phone;
  final String address;
  final String department;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.address,
    required this.department,
  });

  factory User.defaultUser() => User(
        id: '',
        username: '',
        email: '',
        fullName: '',
        avatarUrl: '',
        gender: '',
        dateOfBirth: DateTime.now(),
        phone: '',
        address: '',
        department: '',
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        fullName: json["full_name"],
        avatarUrl: json["avatar_url"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        phone: json["phone"],
        address: json["address"],
        department: json["department"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "full_name": fullName,
        "avatar_url": avatarUrl,
        "gender": gender,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "phone": phone,
        "address": address,
        "department": department,
      };
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String avatarUrl;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
    );
  }
}

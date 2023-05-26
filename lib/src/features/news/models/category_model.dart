// To parse this JSON data, do
//
//     final postCategory = postCategoryFromJson(jsonString);

import 'dart:convert';

class PostCategory {
  final String id;
  final String title;
  final String slug;
  final String description;

  PostCategory({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
  });

  factory PostCategory.defaultPost() => PostCategory(
        id: '',
        title: '',
        slug: '',
        description: '',
      );

  factory PostCategory.fromRawJson(String str) =>
      PostCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "description": description,
      };
}

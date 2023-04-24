import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String emailAuthor;
  String postContent;
  DateTime createdAt;

  Post({required this.emailAuthor, required this.postContent, required this.createdAt});

  Map<String, dynamic> toJson() => {"emailAuthor": emailAuthor, "postContent": postContent, "createdAt": createdAt};

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      emailAuthor: json['emailAuthor'],
      postContent: json['postContent'],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

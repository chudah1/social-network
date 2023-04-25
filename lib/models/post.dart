import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String emailAuthor;
  String postContent;
  DateTime createdAt;

  Post(
      {required this.emailAuthor,
      required this.postContent,
      required this.createdAt});

/// This function converts an object's properties to a JSON format.
  Map<String, dynamic> toJson() => {
        "emailAuthor": emailAuthor,
        "postContent": postContent,
        "createdAt": createdAt
      };

/// This is a factory function in Dart that creates a Post object from a JSON object.
/// 
/// Args:
///   json (Map<String, dynamic>): A JSON object that contains the data to be used to create a Post
/// object.
/// 
/// Returns:
///   A `Post` object is being returned. The `fromJson` method is used to convert a JSON object into a
/// `Post` object. The JSON object is passed as a parameter to the method and its properties are used to
/// initialize the properties of the `Post` object.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      emailAuthor: json['emailAuthor'],
      postContent: json['postContent'],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

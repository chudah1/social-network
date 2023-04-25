import 'package:flutter/material.dart';
import "package:social_network/models/post.dart";

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
/// This is the build method of a `PostCard` widget in Flutter. It returns a `SizedBox` widget with a
/// width of 80, containing a `Card` widget with a rounded border, elevation, and padding. The `Card`
/// widget contains a `Column` widget with two children: a `Row` widget with a `CircleAvatar` and a
/// `Text` widget displaying the email of the author of the post, and a `Text` widget displaying the
/// content of the post. The values for the email and post content are passed in through the `post`
/// parameter.
    return SizedBox(
      width: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.png")),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${post.emailAuthor}")
                ],
              ),
              SizedBox(height: 20.0),
              Text(post.postContent),
            ],
          ),
        ),
      ),
    );
  }
}

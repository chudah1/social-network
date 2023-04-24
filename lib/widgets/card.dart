import 'package:flutter/material.dart';
import "package:social_network/models/post.dart";

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png")
              ),
              SizedBox(width: 5,),
              Text("${post.emailAuthor}")
              ],)
              ,
              SizedBox(height: 20.0),
              Text(post.postContent),
            ],
          ),
        ),
      ),
    );
  }
}

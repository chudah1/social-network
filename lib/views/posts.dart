import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_network/controllers/post_controller.dart';

class PostData extends StatefulWidget {
  const PostData({super.key});

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: PostController().getAllPosts(),
        builder: ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.active) {
            FirebaseFirestore.instance.collection("profile").snapshots().listen((querySnapshot) {
              List<String> userEmails = [];
              querySnapshot.docs.forEach((doc) {
                String userEmail = doc.data()["email"];
                print(userEmail);
                userEmails.add(userEmail);
              });

              final recentDoc = querySnapshot.docs.first;
              final postAuthor = recentDoc["name"];
              // PostController().sendMails(userEmails, postAuthor);
            });
          }
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Column(
              children: [Text(data["postContent"])],
            );
          }).toList()
          );
        }));
  }
}

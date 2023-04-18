import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:social_network/models/post.dart';

class PostController {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");

  Future<String> createPost(Post post) async {
    Map<String, dynamic> requestJson = post.toJson();
    await posts.add(requestJson);
    return "success";
  }

  Stream<QuerySnapshot> getAllPosts() {
    return posts.orderBy("createdAt", descending: true).snapshots();
  }

  Future<void> sendMails(List<String> userEmails) {
    String username = "";
    String password = "";

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add('destination@example.com')
      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      ..subject = 'New Post at the Ashesi Network ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_network/models/post.dart';

class PostController {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");

  Future<bool> createPost(Post post) async {
    try {
      Map<String, dynamic> requestJson = post.toJson();
      await posts.add(requestJson);
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getAllPosts() {
    return posts.orderBy("createdAt", descending: true).snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_network/models/post.dart';

class PostController {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");

/// The function creates a post by adding its JSON representation to a collection and returns a boolean
/// indicating success or failure.
/// 
/// Args:
///   post (Post): The `post` parameter is an instance of the `Post` class, which contains the data for
/// a single post. The `toJson()` method of the `Post` class is called to convert the post data into a
/// JSON format, which is then used to create a new document in the `posts
/// 
/// Returns:
///   a `Future<bool>`. It returns `true` if the post is successfully added to the database, and `false`
/// if there is an error.
  Future<bool> createPost(Post post) async {
    try {
      Map<String, dynamic> requestJson = post.toJson();
      await posts.add(requestJson);
      return true;
    } catch (e) {
      return false;
    }
  }

/// This function returns a stream of all posts ordered by their creation time in descending order.
/// 
/// Returns:
///   A stream of QuerySnapshot objects is being returned. The QuerySnapshot objects contain the results
/// of a query to the "posts" collection in a Firestore database, ordered by the "createdAt" field in
/// descending order. The stream will emit new QuerySnapshot objects whenever the data in the "posts"
/// collection changes.
  Stream<QuerySnapshot> getAllPosts() {
    return posts.orderBy("createdAt", descending: true).snapshots();
  }
}

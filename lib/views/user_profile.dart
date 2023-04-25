import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_network/controllers/post_controller.dart';
import 'package:social_network/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:social_network/models/post.dart';
import 'package:social_network/models/user.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/widgets/card.dart';

class UserPage extends StatelessWidget {
  String idNumber;
  UserPage({required this.idNumber});

  @override
  Widget build(BuildContext context) {
    final userController = UserController();
    String content = "";

/// `userController.checkAuth(context);` is checking if the user is authenticated. If the user is not
/// authenticated, it will redirect the user to the login page.
    userController.checkAuth(context);

    /// The function "createPost" takes in a context parameter.
    /// 
    /// Args:
    ///   context: It is likely that `context` refers to the context or environment in which the
    /// `createPost` function is being called. This could include information such as the current user,
    /// any relevant session data, or other variables that may be needed to create a new post. Without
    /// more information about the code and
    createPost(context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                width: 70,
                alignment: Alignment.center,
                constraints:
                    const BoxConstraints(maxHeight: 250, maxWidth: 100),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: "Create Post",
                              ),
                              onChanged: (value) {
                                content = value;
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              String? userEmail =
                                  auth.FirebaseAuth.instance.currentUser!.email;
                              Post post = Post(
                                  emailAuthor: userEmail!,
                                  postContent: content,
                                  createdAt: DateTime.now());
                              final success =
                                  (await (PostController().createPost(post)));
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.purpleAccent,
                                      title:
                                          Text(success ? "Success" : "Failure"),
                                      content: Text(success
                                          ? "Post created successfully"
                                          : "Failed to create Post"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("OK"))
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.app_registration),
                            label: const Text("Submit"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              backgroundColor: const Color(0xff764abc),
                              foregroundColor: Colors.black,
                            ),
                          )
                        ])),
              ),
            );
          });
    }

    searchFriends(context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                width: 40,
                alignment: Alignment.center,
                constraints: const BoxConstraints(maxHeight: 90),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                            hintText: "search by id",
                            prefixIcon: Icon(Icons.search)),
                        onSubmitted: (value) => context.goNamed("friendProfile",
                            params: {"idNumber": value}),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("AshNetwork"),
          backgroundColor: const Color(0xff764abc),
        ),
        drawer: Drawer(
          child: FutureBuilder<User>(
              future: userController.getUser(idNumber),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Color(0xff764abc),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                final userObj = snapshot.data!;
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(userObj.name),
                      accountEmail: Text(userObj.email),
                      currentAccountPicture:
                          Image.asset("assets/images/avatar_image.jpg"),
                      decoration: const BoxDecoration(
                        color: Color(0xff764abc),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.school,
                      ),
                      title: Text(userObj.major),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.movie,
                      ),
                      title: Text(userObj.movie),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.food_bank,
                      ),
                      title: Text(userObj.food),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.date_range,
                      ),
                      title: Text("Class ${userObj.yearGroup}"),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.date_range,
                      ),
                      title: Text(userObj.dateOfBirth),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.movie,
                      ),
                      title: Text(userObj.movie),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                      ),
                      title: Text(
                          userObj.campusResidence ? "On Campus" : "Off Campus"),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.edit,
                      ),
                      title: const Text("Edit Profile"),
                      onTap: () {
                        context.goNamed("edit", params: {"idNumber": idNumber});
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.post_add,
                      ),
                      title: const Text("Create Post"),
                      onTap: () {
                        createPost(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.search,
                      ),
                      title: const Text("Search Friends"),
                      onTap: () {
                        searchFriends(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                      ),
                      title: const Text("Logout"),
                      onTap: () async {
                        await auth.FirebaseAuth.instance.signOut();
                        context.goNamed("login");
                      },
                    )
                  ],
                );
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20),
          /// The above code is creating a StreamBuilder widget that listens to a stream of
          /// QuerySnapshot data from a PostController. It then builds a ListView of PostCard widgets
          /// using the data retrieved from the stream. The code also handles cases where the connection
          /// is waiting or there is an error in the stream.
          child: StreamBuilder<QuerySnapshot>(
            stream: PostController().getAllPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("error: ${snapshot.error}");
              }
              final List<Post> posts = snapshot.data!.docs.map((doc) {
                return Post(
                    emailAuthor: doc["emailAuthor"],
                    postContent: doc["postContent"],
                    createdAt: doc["createdAt"].toDate());
              }).toList();
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: posts[index]);
                },
              );
            },
          ),
        ));
  }
}

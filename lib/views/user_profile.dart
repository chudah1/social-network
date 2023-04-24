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

    userController.checkAuth(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("AshNetwork"),
          backgroundColor: Colors.purpleAccent,
        ),
        drawer: Drawer(
          child: FutureBuilder<User>(
              future: userController.getUser(idNumber),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.purpleAccent,
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
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.school,
                      ),
                      title: Text("Major: ${userObj.major}"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.movie,
                      ),
                      title: Text(userObj.movie),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.food_bank,
                      ),
                      title: Text(userObj.food),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.date_range,
                      ),
                      title: Text("Class ${userObj.yearGroup}"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.date_range,
                      ),
                      title: Text(userObj.dateOfBirth),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.movie,
                      ),
                      title: Text(userObj.movie),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                      ),
                      title: Text(
                          userObj.campusResidence ? "On Campus" : "Off Campus"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.edit,
                      ),
                      title: Text("Edit Profile"),
                      onTap: () {
                        context.goNamed("edit", params: {"idNumber": idNumber});
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.post_add,
                      ),
                      title: Text("Create Post"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                      ),
                      title: Text("Logout"),
                      onTap: () async{
                        await auth.FirebaseAuth.instance.signOut();
                        context.goNamed("login");
                      },
                    )
                  ],
                );
              }),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20),
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
                    emailAuthor: doc["email"],
                    postContent: doc["postContent"],
                    createdAt: doc["createdAt"].toDate()
                );
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

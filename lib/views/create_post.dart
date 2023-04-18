import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:social_network/controllers/post_controller.dart';
import 'package:social_network/models/post.dart';

class PostForm extends StatefulWidget {
  const PostForm({super.key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  final PostController _postController = PostController();

  String _userEmail = "";
  String _postContent = "";

  void _createPost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newPost = Post(emailAuthor: _userEmail, postContent: _postContent, createdAt: DateTime.now());
      _postController.createPost(newPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                width: 450,
                margin: const EdgeInsets.all(50.0),
                color: Colors.amberAccent,
                child: Form(
                    key: _formKey,
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: TextFormField(
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Please enter email'
                                    : null;
                              },
                              onSaved: (newValue) => _userEmail = newValue!,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your email",
                                  label: Text("Email"),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: TextFormField(
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Please enter your content'
                                    : null;
                              },
                              onSaved: (newValue) => _postContent = newValue!,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your post",
                                  label: Text("Name"),
                                  prefixIcon: Icon(Icons.person)),
                            ),

                            
                          ),
                            Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton.icon(
                           onPressed: _createPost,
                            icon: Icon(Icons.app_registration),
                              label: Text("Submit")),
                )
                        ])
                        )
                        )
                        )
                        );
  }
}

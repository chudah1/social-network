import 'package:go_router/go_router.dart';
import 'package:social_network/views/create_post.dart';
import 'package:social_network/views/create_profile.dart';
import 'package:social_network/views/edit_profile.dart';
import 'package:social_network/views/get_profile.dart';
import 'package:social_network/views/home.dart';
import 'package:social_network/views/posts.dart';

class Routes {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) => Home(),
      ),
      GoRoute(
        name: "studentProfile",
        path: "/students/:idNumber",
        builder: (context, state) {
          String idNumber = state.params["idNumber"]!;
          return UserProfile(idNumber: idNumber);
        },
      ),
      GoRoute(
        name: "register",
        path: "/register",
        builder: ((context, state) => ProfileForm()),
      ),
      GoRoute(
        name: "edit",
        path: "/edit/:idNumber",
        builder: (context, state) {
          String idNumber = state.params["idNumber"]!;
          return EditForm(idNumber: idNumber);
        },
      ),
      GoRoute(
          name: "posts",
          path: "/posts",
          builder: ((context, state) => const PostForm())
          ),

      GoRoute(
          name: "allPosts",
          path: "/all_posts",
          builder: (context, state) => const PostData()
          )
    ],
  );

  GoRouter get router => _router;
}

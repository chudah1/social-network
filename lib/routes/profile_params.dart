import 'package:go_router/go_router.dart';
import 'package:social_network/views/create_post.dart';
import 'package:social_network/views/create_profile.dart';
import 'package:social_network/views/edit_user.dart';
import 'package:social_network/views/get_profile.dart';
import 'package:social_network/views/home.dart';
import 'package:social_network/views/login.dart';
import 'package:social_network/views/posts.dart';
import 'package:social_network/views/register_page.dart';
import 'package:social_network/views/user_profile.dart';

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
          return UserPage(idNumber: idNumber);
        },
      ),
      GoRoute(
        name: "register",
        path: "/register",
        builder: ((context, state) => RegisterPage()),
      ),
      GoRoute(
        name: "login",
        path: "/login",
        builder: ((context, state) => LoginPage()),
      ),
      GoRoute(
        name: "edit",
        path: "/edit/:idNumber",
        builder: (context, state) {
          String idNumber = state.params["idNumber"]!;
          return EditPage(idNumber: idNumber);
        },
      ),
      GoRoute(
          name: "posts",
          path: "/posts",
          builder: ((context, state) => const PostForm())),
      GoRoute(
          name: "allPosts",
          path: "/all_posts",
          builder: (context, state) => const PostData())
    ],
  );

  GoRouter get router => _router;
}

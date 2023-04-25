import 'package:go_router/go_router.dart';
import 'package:social_network/views/edit_user.dart';
import 'package:social_network/views/home.dart';
import 'package:social_network/views/login.dart';
import 'package:social_network/views/register_page.dart';
import 'package:social_network/views/user_profile.dart';
import 'package:social_network/views/view_profile.dart';

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
        name: "friendProfile",
        path: "/friends/:idNumber",
        builder: (context, state) {
          String idNumber = state.params["idNumber"]!;
          return ViewProfile(idNumber: idNumber);
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
    ],
  );

  GoRouter get router => _router;
}

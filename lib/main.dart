import 'package:flutter/material.dart';
import 'package:social_network/routes/profile_params.dart';
import 'package:firebase_core/firebase_core.dart';

/// The function initializes Firebase and sets up the routing for a Flutter social networking app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyABBB-aU6d9YtUEBCjwMr_nb3uo9vfG4pU",
          appId: "1:101453253944:web:2d5aa8a30c4ff595ef85cd",
          messagingSenderId: "101453253944",
          projectId: "flutter-social-network-a15ee"));
  Routes route = Routes();

  runApp(MaterialApp.router(
      title: "Ashesi Social Network", routerConfig: route.router));
}

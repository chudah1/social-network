import 'package:flutter/material.dart';
import 'package:social_network/controllers/user_controller.dart';
import 'package:social_network/models/user.dart';

class UserProfile extends StatelessWidget {
  final String idNumber;
  const UserProfile({super.key, required this.idNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: UserController().getUser(idNumber),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            final user = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("name: ${user.name}"),
                Text("email: ${user.email}"),
                Text("campusResidence: ${user.campusResidence}"),
                Text("food: ${user.food}"),
                Text("movie: ${user.movie}"),
                Text("DOB: ${user.dateOfBirth}"),
                Text("major: ${user.major}"),
                Text("yearGroup: ${user.yearGroup}"),
                Text("idNumber: ${user.idNumber}"),
              ],
            );
          },
        ),
      ),
    );
  }
}

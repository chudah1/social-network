import 'dart:convert';

import 'package:http/http.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/services/profile_service.dart';

class UserController {
  Future<String> createUser(User user) async {
    try {
      Response response = await UserService.createProfile(user);
      if (response.statusCode == 201) {
        return (response.body);
      }
      throw Exception("Failed to create a User");
    } catch (e) {
      throw Exception("Error creating a User Profile");
    }
  }

  Future<String> editUser(User user) async {
    try {
      Response response = await UserService.editProfile(user);
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception("Failed to create user");
    } catch (e) {
      throw Exception("Failed to edit user");
    }
  }

  Future<User> getUser(String idNumber) async { 
    try {
      final user = await UserService.getProfile(idNumber);
      return User.fromJson(jsonDecode(user.body));
      // if (user != null) {
      //   return user;
      // }
      // throw Exception("Failed to retrive user with id $idNumber");
    } catch (e) {
      print(e);
      throw Exception("Error retrieving user");
    }
  }
}

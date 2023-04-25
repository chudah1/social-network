import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/services/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  /// Creating a reference to the "profile" collection in the Firestore database using the
  /// `FirebaseFirestore.instance.collection()` method. The reference is stored in the `profile`

  final CollectionReference profile =
      FirebaseFirestore.instance.collection("profile");

  /// Creating an instance of the `FirebaseAuth` class from the `firebase_auth` package and storing it
  /// in the `_auth` variable.
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  /// This function creates a user profile and returns a boolean value indicating whether the creation was
  /// successful or not.
  ///
  /// Args:
  ///   user (User): The `user` parameter is an instance of the `User` class, which contains information
  /// about a user such as their name, email, and password. This method is using the `UserService` class
  /// to create a user profile by sending a POST request to a server. If the request is successful (
  ///
  /// Returns:
  ///   A `Future<bool>` is being returned.
  Future<bool> createUser(User user) async {
    try {
      Response response = await UserService.createProfile(user);
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Error creating a User Profile");
    }
  }

  /// This function edits a user's profile and returns a boolean value indicating whether the operation
  /// was successful or not.
  ///
  /// Args:
  ///   user (User): The "user" parameter is an object of the "User" class, which contains information
  /// about a user's profile. This method is used to edit the user's profile by sending a request to the
  /// server through the "UserService.editProfile" method. If the request is successful (status code 200
  ///
  /// Returns:
  ///   A `Future<bool>` is being returned.
  Future<bool> editUser(User user) async {
    try {
      Response response = await UserService.editProfile(user);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Failed to edit user");
    }
  }

  /// This function retrieves a user's profile by their ID number and returns it as a User object.
  ///
  /// Args:
  ///   idNumber (String): The idNumber parameter is a string that represents the unique identifier of a
  /// user. It is used to retrieve the user's profile from a UserService.
  ///
  /// Returns:
  ///   A `Future` object that will eventually resolve to a `User` object.
  Future<User> getUser(String idNumber) async {
    try {
      final user = await UserService.getProfile(idNumber);
      return User.fromJson(jsonDecode(user.body));
    } catch (e) {
      throw Exception("Error retrieving user");
    }
  }

  /// This function attempts to sign in a user with a given email and password and returns a boolean
  /// indicating success or failure.
  ///
  /// Args:
  ///   email (String): A string representing the email address of the user trying to sign in.
  ///   password (String): The password parameter is a string that represents the user's password that
  /// they are trying to sign in with.
  ///
  /// Returns:
  ///   a `Future<bool>` which indicates whether the user was successfully signed in or not. If the
  /// sign-in is successful, it returns `true`, otherwise it returns `false`.
  Future<bool> signInUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'wrong-password') {
        return false;
      }
    }
    return true;
  }

  /// The function checks if the user is authenticated and redirects to the login page if not, otherwise
  /// it retrieves the user's ID.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext object represents the location of a widget in the widget
  /// tree. It is used to access the properties of the widget and its parent widgets. In this case, it is
  /// used to navigate to the login screen if the user is not authenticated.
  ///
  /// Returns:
  ///   A `Future` object that will eventually resolve to a `String` value representing the user ID.
  Future<String> checkAuth(BuildContext context) async {
    final user = _auth.currentUser;
    String userId = "";
    if (user == null) {
      context.goNamed("login");
    } else {
      userId = await getDocumentIdByEmail(user.email);
    }
    return userId;
  }

  /// This function retrieves the document ID of a user profile based on their email address.
  ///
  /// Args:
  ///   email (String): The email parameter is a String variable that represents the email address of a
  /// user.
  ///
  /// Returns:
  ///   A `Future` object that will eventually resolve to a `String` value representing the document ID
  /// of a profile document in Firestore that matches the provided email.
  Future<String> getDocumentIdByEmail(String? email) async {
    String docId = "";
    QuerySnapshot snapshot =
        await profile.where('email', isEqualTo: email).get();
    if (snapshot.size > 0) {
      docId = snapshot.docs[0].id;
    }
    return docId;
  }
}

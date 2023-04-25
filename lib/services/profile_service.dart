import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social_network/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

/// The UserService class provides a static method to create a user profile by sending a POST request to
/// a specified URL.
class UserService {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static const url = 'us-central1-social-network-rest-api.cloudfunctions.net';
  static const endpoint = '/profile-api';

  /// This function creates a user profile by registering the user with Firebase authentication and
  /// sending their information to a specified endpoint using HTTP POST.
  ///
  /// Args:
  ///   user (User): The `User` object contains information about the user that needs to be created,
  /// including their email, password, and any other relevant details. This information is used to
  /// create a new user account using Firebase Authentication. The `toJson()` method is called on the
  /// `User` object to convert it to a
  ///
  /// Returns:
  ///   a `Future` object that resolves to an `http.Response` object.
  static Future<http.Response> createProfile(User user) async {
    http.Response? response;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      Uri parseUri = Uri.https(url, endpoint);
      response = await http.post(parseUri,
          headers: {"Content-Type": 'application/json'},
          body: json.encode(user.toJson()));
      return response;
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak password");
      } else if (e.code == 'email-already-in-use') {
        print("email in use");
      } else {
        print("error");
      }
    } catch (e) {
      print("e:::{e}");
      // An unexpected error occurred: show an error message
    }
    return response!;
  }

  /// This function edits a user's profile and returns a Future object containing an HTTP response.
  ///
  /// Args:
  ///   user (User): The `user` parameter is an instance of the `User` class, which contains information
  /// about a user's profile. This method is used to edit a user's profile by sending a request to the
  /// server with the updated user information.
  static Future<http.Response> editProfile(User user) async {
    Uri parseUri = Uri.https(url, endpoint)
        .replace(queryParameters: {'idNumber': user.idNumber});
    final response = await http.put(parseUri,
        headers: {"Content-Type": 'application/json'},
        body: json.encode(user.toJson()));
    return response;
  }

  /// The function retrieves a user's profile by sending a GET request to a specified endpoint with the
  /// user's ID number as a query parameter.
  ///
  /// Args:
  ///   idNumber (String): The idNumber parameter is a string that represents the unique identifier of a
  /// user's profile. It is used to retrieve the profile information from the server.
  ///
  /// Returns:
  ///   The function `getProfile` returns a `Future` object that resolves to an `http.Response` object.
  static Future<http.Response> getProfile(String idNumber) async {
    Uri parseUri = Uri.https(url, endpoint)
        .replace(queryParameters: {'idNumber': idNumber});
    final response = await http.get(parseUri);
    return response;
  }

  /// This function attempts to sign in a user with their email and password using Firebase authentication
  /// and handles any exceptions that may occur.
  ///
  /// Args:
  ///   email (String): A string representing the email address of the user trying to sign in.
  ///   password (String): The password parameter is a string that represents the user's password that
  /// they are trying to use to sign in to their account.
  static Future<void> signIn(String email, String password) async {
    try {
      await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User signed in successfully
    } on auth.FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}

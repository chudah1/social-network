import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social_network/models/user.dart';


/// The UserService class provides a static method to create a user profile by sending a POST request to
/// a specified URL.
class UserService {
  static const url = 'us-central1-social-network-rest-api.cloudfunctions.net';
  static const endpoint = '/profile-api';

  /// This function creates a user profile by sending a POST request to a specified endpoint with the user
  /// data in JSON format and returns the created user object.
  ///
  /// Args:
  ///   user (User): The user object that contains the data to be sent in the request body. It is encoded
  /// as JSON using the `toJson()` method before being sent in the request body.
  ///
  /// Returns:
  ///   The function `createProfile` returns a `Future` object that resolves to a `User` object.
  static Future<http.Response> createProfile(User user) async {
    Uri parseUri = Uri.https(url, endpoint);
    final response = await http.post(parseUri,
        headers: {"Content-Type": 'application/json'},
        body: json.encode(user.toJson()));
    return response;
  }

  /// This function edits a user's profile by sending a PUT request to a specified endpoint with the
  /// user's updated information in JSON format.
  ///
  /// Args:
  ///   user (User): The user object that contains the updated profile information.
  ///
  /// Returns:
  ///   a Future object that resolves to a User object.
  static Future<http.Response> editProfile(User user) async {
    Uri parseUri = Uri.https(url, endpoint)
        .replace(queryParameters: {'idNumber': user.idNumber});
    final response = await http.put(parseUri,
        headers: {"Content-Type": 'application/json'},
        body: json.encode(user.toJson()));
    return response;
  }

  /// The function retrieves a user profile by sending a GET request to a specified endpoint with an ID
  /// number as a query parameter and returns a User object parsed from the JSON response.
  ///
  /// Args:
  ///   idNumber (String): The idNumber parameter is a string that represents the unique identifier of a
  /// user's profile. It is used to retrieve the user's profile information from a server using an HTTP
  /// GET request.
  ///
  /// Returns:
  ///   The `getProfile` function is returning a `Future` object that resolves to a `User` object.
  static Future<http.Response> getProfile(String idNumber) async {
    Uri parseUri = Uri.https(url, endpoint)
        .replace(queryParameters: {'idNumber': idNumber});
    final response = await http.get(parseUri);
    return response;
  }
}

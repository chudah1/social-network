import 'package:intl/date_symbol_data_local.dart';

class User {
  String idNumber;
  String email;
  String name;
  String dateOfBirth;
  String major;
  bool campusResidence;
  int yearGroup;
  String movie;
  String food;

  /// This is a constructor for the `User` class that takes in required parameters `idNumber`, `name`,
  /// `email`, `dateOfBirth`, `major`, `campusResidence`, `yearGroup`, `movie`, and `food`. When an
  /// object of the `User` class is created, these parameters must be provided.
  User(
    {
    required this.idNumber,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.major,
    required this.campusResidence,
    required this.yearGroup,
    required this.movie,
    required this.food,
  });

  //function that converts an object's properties into a JSON format.
  Map<String, dynamic> toJson() => {
        "idNumber": idNumber,
        "name": name,
        "email": email,
        "dateOfBirth": dateOfBirth,
        "major": major,
        "campusResidence": campusResidence,
        "yearGroup": yearGroup,
        "movie": movie,
        "food": food
      };

  /// This is a factory method in Dart that takes in a JSON object and returns a User object with the
  /// corresponding properties.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): a Map object containing key-value pairs representing the JSON data
  /// to be parsed into a User object.
  ///
  /// Returns:
  ///   A User object is being returned, with properties initialized from the values in the provided JSON
  /// map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        idNumber: json['idNumber'],
        name: json['name'],
        email: json['email'],
        dateOfBirth: json['dateOfBirth'],
        major: json['major'],
        campusResidence: json['campusResidence'],
        yearGroup: json['yearGroup'],
        movie: json['movie'],
        food: json['food']);
  }
}

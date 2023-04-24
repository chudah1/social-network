import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/services/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  final CollectionReference profile =
      FirebaseFirestore.instance.collection("profile");
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
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

  Future<User> getUser(String idNumber) async {
    try {
      final user = await UserService.getProfile(idNumber);
      return User.fromJson(jsonDecode(user.body));
     
    } catch (e) {
      print(e);
      throw Exception("Error retrieving user");
    }
  }

  Future<bool> signInUser(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
    }
    return true;
  }

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

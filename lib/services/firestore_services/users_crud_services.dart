import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripplanner/models/user_model.dart';

class UsersCRUD {
  //
  final String uid;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  //
  UsersCRUD({required this.uid});
  //
  Future<void> addUser() async {
    return await usersCollection
        .doc(uid)
        .set(UserModel.getUserSchema())
        .catchError((error) {
      debugPrint(error.toString());
    });
  }

  //
  Future<String?> addTrip(String tid) async {
    String? error;
    //
    await usersCollection.doc(uid).update({
      'trips': FieldValue.arrayUnion([tid]),
    }).catchError((e) {
      error = e.toString();
    });
    //
    return error;
  }

  //
  Future<String?> deleteTrip(String tid) async {
    String? error;
    //
    await usersCollection.doc(uid).update({
      'trips': FieldValue.arrayRemove([tid]),
    }).catchError((e) {
      error = e.toString();
    });
    //
    return error;
  }
}

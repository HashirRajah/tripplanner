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
  Future<void> addUser(UserModel user) async {
    return await usersCollection
        .doc(uid)
        .set(user.getUserSchema())
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
  Future<List<UserModel>> getAllInvitations() async {
    List<UserModel> invitations = [];
    //
    DocumentSnapshot document = await usersCollection.doc(uid).get();
    //
    if (document.exists) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //
      for (String id in data['invitations']) {
        DocumentSnapshot userDoc = await usersCollection.doc(id.trim()).get();
        //
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data()! as Map<String, dynamic>;
          //
          UserModel user = UserModel(
            uid: uid,
            username: userData['username'],
            email: userData['email'],
            photoURL: userData['photo_url'],
          );
          //
          invitations.add(user);
        }
      }
    }
    return invitations;
  }

  //
  Future<List<UserModel>> getAllConnections() async {
    List<UserModel> connections = [];
    //
    DocumentSnapshot document = await usersCollection.doc(uid).get();
    //
    if (document.exists) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //
      for (String id in data['connections']) {
        DocumentSnapshot userDoc = await usersCollection.doc(id.trim()).get();
        //
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data()! as Map<String, dynamic>;
          //
          UserModel user = UserModel(
            uid: uid,
            username: userData['username'],
            email: userData['email'],
            photoURL: userData['photo_url'],
          );
          //
          connections.add(user);
        }
      }
    }
    return connections;
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

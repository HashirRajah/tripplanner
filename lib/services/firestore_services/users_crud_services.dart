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

  Future<String?> addConnection(UserModel user) async {
    String? error;
    //
    error = await removeInvitation(user);
    //
    if (error == null) {
      await usersCollection.doc(uid).update({
        'connections': FieldValue.arrayUnion([user.uid])
      }).catchError((error) {
        error = error.toString();
      });
      //
      await usersCollection.doc(user.uid).update({
        'connections': FieldValue.arrayUnion([uid])
      }).catchError((error) {
        error = error.toString();
      });
    }
    //
    return error;
  }

  //
  Future<String?> removeConnection(UserModel user) async {
    String? error;
    //
    await usersCollection.doc(uid).update({
      'connections': FieldValue.arrayRemove([user.uid])
    }).catchError((error) {
      error = error.toString();
    });
    //
    await usersCollection.doc(user.uid).update({
      'connections': FieldValue.arrayRemove([uid])
    }).catchError((error) {
      error = error.toString();
    });
    //
    return error;
  }

  //
  Future<String?> sendInvitation(UserModel user) async {
    String? error;
    //
    DocumentSnapshot doc = await usersCollection.doc(user.uid).get();
    //
    if (doc.exists) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      //
      if (data['invitations'].contains(uid)) {
        error = 'Invitation already sent';
      } else {
        await usersCollection.doc(user.uid).update({
          'invitations': FieldValue.arrayUnion([uid])
        }).catchError((error) {
          error = error.toString();
        });
      }
      //
    } else {
      error = 'No user found';
    }
    //
    return error;
  }

  //
  Future<String?> removeInvitation(UserModel user) async {
    String? error;
    //
    await usersCollection.doc(uid).update({
      'invitations': FieldValue.arrayRemove([user.uid])
    }).catchError((error) {
      error = error.toString();
    });
    //
    return error;
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
  Future<UserModel?> getUsers(String email) async {
    UserModel? user;
    //
    QuerySnapshot querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();
    //
    DocumentSnapshot document = querySnapshot.docs.first;
    //
    if (document.exists) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //
      UserModel user = UserModel(
        uid: uid,
        username: data['username'],
        email: data['email'],
        photoURL: data['photo_url'],
      );
    }
    return user;
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

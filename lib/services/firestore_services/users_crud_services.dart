import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripplanner/models/category_model.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';

class UsersCRUD {
  //
  final String uid;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  //
  UsersCRUD({required this.uid});
  //
  Future<void> addUser(UserModel user) async {
    //
    final LocalService localService = LocalService();
    //
    await usersCollection
        .doc(uid)
        .set(user.getUserSchema())
        .catchError((error) {
      debugPrint(error.toString());
    });
    //
    await localService.addUser(uid);
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
    DocumentSnapshot userDoc = await usersCollection.doc(uid).get();
    //
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data()! as Map<String, dynamic>;
      //
      if (userData['connections'].contains(user.uid)) {
        error = 'Already connected';
      } else {
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
      }
    } else {
      error = 'Error';
    }
    //
    return error;
  }

  //
  //
  Future<String?> addPOILike(int id) async {
    String? error;
    //
    DocumentSnapshot userDoc = await usersCollection.doc(uid).get();
    //
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data()! as Map<String, dynamic>;
      //
      if (!userData['liked_POIs'].contains(id)) {
        //
        await usersCollection.doc(uid).update({
          'liked_POIs': FieldValue.arrayUnion([id])
        }).catchError((error) {
          error = error.toString();
        });
        //
        final LocalService localService = LocalService();
        //
        dynamic result = await localService.addPOIlLike(uid, id);
        //
        if (result == null) {
          error = 'Error';
        }
      }
    } else {
      error = 'Error';
    }
    //
    return error;
  }

  //
  //
  Future<String?> removePOILike(int id) async {
    String? error;
    //
    DocumentSnapshot userDoc = await usersCollection.doc(uid).get();
    //
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data()! as Map<String, dynamic>;
      //
      if (userData['liked_POIs'].contains(id)) {
        //
        await usersCollection.doc(uid).update({
          'liked_POIs': FieldValue.arrayRemove([id])
        }).catchError((error) {
          error = error.toString();
        });
        //
        final LocalService localService = LocalService();
        //
        dynamic result = await localService.removePOIlLike(uid, id);
        //
        if (result == null) {
          error = 'Error';
        }
      }
    } else {
      error = 'Error';
    }
    //
    return error;
  }

  //
  //
  Future<String?> addDestinationLike(int id) async {
    String? error;
    //
    DocumentSnapshot userDoc = await usersCollection.doc(uid).get();
    //
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data()! as Map<String, dynamic>;
      //
      if (!userData['liked_destinations'].contains(id)) {
        //
        await usersCollection.doc(uid).update({
          'liked_destinations': FieldValue.arrayUnion([id])
        }).catchError((error) {
          error = error.toString();
        });
        //
        final LocalService localService = LocalService();
        //
        dynamic result = await localService.addDestinationLike(uid, id);
        //
        if (result == null) {
          error = 'Error';
        }
      }
    } else {
      error = 'Error';
    }
    //
    return error;
  }

  //
  //
  Future<String?> removeDestinationLike(int id) async {
    String? error;
    //
    DocumentSnapshot userDoc = await usersCollection.doc(uid).get();
    //
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data()! as Map<String, dynamic>;
      //
      if (userData['liked_destinations'].contains(id)) {
        //
        await usersCollection.doc(uid).update({
          'liked_destinations': FieldValue.arrayRemove([id])
        }).catchError((error) {
          error = error.toString();
        });
        //
        final LocalService localService = LocalService();
        //
        dynamic result = await localService.removeDestinationLike(uid, id);
        //
        if (result == null) {
          error = 'Error';
        }
      }
    } else {
      error = 'Error';
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
  Future<String?> addResidency(CountryModel country) async {
    String? error;
    //
    await usersCollection.doc(uid).update({
      'residency': {'country_name': country.name, 'country_code': country.code},
    }).catchError((e) {
      error = e.toString();
    });
    //
    return error;
  }

  //
  Future<String?> addAdditionalInfo(
      CountryModel residency, CountryModel citizenship) async {
    String? error;
    error = await addResidency(residency);
    error = await addCitizenship(citizenship);
    //
    return error;
  }

  //
  Future<String?> addCitizenship(CountryModel country) async {
    String? error;
    //
    await usersCollection.doc(uid).update({
      'citizenship': {
        'country_name': country.name,
        'country_code': country.code
      },
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
            uid: userDoc.id,
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
    for (DocumentSnapshot document in querySnapshot.docs) {
      if (document.exists && document.id != uid) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        //
        user = UserModel(
          uid: document.id,
          username: data['username'],
          email: data['email'],
          photoURL: data['photo_url'],
        );
      }
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
            uid: userDoc.id,
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
  Future<List<int>> getAllPreferences() async {
    List<int> preferences = [];
    //
    DocumentSnapshot document = await usersCollection.doc(uid).get();
    //
    if (document.exists) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //
      for (int pref in data['preferences']) {
        preferences.add(pref);
      }
    }
    return preferences;
  }

  //
  //
  Future<List<int>> getAllLikedDestinations() async {
    List<int> likes = [];
    //
    DocumentSnapshot document = await usersCollection.doc(uid).get();
    //
    if (document.exists) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //
      for (int pref in data['liked_destinations']) {
        likes.add(pref);
      }
    }
    return likes;
  }

  //
  Future<List<int>> getAllLikedPOIs() async {
    List<int> likes = [];
    //
    DocumentSnapshot document = await usersCollection.doc(uid).get();
    //
    if (document.exists) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //
      for (int pref in data['liked_POIs']) {
        likes.add(pref);
      }
    }
    return likes;
  }

  //
  //
  Future<String?> addPreferences(
      List<int> prefs, List<CategoryModel> cats) async {
    String? error;
    //
    await usersCollection.doc(uid).update(
        {'preferences': FieldValue.arrayUnion(prefs)}).catchError((error) {
      error = error.toString();
    });
    //
    if (error == null) {
      final LocalService localService = LocalService();
      //
      List<String> catNames = [];
      for (CategoryModel catModel in cats) {
        catNames.add(catModel.title);
      }
      //
      dynamic result = await localService.addPreferences(uid, catNames);
      //
      if (result != 'ok') {
        error = 'Unexpected error';
      }
    }
    //
    return error;
  }

  //
  //
  Future<String?> removePreferences(
      List<int> prefs, List<CategoryModel> cats) async {
    String? error;
    //
    await usersCollection.doc(uid).update(
        {'preferences': FieldValue.arrayRemove(prefs)}).catchError((error) {
      error = error.toString();
    });
    //
    return error;
  }

  //
  Future<String?> shareTrip(List<String> userIds, String tripId) async {
    String? error;
    //
    for (String id in userIds) {
      //
      DocumentSnapshot userDoc = await usersCollection.doc(id).get();
      //
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data()! as Map<String, dynamic>;
        //
        if (userData['trips'].contains(tripId)) {
          error = 'Trip already shared';
        } else {
          await usersCollection.doc(id).update({
            'trips': FieldValue.arrayUnion([tripId])
          }).catchError((error) {
            error = error.toString();
          });
          //
          final TripsCRUD tripsCRUD = TripsCRUD(tripId: tripId);
          //
          await tripsCRUD.shareTrip();
        }
      }
      //
    }
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

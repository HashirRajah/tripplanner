import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/models/trip_card_model.dart';
import 'package:tripplanner/models/trip_details_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/services/firestore_services/budget_crud_services.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/rest_countries_services.dart';

class TripsCRUD {
  //
  String? tripId;
  // firestore instance
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('trips');
  //
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  //
  TripsCRUD({this.tripId});
  // add trip
  Future<String?> addTrip(TripModel trip) async {
    String? error;
    //
    DocumentReference doc =
        await tripsCollection.add(trip.getTripSchema()).catchError((e) {
      error = e.toString();
    });
    //
    if (error == null) {
      final UsersCRUD userDoc = UsersCRUD(uid: uid);
      //
      final BudgetCRUDServices budgetCRUDServices =
          BudgetCRUDServices(tripId: doc.id, userId: uid);
      //
      error = await budgetCRUDServices.addBudget(trip.budget);
      //
      error = await userDoc.addTrip(doc.id);
    }
    //
    return error;
  }

  // delete trip
  Future<String?> deleteTrip(String tid) async {
    String? error;
    //
    await tripsCollection.doc(tid).delete().catchError((e) {
      error = e.toString();
    });
    //
    if (error == null) {
      final UsersCRUD userDoc = UsersCRUD(uid: uid);
      //
      error = await userDoc.deleteTrip(tid);
    }
    //
    return error;
  }
  //

  // delete trip
  Future<String?> shareTrip() async {
    String? error;
    //
    await tripsCollection.doc(tripId).update({
      'is_shared': true,
    }).catchError((e) {
      error = e.toString();
    });

    //
    return error;
  }

  // get a trip
  Future<DocumentSnapshot> getTrip(String id) async {
    return await tripsCollection.doc(id).get();
  }

  //
  Future<TripDetailsModel?> getTripDetails(String id) async {
    DocumentSnapshot snapshot = await tripsCollection.doc(id).get();
    //
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      List<DestinationModel> destinations = [];
      //
      for (var destination in data['destinations']) {
        DestinationModel dest = DestinationModel(
          description: destination['description'],
          countryCode: destination['country_code'],
          countryName: destination['country_name'],
        );
        //
        destinations.add(dest);
      }
      DateTime startDate = DateTime.parse(data['start_date']);
      DateTime endDate = DateTime.parse(data['end_date']);
      //
      TripDetailsModel tripDetails = TripDetailsModel(
        id: id,
        title: data['title'],
        startDate: data['start_date'],
        endDate: data['end_date'],
        destinations: destinations,
      );
      //
      return tripDetails;
    } else {
      return null;
    }
  }

  // get all destinations in a trip
  Future<List<DestinationModel>> getAllDestinations() async {
    //
    List<DestinationModel> destinations = [];
    //
    DocumentSnapshot snapshot = await tripsCollection.doc(tripId).get();
    //
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      //
      for (var destination in data['destinations']) {
        DestinationModel dest = DestinationModel(
          description: destination['description'],
          countryCode: destination['country_code'],
          countryName: destination['country_name'],
        );
        //
        destinations.add(dest);
      }
    }
    //
    return destinations;
  }

  //
  // get all destinations in a trip
  Future<Map<String, String>> getStartAndEndDates() async {
    //
    final Map<String, String> dates = {};
    //
    DocumentSnapshot snapshot = await tripsCollection.doc(tripId).get();
    //
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      //
      dates['start'] = data['start_date'];
      dates['end'] = data['end_date'];
    }
    //
    return dates;
  }

  //
  // get all destinations in a trip
  Future<List<String>> getDestinationsCurrencies() async {
    //
    List<String> currencies = [];
    //
    DocumentSnapshot snapshot = await tripsCollection.doc(tripId).get();
    //
    if (snapshot.exists) {
      final RestCountriesService rcService = RestCountriesService();
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      //
      for (var destination in data['destinations']) {
        destination['country_code'];
        //
        dynamic result =
            await rcService.getCountryCurrency(destination['country_code']);
        //

        if (result != null) {
          for (var currency in result) {
            currencies.add(currency);
          }
        }
      }
    }
    //
    return currencies;
  }

  // get all destinations in a trip
  Future<bool> tripShared() async {
    //
    bool shared = false;
    //
    DocumentSnapshot snapshot = await tripsCollection.doc(tripId).get();
    //
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      //
      shared = data['is_shared'];
    }
    //
    return shared;
  }

  //
  Future<List<TripCardModel>> loadTrips() async {
    //
    List<TripCardModel> tripsList = [];
    //
    DocumentSnapshot documentSnapshot = await usersCollection.doc(uid).get();
    //
    if (documentSnapshot.exists) {
      //
      Map<String, dynamic> data =
          documentSnapshot.data()! as Map<String, dynamic>;
      //
      List trips = data['trips'];
      //
      for (var id in data['trips']) {
        DocumentSnapshot snapshot = await getTrip(id);
        //
        if (snapshot.exists) {
          //
          Map<String, dynamic> tripData =
              snapshot.data()! as Map<String, dynamic>;
          //
          TripCardModel tripCard = TripCardModel(
            id: id,
            title: tripData['title'],
            startDate: tripData['start_date'],
            endDate: tripData['end_date'],
          );
          //
          tripsList.add(tripCard);
        }
      }
    }
    //
    return tripsList;
  }

  // trip list stream
  Stream<DocumentSnapshot> get tripStream {
    return tripsCollection.doc(tripId).snapshots();
  }

  // trip list stream
  Stream<bool?> get userDataStream {
    //print('fired');
    return usersCollection
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot.exists);
  }
}

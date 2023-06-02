import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripplanner/models/trip_card_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/services/firestore_services/budget_crud_services.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';

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

  // get a trip
  Future<DocumentSnapshot> getTrip(String id) async {
    return await tripsCollection.doc(id).get();
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

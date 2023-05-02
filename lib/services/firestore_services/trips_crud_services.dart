import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';

class TripsCRUD {
  String? tid;
  // firestore instance
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('trips');
  //
  TripsCRUD({this.tid});

  // add trip
  Future<String?> addTrip(TripModel trip) async {
    String? error;
    //
    Map<String, dynamic> tripModel = TripModel.getTripSchema();
    //
    tripModel['title'] = trip.title;
    tripModel['destinations'] = trip.getDestinationsMap();
    tripModel['start_date'] = trip.dates.start.toIso8601String();
    tripModel['end_date'] = trip.dates.end.toIso8601String();
    tripModel['budget'] = trip.getBudgetMap();
    //
    DocumentReference doc =
        await tripsCollection.add(tripModel).catchError((e) {
      error = e.toString();
    });
    //
    final UsersCRUD userDoc = UsersCRUD(uid: uid);
    //
    error = await userDoc.addTrip(doc.id);
    //
    return error;
  }

  // delete trip
  Future<String?> deleteTrip() async {
    String? error;
    //
    await tripsCollection.doc(tid).delete().catchError((e) {
      error = e.toString();
    });
    //
    return error;
  }
}

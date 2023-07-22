import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/visit_model.dart';

class VisitCRUDServices {
  //
  final String tripId;
  final String userId;
  //
  late final CollectionReference visitsCollection;
  //
  VisitCRUDServices({required this.tripId, required this.userId}) {
    visitsCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('visits');
  }
  // add visit
  Future<String?> addVisit(VisitModel visit) async {
    String? error;
    //
    await visitsCollection.doc(userId).set(visit.getVisitMap()).catchError((e) {
      error = e.toString();
      //
    });
    //
    return error;
  }

  // update visit
}

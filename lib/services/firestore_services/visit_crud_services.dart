import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:tripplanner/models/visit_model.dart';

class VisitsCRUD {
  //
  final String tripId;
  final String userId;
  //
  final DateFormat dateFormat = DateFormat.yMd();
  //
  late final CollectionReference visitsCollection;
  //
  VisitsCRUD({required this.tripId, required this.userId}) {
    visitsCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('visits');
  }
  // add visit
  Future<String?> addVisit(DateTime date, VisitModel visit) async {
    String? error;
    late final String docId;
    late final int sequence;
    //
    String formattedDate = dateFormat.format(date);
    //
    QuerySnapshot querySnapshot =
        await visitsCollection.where('date', isEqualTo: formattedDate).get();
    //
    if (querySnapshot.docs.isEmpty) {
      DocumentReference doc = await visitsCollection.add({
        'date': formattedDate,
      }).catchError((e) {
        error = e.toString();
      });
      //
      docId = doc.id;
    } else {
      docId = querySnapshot.docs.first.id;
    }
    //
    final CollectionReference visitCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('visits')
        .doc(docId)
        .collection('scheduled_visits');
    //
    QuerySnapshot qSnapshot =
        await visitCollection.where('id', isEqualTo: visit.id).get();
    //
    if (qSnapshot.docs.isNotEmpty) {
      error = 'Visit Already Added';
    } else {
      //
      QuerySnapshot snapshot = await visitCollection.get();
      sequence = snapshot.docs.length + 1;
      //
      visit.sequence = sequence;
      //
      await visitCollection.add(visit.getVisitMap()).catchError((e) {
        error = e.toString();
      });
    }
    //
    return error;
  }

  //
  // edit visit
  Future<String?> editVisit(
      DateTime date, int newSequence, int oldSequence) async {
    String? error;
    late final String docId;
    late final int sequence;
    late int minSequence;
    late int maxSequence;
    //
    if (newSequence < oldSequence) {
      minSequence = newSequence;
      maxSequence = oldSequence;
    } else {
      minSequence = oldSequence;
      maxSequence = newSequence;
    }
    //
    String formattedDate = dateFormat.format(date);
    //
    QuerySnapshot querySnapshot =
        await visitsCollection.where('date', isEqualTo: formattedDate).get();
    //
    docId = querySnapshot.docs.first.id;
    //
    final CollectionReference visitCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('visits')
        .doc(docId)
        .collection('scheduled_visits');
    //
    QuerySnapshot snapshot = await visitCollection.orderBy('sequence').get();
    //
    for (var visitDoc in snapshot.docs) {
      Map<String, dynamic> data = visitDoc.data()! as Map<String, dynamic>;
      //
      if (data['sequence'] >= minSequence && data['sequence'] <= maxSequence) {
        if (data['sequence'] == minSequence) {
          await visitCollection
              .doc(visitDoc.id)
              .update({'sequence': maxSequence}).catchError((e) {
            error = e.toString();
          });
        } else if (data['sequence'] == maxSequence) {
          await visitCollection
              .doc(visitDoc.id)
              .update({'sequence': minSequence}).catchError((e) {
            error = e.toString();
          });
          //
          break;
        } else {
          if ((data['sequence'] - 1) != minSequence) {
            await visitCollection
                .doc(visitDoc.id)
                .update({'sequence': (data['sequence'] - 1)}).catchError((e) {
              error = e.toString();
            });
          }
        }
      }
    }
    //
    return error;
  }

  // delete visit
  Future<String?> removeVisit(DateTime date, String id) async {
    String? error;
    late final String docId;
    //
    String formattedDate = dateFormat.format(date);
    //
    QuerySnapshot querySnapshot =
        await visitsCollection.where('date', isEqualTo: formattedDate).get();
    //
    docId = querySnapshot.docs.first.id;
    //
    final CollectionReference visitCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('visits')
        .doc(docId)
        .collection('scheduled_visits');
    //
    await visitCollection.doc(id).delete().catchError((e) {
      error = e.toString();
    });
    //
    return error;
  }

  //
  Future<List<VisitModel>> getVisitsForDate(DateTime date) async {
    List<VisitModel> visits = [];
    //
    String formattedDate = dateFormat.format(date);
    //
    try {
      QuerySnapshot querySnapshot =
          await visitsCollection.where('date', isEqualTo: formattedDate).get();
      //
      for (var doc in querySnapshot.docs) {
        if (doc.exists) {
          //
          final CollectionReference visitCollection = FirebaseFirestore.instance
              .collection('trips')
              .doc(tripId)
              .collection('visits')
              .doc(doc.id)
              .collection('scheduled_visits');
          //
          QuerySnapshot snapshot =
              await visitCollection.orderBy('sequence').get();
          //
          for (var visitDoc in snapshot.docs) {
            Map<String, dynamic> data =
                visitDoc.data()! as Map<String, dynamic>;
            //
            VisitModel visit = VisitModel(
              docId: visitDoc.id,
              id: data['id'],
              placeId: data['place_id'],
              fsqId: data['fsq_id'],
              poiId: data['poi_id'],
              name: data['name'],
              imageUrl: data['image_url'],
              sequence: data['sequence'],
              lat: data['lat'],
              lng: data['lng'],
              additionalData: data['additional_data'],
              addedBy: data['added_by'],
            );
            //
            visits.add(visit);
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    //
    return visits;
  }
  //
}

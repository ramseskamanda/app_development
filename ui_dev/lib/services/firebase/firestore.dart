import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:ui_dev/models/competition_model.dart';

class FirestoreService {
  Firestore _firestore = Firestore.instance;

  Future<CompetitionModel> getCompetitionById(String id) async {
    DocumentSnapshot doc =
        await _firestore.collection('competitions').document(id).get();
    return CompetitionModel.fromJson(doc.data);
  }

  Stream<CompetitionModel> getDocumentStreamById(String collection, String id) {
    return _firestore
        .collection(collection)
        .document(id)
        .snapshots()
        .map((snap) => CompetitionModel.fromJson(snap.data));
  }

  Future<void> uploadCompetitionInformation(Map<String, dynamic> data) async {
    try {
      _firestore.collection('competitions').add(data);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}

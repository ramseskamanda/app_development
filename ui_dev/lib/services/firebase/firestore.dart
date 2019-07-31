import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  Firestore _firestore = Firestore.instance;

  Future<void> uploadCompetitionInformation(Map<String, dynamic> data) async {
    try {
      _firestore.collection('competitions').add(data);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}

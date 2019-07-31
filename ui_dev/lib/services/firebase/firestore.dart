import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  Firestore _firestore = Firestore.instance;

  Future<bool> uploadCompetitionInformation(Map<String, dynamic> data) async {
    try {
      assert(data.length == 4);
      _firestore.collection('competitions').add(data);
      return true;
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }
}

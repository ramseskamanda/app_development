import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/util/config.dart';

final Firestore _firestore = Firestore.instance;

const String studentsCollection = 'students';
const String educationCollection = 'education_history';
const String experienceCollection = 'laboral_experiences';
const String startupCollection = 'startups';
const String prizesCollection = 'prizes';
const String projectCollection = 'projects';
const String projectSignupsCollection = 'project_signups';
const String thinkTanksCollection = 'think_tanks';
const String skillsCollection = 'skills';
const String chatsCollection = 'chats';
const String messagesCollection = 'messages';

class FirestoreReader {
  Future<List<StartupInfoModel>> fetchStartups(QueryOrder order) async {
    try {
      String field =
          QueryOrder.newest == order ? 'creation_date' : 'interactions';
      QuerySnapshot snapshot = await _firestore
          .collection(startupCollection)
          .orderBy(field, descending: true)
          .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      return snapshot.documents
          .map((doc) => StartupInfoModel.fromDoc(doc))
          .toList();
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  Future<List<ThinkTanksModel>> fetchThinkTanks(QueryOrder order) async {
    try {
      String field =
          QueryOrder.newest == order ? 'timestamps' : 'interactionCount';
      QuerySnapshot snapshot = await _firestore
          .collection(thinkTanksCollection)
          .orderBy(field)
          .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      return snapshot.documents
          .map((doc) => ThinkTanksModel.fromDoc(doc))
          .toList();
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }
}

class FirestoreWriter {
  Future createUser(String uid, UserInfoModel user) async {
    try {
      await _firestore
          .collection(studentsCollection)
          .document(uid)
          .setData(user.toJson());
    } catch (e) {
      throw e;
    }
  }
}

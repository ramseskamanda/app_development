import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/models/prize_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/project_signup_model.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/storage/firebase/env.dart';

final Firestore _firestore = Firestore.instance;

class FirestoreReader implements BaseAPIReader {
  @override
  Future<Map<DocumentReference, bool>> findUserDocument(String uid) async {
    try {
      DocumentSnapshot _user =
          await _firestore.collection(studentsCollection).document(uid).get();
      if (_user.exists)
        return {_user.reference: studentsCollection == startupCollection};
      DocumentSnapshot _startup =
          await _firestore.collection(startupCollection).document(uid).get();
      if (_startup.exists)
        return {_startup.reference: startupCollection == startupCollection};
      throw NetworkError(message: 'No User Found For UID: $uid');
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  @override
  Future<UserInfoModel> fetchUser(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(studentsCollection).document(uid).get();
      return UserInfoModel.fromDoc(snapshot);
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  @override
  Future<List<UserInfoModel>> fetchAllUsers(List<String> users) async {
    try {
      final List<UserInfoModel> models = [];
      for (String uid in users) {
        try {
          DocumentSnapshot snapshot = await _firestore
              .collection(studentsCollection)
              .document(uid)
              .get();
          models.add(UserInfoModel.fromDoc(snapshot));
        } catch (e) {}
      }
      return models;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Stream<UserInfoModel> fetchUserInfoStream(String docPath) {
    try {
      DocumentReference doc = _firestore.document(docPath);
      return doc.snapshots().map((snapshot) => UserInfoModel.fromDoc(snapshot));
    } catch (e) {
      return Stream.empty();
    }
  }

  @override
  Stream<StartupInfoModel> fetchStartupInfoStream(String docPath) {
    try {
      DocumentReference doc = _firestore.document(docPath);
      return doc
          .snapshots()
          .map((snapshot) => StartupInfoModel.fromDoc(snapshot));
    } catch (e) {
      return Stream.empty();
    }
  }

  @override
  Stream<List<SkillsModel>> fetchSkills(String uid) {
    return _firestore
        .collection(skillsCollection)
        .where('user_id', isEqualTo: uid)
        .orderBy('avg_rating', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((doc) => SkillsModel.fromDoc(doc)).toList());
  }

  @override
  Stream<List<EducationModel>> fetchEducation(String uid) {
    return _firestore
        .collection(educationCollection)
        .where('user_id', isEqualTo: uid)
        .orderBy('period_start', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((doc) => EducationModel.fromDoc(doc.data))
            .toList());
  }

  @override
  Stream<List<LaborExeprienceModel>> fetchExperience(String uid) {
    return _firestore
        .collection(experienceCollection)
        .orderBy('period_start', descending: true)
        .where('user_id', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((doc) => LaborExeprienceModel.fromDoc(doc.data))
            .toList());
  }

  @override
  Future<List<StartupInfoModel>> fetchStartups(QueryOrder order) async {
    try {
      String field =
          QueryOrder.newest == order ? 'creation_date' : 'interactions';
      QuerySnapshot snapshot = await _firestore
          .collection(startupCollection)
          .orderBy(field, descending: true)
          // .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      return snapshot.documents
          .map((doc) => StartupInfoModel.fromDoc(doc))
          .toList();
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  @override
  Future<List<ThinkTanksModel>> fetchThinkTanks(QueryOrder order) async {
    try {
      String field =
          QueryOrder.newest == order ? 'lastActivity' : 'commentCount';
      QuerySnapshot snapshot = await _firestore
          .collection(thinkTanksCollection)
          .orderBy(field, descending: true)
          // .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      return snapshot.documents
          .map((doc) => ThinkTanksModel.fromDoc(doc))
          .toList();
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  @override
  Future<List<ProjectModel>> fetchProjects(QueryOrder order) async {
    try {
      String field = QueryOrder.newest == order ? 'timestamp' : 'signups_num';
      QuerySnapshot snapshot = await _firestore
          .collection(projectCollection)
          .where('deadline', isGreaterThan: Timestamp.now())
          .orderBy('deadline')
          .orderBy(field)
          // .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      return snapshot.documents
          .map((doc) => ProjectModel.fromDoc(doc))
          .toList();
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  @override
  Future<List<ProjectModel>> fetchProjectsByOwner(String uid,
      {QueryOrder order = QueryOrder.popularity}) async {
    try {
      String field = QueryOrder.newest == order ? 'timestamp' : 'signups_num';
      QuerySnapshot snapshot = await _firestore
          .collection(projectCollection)
          .where('creator_id', isEqualTo: uid)
          .orderBy(field, descending: true)
          // .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      return snapshot.documents
          .map((doc) => ProjectModel.fromDoc(doc))
          .toList();
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  @override
  Stream<List<ProjectModel>> fetchOngoingProjects(String uid,
      {QueryOrder order = QueryOrder.popularity}) {
    String field = QueryOrder.newest == order ? 'timestamp' : 'signups_num';
    return _firestore
        .collection(projectCollection)
        .where('creator_id', isEqualTo: uid)
        .where('deadline',
            isGreaterThan: DateTime.now().subtract(Duration(days: 1)))
        .orderBy('deadline')
        .orderBy(field, descending: true)
        // .limit(NUM_ITEM_PREVIEW)
        .snapshots()
        .map((snap) =>
            snap.documents.map((doc) => ProjectModel.fromDoc(doc)).toList());
  }

  @override
  Stream<List<ProjectModel>> fetchPastProjects(String uid) {
    return _firestore
        .collection(projectCollection)
        .where('creator_id', isEqualTo: uid)
        .where('deadline', isLessThan: DateTime.now())
        // .limit(NUM_ITEM_PREVIEW)
        .snapshots()
        .map((snap) =>
            snap.documents.map((doc) => ProjectModel.fromDoc(doc)).toList());
  }

  @override
  Stream<List<Comments>> fetchComments(String collectionPath) {
    CollectionReference reference = _firestore.collection(collectionPath);
    return reference
        .orderBy('upvotes', descending: true)
        // .limit(10)
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((doc) => Comments.fromDoc(doc)).toList());
  }

  @override
  Stream<List<ChatModel>> fetchChatPreviews(String uid) {
    return _firestore
        .collection(chatsCollection)
        .where('list_participants', arrayContains: uid)
        .orderBy('latest_message.sentAt', descending: true)
        // .limit(10)
        .snapshots(includeMetadataChanges: true)
        .map((snap) =>
            snap.documents.map((doc) => ChatModel.fromDoc(doc)).toList());
  }

  @override
  Stream<QuerySnapshot> fetchMessages(String collectionPath) {
    CollectionReference reference = _firestore.collection(collectionPath);
    return reference
        .orderBy('sentAt', descending: true)
        // .limit(numLoaded)
        .snapshots();
  }

  @override
  Future<List<UserInfoModel>> fetchRankings({bool monthly = true}) async {
    try {
      QuerySnapshot snapshot;
      if (monthly) {
        snapshot = await _firestore
            .collection(studentsCollection)
            .orderBy('experience_month')
            // .limit(20)
            .getDocuments();
      } else {
        snapshot = await _firestore
            .collection(studentsCollection)
            .orderBy('experience_overall')
            // .limit(20)
            .getDocuments();
      }
      return snapshot.documents
          .map((doc) => UserInfoModel.fromDoc(doc))
          .toList();
    } on PlatformException {
      throw NetworkError(message: 'Couldn\'t find the resources requested');
    }
  }

  @override
  Future<List<PrizeModel>> fetchPrizesRanking() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(prizesCollection)
          .orderBy('ranking')
          // .limit(NUM_ITEM_LIST)
          .getDocuments();
      return snapshot.documents.map((doc) => PrizeModel.fromDoc(doc)).toList();
    } on PlatformException {
      throw NetworkError(
          message: 'Couldn\'t find the resources you\'re looking for...');
    }
  }

  @override
  Stream<ProjectSignupModel> fetchProjectSignupById(
    String userId,
    ProjectModel project,
  ) {
    return _firestore
        .collection(projectCollection)
        .document(project.docId)
        .collection('applications')
        .document(userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? ProjectSignupModel.fromDoc(snapshot) : null);
  }
}

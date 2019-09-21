import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
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
  Observable<UserInfoModel> fetchUserInfoStream(String docPath) {
    try {
      final DocumentReference doc = _firestore.document(docPath);
      final Stream<UserInfoModel> stream =
          doc.snapshots().map((snapshot) => UserInfoModel.fromDoc(snapshot));
      return Observable<UserInfoModel>(stream).shareReplay(maxSize: 1);
    } catch (e) {
      return Observable<UserInfoModel>.empty();
    }
  }

  @override
  Observable<StartupInfoModel> fetchStartupInfoStream(String docPath) {
    try {
      final DocumentReference doc = _firestore.document(docPath);
      final Stream<StartupInfoModel> stream =
          doc.snapshots().map((snapshot) => StartupInfoModel.fromDoc(snapshot));
      return Observable<StartupInfoModel>(stream).shareReplay(maxSize: 1);
    } catch (e) {
      return Observable<StartupInfoModel>.empty();
    }
  }

  @override
  Observable<List<SkillsModel>> fetchSkills(String uid) {
    final Stream<List<SkillsModel>> stream = _firestore
        .collection(skillsCollection)
        .where('user_id', isEqualTo: uid)
        .orderBy('avg_rating', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((doc) => SkillsModel.fromDoc(doc)).toList());
    return Observable<List<SkillsModel>>(stream).shareReplay(maxSize: 1);
  }

  @override
  Observable<List<EducationModel>> fetchEducation(String uid) {
    final Stream<List<EducationModel>> stream = _firestore
        .collection(educationCollection)
        .where('user_id', isEqualTo: uid)
        .orderBy('period_end', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((doc) => EducationModel.fromDoc(doc))
            .toList());
    return Observable<List<EducationModel>>(stream).shareReplay(maxSize: 1);
  }

  @override
  Observable<List<LaborExeprienceModel>> fetchExperience(String uid) {
    final Stream<List<LaborExeprienceModel>> stream = _firestore
        .collection(experienceCollection)
        .orderBy('period_start', descending: true)
        .where('user_id', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((doc) => LaborExeprienceModel.fromDoc(doc))
            .toList());

    return Observable<List<LaborExeprienceModel>>(stream)
        .shareReplay(maxSize: 1);
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
  Future<List<ThinkTankModel>> fetchThinkTanks(QueryOrder order) async {
    try {
      String field =
          QueryOrder.newest == order ? 'lastActivity' : 'commentCount';
      QuerySnapshot snapshot = await _firestore
          .collection(thinkTanksCollection)
          .orderBy(field, descending: true)
          // .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      return snapshot.documents
          .map((doc) => ThinkTankModel.fromDoc(doc))
          .toList();
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  @override
  Future<List<ProjectModel>> fetchProjects(QueryOrder order) async {
    try {
      //TODO: fix this to actually sort things by timestamp or signups_num
      String field = QueryOrder.newest == order ? 'timestamp' : 'signups_num';
      QuerySnapshot snapshot = await _firestore
          .collection(projectCollection)
          .where('deadline', isGreaterThan: Timestamp.now())
          .orderBy('deadline')
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
  Observable<List<ProjectModel>> fetchProjectsByOwnerStream(String uid,
      {QueryOrder order = QueryOrder.popularity}) {
    try {
      String field = QueryOrder.newest == order ? 'timestamp' : 'signups_num';
      final Stream<List<ProjectModel>> stream = _firestore
          .collection(projectCollection)
          .where('creator_id', isEqualTo: uid)
          .orderBy(field, descending: true)
          // .limit(NUM_ITEM_PREVIEW)
          .snapshots()
          .map((snapshot) => snapshot.documents
              .map((doc) => ProjectModel.fromDoc(doc))
              .toList());
      return Observable<List<ProjectModel>>(stream).shareReplay(maxSize: 1);
    } on PlatformException catch (e) {
      print(e);
      throw NetworkError(message: 'Resources requested unavailable');
    }
  }

  @override
  Observable<List<ProjectModel>> fetchOngoingProjects(String uid,
      {QueryOrder order = QueryOrder.popularity}) {
    final String field =
        QueryOrder.newest == order ? 'timestamp' : 'signups_num';
    final Stream<List<ProjectModel>> stream = _firestore
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
    return Observable<List<ProjectModel>>(stream).shareReplay(maxSize: 1);
  }

  @override
  Observable<List<ProjectModel>> fetchPastProjects(String uid) {
    final Stream<List<ProjectModel>> stream = _firestore
        .collection(projectCollection)
        .where('creator_id', isEqualTo: uid)
        .where('deadline', isLessThan: DateTime.now())
        // .limit(NUM_ITEM_PREVIEW)
        .snapshots()
        .map((snap) =>
            snap.documents.map((doc) => ProjectModel.fromDoc(doc)).toList());
    return Observable<List<ProjectModel>>(stream).shareReplay(maxSize: 1);
  }

  @override
  Observable<List<Comments>> fetchComments(String collectionPath) {
    final CollectionReference reference = _firestore.collection(collectionPath);
    final Stream<List<Comments>> stream = reference
        .orderBy('vote_count', descending: true)
        // .limit(10)
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((doc) => Comments.fromDoc(doc)).toList());
    return Observable<List<Comments>>(stream).shareReplay(maxSize: 1);
  }

  @override
  Observable<List<ChatModel>> fetchChatPreviews(String uid) {
    final Stream<List<ChatModel>> stream = _firestore
        .collection(chatsCollection)
        .where('list_participants', arrayContains: uid)
        .orderBy('latest_message.sentAt', descending: true)
        // .limit(10)
        .snapshots(includeMetadataChanges: true)
        .map((snap) =>
            snap.documents.map((doc) => ChatModel.fromDoc(doc)).toList());
    return Observable<List<ChatModel>>(stream).shareReplay(maxSize: 1);
  }

  @override
  Observable<QuerySnapshot> fetchMessages(String collectionPath) {
    final CollectionReference reference = _firestore.collection(collectionPath);
    final Stream<QuerySnapshot> stream = reference
        .orderBy('sentAt', descending: true)
        // .limit(numLoaded)
        .snapshots();
    return Observable<QuerySnapshot>(stream).shareReplay(maxSize: 1);
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
  Observable<ProjectSignupModel> fetchProjectSignupById(
    String userId,
    ProjectModel project,
  ) {
    final Stream<ProjectSignupModel> stream = _firestore
        .collection(projectCollection)
        .document(project.docId)
        .collection('applications')
        .document(userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? ProjectSignupModel.fromDoc(snapshot) : null);
    return Observable<ProjectSignupModel>(stream).shareReplay(maxSize: 1);
  }

  @override
  Observable<List<ProjectSignupModel>> fetchProjectSignups(
      ProjectModel project) {
    final Stream<List<ProjectSignupModel>> stream = _firestore
        .collection(projectCollection)
        .document(project.docId)
        .collection('applications')
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((doc) => ProjectSignupModel.fromDoc(doc))
            .toList());
    return Observable<List<ProjectSignupModel>>(stream).shareReplay(maxSize: 1);
  }

  @override
  Observable<ThinkTankModel> fetchThinkTankStream(String docId) {
    final Stream<ThinkTankModel> stream = _firestore
        .collection(thinkTanksCollection)
        .document(docId)
        .snapshots()
        .map((doc) => ThinkTankModel.fromDoc(doc));
    return Observable<ThinkTankModel>(stream).shareReplay(maxSize: 1);
  }

  @override
  Future<List<Preview>> fetchAllUserAccounts(List<String> users) async {
    final List<Preview> _previews = [];
    for (String user in users) {
      DocumentSnapshot student =
          await _firestore.collection(studentsCollection).document(user).get();
      if (student.exists) {
        print('User is a student');
        final UserInfoModel model = UserInfoModel.fromDoc(student);
        _previews.add(
          Preview(
            givenName: model.givenName,
            imageUrl: model.mediaRef,
            uid: user,
            isStartup: false,
          ),
        );
      } else {
        print('User is a startup');
        DocumentSnapshot startup =
            await _firestore.collection(startupCollection).document(user).get();
        if (startup.exists) {
          final StartupInfoModel model = StartupInfoModel.fromDoc(startup);
          _previews.add(
            Preview(
              givenName: model.name,
              imageUrl: model.imageUrl,
              uid: user,
              isStartup: true,
            ),
          );
        }
      }
    }
    print(_previews.length.toString() + ' users found');
    return _previews;
  }

  @override
  Observable<List<ThinkTankModel>> fetchThinkTanksByOwnerStream(String uid,
      {QueryOrder order = QueryOrder.newest}) {
    final String field =
        order == QueryOrder.newest ? 'lastActivity' : 'commentCount';
    _firestore
        .collection(thinkTanksCollection)
        .where('askerId', isEqualTo: uid)
        .orderBy(field)
        .getDocuments()
        .then((v) => print(v.documents.length));
    final Stream<List<ThinkTankModel>> stream = _firestore
        .collection(thinkTanksCollection)
        .where('askerId', isEqualTo: uid)
        .orderBy(field)
        .snapshots()
        .map((snap) =>
            snap.documents.map((doc) => ThinkTankModel.fromDoc(doc)).toList());
    return Observable<List<ThinkTankModel>>(stream).shareReplay(maxSize: 1);
  }
}

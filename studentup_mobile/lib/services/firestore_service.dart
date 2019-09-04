import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/models/prize_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/project_signup_model.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';

final Firestore _firestore = Firestore.instance;

const String studentsCollection = 'students';
const String educationCollection = 'education_history';
const String experienceCollection = 'work_history';
const String startupCollection = 'startups';
const String prizesCollection = 'prizes';
const String projectCollection = 'projects';
const String projectSignupsCollection = 'project_signups';
const String thinkTanksCollection = 'think_tanks';
const String skillsCollection = 'skills';
const String chatsCollection = 'chats';
const String messagesCollection = 'messages';

class FirestoreReader {
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

  Stream<UserInfoModel> fetchUserInfoStream(DocumentReference doc) {
    try {
      return doc.snapshots().map((snapshot) => UserInfoModel.fromDoc(snapshot));
    } catch (e) {
      return Stream.empty();
    }
  }

  Stream<StartupInfoModel> fetchStartupInfoStream(DocumentReference doc) {
    try {
      return doc
          .snapshots()
          .map((snapshot) => StartupInfoModel.fromDoc(snapshot));
    } catch (e) {
      return Stream.empty();
    }
  }

  Stream<List<SkillsModel>> fetchSkills(String uid) {
    return _firestore
        .collection(skillsCollection)
        .where('user_id', isEqualTo: uid)
        .orderBy('avg_rating', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((doc) => SkillsModel.fromDoc(doc)).toList());
  }

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

  Stream<List<Comments>> fetchComments(CollectionReference reference) {
    return reference
        .orderBy('upvotes', descending: true)
        // .limit(10)
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((doc) => Comments.fromDoc(doc)).toList());
  }

  Stream<QuerySnapshot> fetchChatPreviews(String uid) {
    return _firestore
        .collection(chatsCollection)
        .where('list_participants', arrayContains: uid)
        .orderBy('latest_message.sentAt', descending: true)
        // .limit(10)
        .snapshots(includeMetadataChanges: true);
  }

  Stream<QuerySnapshot> fetchMessages(CollectionReference reference) {
    return reference
        .orderBy('sentAt', descending: true)
        // .limit(numLoaded)
        .snapshots();
  }

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

  Future createStartup(String uid, StartupInfoModel startup) async {
    try {
      await _firestore
          .collection(startupCollection)
          .document(uid)
          .setData(startup.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future updateProfileInfo(String uid, Map<String, dynamic> data) async {
    DocumentReference doc =
        _firestore.collection(studentsCollection).document(uid);

    Map result = await _firestore.runTransaction(
      (transaction) async {
        await transaction.update(doc, data);
      },
    );
    print(result);
  }

  Future postNewThinkTank(ThinkTanksModel model) async {
    await _firestore.collection(thinkTanksCollection).add(model.toJson());
  }

  Future removeThinkTank(ThinkTanksModel model) async {
    await _firestore
        .collection(thinkTanksCollection)
        .document(model.docId)
        .delete();
  }

  Future postNewSkill(SkillsModel model) async {
    await _firestore.collection(skillsCollection).add(model.toJson());
  }

  Future postNewEducation(EducationModel model) async {
    await _firestore.collection(educationCollection).add(model.toJson());
  }

  Future postNewExperience(LaborExeprienceModel model) async {
    await _firestore.collection(experienceCollection).add(model.toJson());
  }

  Future postNewTeamMember({
    UserInfoModel model,
    DocumentReference document,
  }) async {
    await document.updateData({
      'team.${model.docId}': Preview(
        givenName: model.givenName,
        imageUrl: model.mediaRef,
        uid: model.docId,
      ).toJson(),
    });
  }

  Future removeTeamMember({
    Preview model,
    DocumentReference document,
  }) async {
    await document.updateData({'team.${model.uid}': FieldValue.delete()});
  }

  Future postComment({Comments model, CollectionReference collection}) async {
    try {
      await collection.add(model.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future removeVoter(
      {CollectionReference collection,
      String docId,
      String uid,
      bool upvote}) async {
    try {
      await collection.document(docId).updateData(upvote
          ? {
              'upvotes': FieldValue.arrayRemove([uid])
            }
          : {
              'downvotes': FieldValue.arrayRemove([uid])
            });
    } catch (e) {
      throw e;
    }
  }

  Future addVoter(
      {CollectionReference collection,
      String docId,
      String uid,
      bool upvote}) async {
    try {
      await collection.document(docId).updateData(upvote
          ? {
              'upvotes': FieldValue.arrayUnion([uid])
            }
          : {
              'downvotes': FieldValue.arrayUnion([uid])
            });
    } catch (e) {
      throw e;
    }
  }

  Future createChatRoom({
    ChatModel chat,
    MessageModel initialMessage,
  }) async {
    try {
      DocumentReference newDoc =
          await _firestore.collection(chatsCollection).add(chat.toJson());
      final CollectionReference subcollectionRef =
          newDoc.collection('messages');
      await subcollectionRef.add(initialMessage.toJson());
      DocumentSnapshot snap = await newDoc.get();
      return ChatModel.fromDoc(snap);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> uploadMessage({
    MessageModel messageModel,
    CollectionReference to,
  }) async {
    try {
      await to.add(messageModel.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future removeConversation({
    CollectionReference conversation,
  }) async {
    try {
      await conversation.parent().delete();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future uploadProjectInformation({ProjectModel model}) async {
    try {
      await _firestore.collection(projectCollection).add(model.toJson());
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future uploadSignUpDocument(
          {ProjectSignupModel model, ProjectModel project}) async =>
      await _firestore
          .collection(projectCollection)
          .document(project.docId)
          .collection('applications')
          .document(Locator.of<AuthService>().currentUser.uid)
          .setData(model.toJson());

  Future removeApplicant(String projectId) async => await _firestore
      .collection(projectCollection)
      .document(projectId)
      .collection('applications')
      .document(Locator.of<AuthService>().currentUser.uid)
      .delete();

  Future removeProject({String id}) async =>
      await _firestore.collection(projectCollection).document(id).delete();
}

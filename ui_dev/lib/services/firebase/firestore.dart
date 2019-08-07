import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:ui_dev/enum/query_order.dart';
import 'package:ui_dev/enum/search_enum.dart';
import 'package:ui_dev/models/chat_model.dart';
import 'package:ui_dev/models/education_model.dart';
import 'package:ui_dev/models/labor_experience_model.dart';
import 'package:ui_dev/models/message_model.dart';
import 'package:ui_dev/models/prize_model.dart';
import 'package:ui_dev/models/project_model.dart';
import 'package:ui_dev/models/startup_info_model.dart';
import 'package:ui_dev/models/think_tank_model.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/error_handling/user_error.dart';
import 'package:ui_dev/test_data.dart';

const NUM_ITEM_PREVIEW = 8;
const NUM_ITEM_LIST = 20;

final String studentsCollection = 'students';
final String educationCollection = 'education_history';
final String experienceCollection = 'laboral_experiences';
final String startupCollection = 'startups';
final String prizesCollection = 'prizes';
final String projectCollection = 'projects';
final String projectSignupsCollection = 'project_signups';
final String thinkTanksCollection = 'think_tanks';
final String skillsCollection = 'skills';
final String chatsCollection = 'chats';
final String messagesCollection = 'messages';

//!!!TODO: Change all of the queries to transactions
class FirestoreReaderService {
  Firestore _firestore = Firestore.instance;

  Future<UserInfoModel> fetchUserInformation(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(studentsCollection).document(uid).get();
      if (snapshot == null)
        throw NetworkError('Something went wrong during your connection...');
      if (snapshot.data == null)
        throw UserDataError('You are not supposed to be here:)');
      return UserInfoModel.fromJson(snapshot);
    } catch (e) {
      print('(TRACE) ==== \n fetchStartups');
      print(e);
      return null;
    }
  }

  Future<List<EducationModel>> fetchEducation(String uid) async {
    final QuerySnapshot snapshot = await _firestore
        .collection(educationCollection)
        .where('user_id', isEqualTo: uid)
        .orderBy('period_start', descending: true)
        .getDocuments();
    if (snapshot == null || snapshot.documents == null)
      throw NetworkError('Server returned a malformed response');
    return snapshot.documents
        .map((doc) => EducationModel.fromJson(doc.data))
        .toList();
  }

  Future<List<LaborExeprienceModel>> fetchExperience(String uid) async {
    final QuerySnapshot snapshot = await _firestore
        .collection(experienceCollection)
        .orderBy('period_start', descending: true)
        .where('user_id', isEqualTo: uid)
        .getDocuments();
    if (snapshot == null || snapshot.documents == null)
      throw NetworkError('Server returned a malformed response');
    return snapshot.documents
        .map((doc) => LaborExeprienceModel.fromJson(doc.data))
        .toList();
  }

  Future<List<StartupInfoModel>> fetchStartups(QueryOrder order) async {
    try {
      // String field = QueryOrder.newest == order ? 'timestamps' : 'interactions';
      QuerySnapshot snapshot = await _firestore
          .collection(startupCollection)
          //.orderBy(field)
          .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      if (snapshot == null || snapshot.documents == null)
        throw NetworkError('');
      return snapshot.documents
          .map((doc) => StartupInfoModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      print('(TRACE) ==== \n fetchStartups');
      print(e);
      return <StartupInfoModel>[];
    }
  }

  Future<List<PrizeModel>> fetchPrizes(QueryOrder order) async {
    try {
      // String field = QueryOrder.newest == order ? 'timestamps' : 'interactions';
      QuerySnapshot snapshot = await _firestore
          .collection(prizesCollection)
          //.orderBy(field)
          .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      if (snapshot == null || snapshot.documents == null)
        throw NetworkError('');
      return snapshot.documents
          .map((doc) => PrizeModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      // ? How do I return a network error to be shown
      print('(TRACE) ==== \n fetchPrizes');
      print(e);
      return <PrizeModel>[];
    }
  }

  Future<List<ProjectModel>> fetchProjects(QueryOrder order) async {
    try {
      // String field = QueryOrder.newest == order ? 'timestamps' : 'interactions';
      // ? Can I rearrange the query to be sorted by creation date without having to store the timestamp
      QuerySnapshot snapshot = await _firestore
          .collection(projectCollection)
          //.orderBy(field)
          .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      if (snapshot == null || snapshot.documents == null)
        throw NetworkError('');
      List<ProjectModel> _projects = [];
      for (DocumentSnapshot doc in snapshot.documents) {
        QuerySnapshot joinData = await _firestore
            .collection(projectSignupsCollection)
            .where('project_id', isEqualTo: doc.documentID)
            .where('user_id', isEqualTo: TestData.userId)
            .getDocuments();
        assert(
          joinData.documents.length == 0 || joinData.documents.length == 1,
          'Too many signup documents were found. Only 1 can exist.',
        );
        _projects.add(
          ProjectModel.fromJson(doc.data, joinData.documents.length == 1),
        );
      }
      return _projects;
    } catch (e) {
      // ? How do I return a network error to be shown
      print('(TRACE) ==== \n fetchProjects');
      print(e);
      return <ProjectModel>[];
    }
  }

  Future<List<ThinkTanksModel>> fetchThinkTanks(QueryOrder order) async {
    try {
      // String field = QueryOrder.newest == order ? 'timestamps' : 'interactions';
      QuerySnapshot snapshot = await _firestore
          .collection(thinkTanksCollection)
          //.orderBy(field)
          .limit(NUM_ITEM_PREVIEW)
          .getDocuments();
      if (snapshot == null || snapshot.documents == null)
        throw NetworkError('');
      return snapshot.documents
          .map((doc) => ThinkTanksModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      print('(TRACE) ==== \n fetchThinkTanks');
      print(e);
      return <ThinkTanksModel>[];
    }
  }

  Future<List<UserInfoModel>> fetchUsersByCategory(
      SearchCategory category) async {
    try {
      // String field = QueryOrder.newest == order ? 'timestamps' : 'interactions';
      QuerySnapshot snapshot = await _firestore
          .collection(studentsCollection)
          //.orderBy(field)
          .limit(NUM_ITEM_LIST)
          .getDocuments();
      if (snapshot == null || snapshot.documents == null)
        throw NetworkError('');
      return snapshot.documents
          .map((doc) => UserInfoModel.fromJson(doc))
          .toList();
    } catch (e) {
      print('(TRACE) ==== \n fetchUsersByCategory');
      print(e);
      return <UserInfoModel>[];
    }
  }

  Future<List<UserInfoModel>> fetchUsersByQueryAndCategory(
      String query, SearchCategory category) async {
    try {
      QuerySnapshot skills = await _firestore
          .collection(skillsCollection)
          .where('category', isEqualTo: category)
          .orderBy('user_id')
          .startAt([query])
          .endAt([query + '\uf8ff'])
          .limit(NUM_ITEM_LIST)
          .getDocuments();
      if (skills == null || skills.documents == null) throw NetworkError('');
      List<String> usersIds = [];
      skills.documents.forEach((doc) {
        if (doc.data == null || doc.data['user_id'] == null) return;
        if (!usersIds.contains(doc.data['user_id']))
          usersIds.add(doc.data['user_id']);
      });
      List<DocumentSnapshot> students = await Future.forEach(
        usersIds,
        (id) async {
          return await _firestore
              .collection(studentsCollection)
              .document(id)
              .get();
        },
      );
      if (students == null) throw NetworkError('');
      return students.map((doc) => UserInfoModel.fromJson(doc)).toList();
    } catch (e) {
      print('(TRACE) ==== \n fetchUsersByQueryAndCategory');
      print(e);
      return <UserInfoModel>[];
    }
  }

  Future<List<UserInfoModel>> fetchUsersByQuery(String query) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(studentsCollection)
          .orderBy('user_id')
          .startAt([query])
          .endAt([query + '\uf8ff'])
          .limit(NUM_ITEM_LIST)
          .getDocuments();
      if (snapshot == null || snapshot.documents == null)
        throw NetworkError('');
      return snapshot.documents
          .map((doc) => UserInfoModel.fromJson(doc))
          .toList();
    } catch (e) {
      print('(TRACE) ==== \n fetchUsersByQueryAndCategory');
      print(e);
      return <UserInfoModel>[];
    }
  }

  Stream<List<MessageModel>> fetchMessages(CollectionReference collection) {
    return collection.orderBy('sentAt', descending: true).snapshots().map(
          (snapshot) => snapshot.documents
              .map((doc) => MessageModel.fromJson(doc))
              .toList(),
        );
  }

  Future<List<ChatModel>> fetchConversations(String uid) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('chats')
          .where('participants', arrayContains: uid)
          .getDocuments();
      if (snapshot == null || snapshot.documents == null)
        throw NetworkError('Something went wrong...');
      List<ChatModel> conversations = snapshot.documents
          .map((doc) => ChatModel.fromJson(doc, uid))
          .toList();
      for (ChatModel convo in conversations) {
        print(convo.docId);
        String otherId =
            convo.participants.firstWhere((id) => id != uid, orElse: () => uid);
        convo.other = await fetchUserInformation(otherId);
        QuerySnapshot snap = await convo.messagesCollection
            .orderBy('sentAt', descending: true)
            .limit(1)
            .getDocuments();
        convo.lastMessage = MessageModel.fromJson(snap.documents.first);
      }
      return conversations;
    } on PlatformException {
      throw NetworkError('Couldn\'t find the resources requested');
    }
  }
}

class FirestoreUploadService {
  Firestore _firestore = Firestore.instance;

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

  Future uploadMessage({
    @required MessageModel messageModel,
    @required CollectionReference to,
  }) async =>
      await to.add(messageModel.toJson());

  Future removeConversation(CollectionReference collection) async {
    await collection.parent().delete();
  }
}

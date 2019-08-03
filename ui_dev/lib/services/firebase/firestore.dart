import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_dev/enum/query_order.dart';
import 'package:ui_dev/enum/search_enum.dart';
import 'package:ui_dev/models/prize_model.dart';
import 'package:ui_dev/models/project_model.dart';
import 'package:ui_dev/models/startup_info_model.dart';
import 'package:ui_dev/models/think_tank_model.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/test_data.dart';

const NUM_ITEM_PREVIEW = 8;
const NUM_ITEM_LIST = 20;

class FirestoreReaderService {
  static final String studentsCollection = 'students';
  static final String startupCollection = 'startups';
  static final String prizesCollection = 'prizes';
  static final String projectCollection = 'projects';
  static final String projectSignupsCollection = 'project_signups';
  static final String thinkTanksCollection = 'think_tanks';

  Firestore _firestore = Firestore.instance;

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
          .map((doc) => UserInfoModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      print('(TRACE) ==== \n fetchUsersByCategory');
      print(e);
      return <UserInfoModel>[];
    }
  }
}

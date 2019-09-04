import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:studentup_mobile/input_blocs/user_profile_edit_bloc.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class ProfileNotifier extends NetworkNotifier {
  String _userId;

  FirestoreReader _firestoreReader;
  FirestoreWriter _firestoreWriter;
  UserProfileEditBloc _userProfileEditBloc;

  DocumentReference _userDocument;
  bool _isStartup;
  Preview _preview;

  ProfileNotifier([String uid]) {
    _userId = uid;
    _firestoreReader = Locator.of<FirestoreReader>();
    _firestoreWriter = Locator.of<FirestoreWriter>();
    _userProfileEditBloc = UserProfileEditBloc();
  }

  bool get isStartup => _isStartup;
  Preview get info => _preview;

  UserProfileEditBloc get userBloc => _userProfileEditBloc;

  //USER INFORMATION
  Stream<UserInfoModel> get userInfoStream =>
      _firestoreReader.fetchUserInfoStream(_userDocument).asBroadcastStream();
  Stream<List<EducationModel>> get education =>
      _firestoreReader.fetchEducation(_userId);
  Stream<List<LaborExeprienceModel>> get experience =>
      _firestoreReader.fetchExperience(_userId);
  Stream<List<SkillsModel>> get skills => _firestoreReader.fetchSkills(_userId);

  //STARTUP INFORMATION
  Stream<StartupInfoModel> get startupInfoStream => _firestoreReader
      .fetchStartupInfoStream(_userDocument)
      .asBroadcastStream();
  Stream<List<ProjectModel>> get ongoingProjects =>
      _firestoreReader.fetchOngoingProjects(_userId);

  Stream<List<ProjectModel>> get pastProjects =>
      _firestoreReader.fetchPastProjects(_userId);

  set preview(dynamic value) {
    if (value is UserInfoModel)
      _preview = Preview(
        uid: value.docId,
        givenName: value.givenName,
        imageUrl: value.mediaRef,
      );
    else if (value is StartupInfoModel)
      _preview = Preview(
        uid: value.docId,
        givenName: value.name,
        imageUrl: value.imageUrl,
      );
    notifyListeners();
  }

  @override
  Future onRefresh() async => fetchData();

  @override
  Future fetchData([dynamic data]) async {
    isLoading = true;
    _userId ??= Locator.of<AuthService>().currentUser.uid;
    try {
      final Map<DocumentReference, bool> result =
          await _firestoreReader.findUserDocument(_userId);
      _userDocument = result.keys.length > 0 ? result.keys.first : null;
      _isStartup = result.values.length > 0 ? result.values.first : false;
      if (_isStartup)
        startupInfoStream.listen((data) => preview = data);
      else
        userInfoStream.listen((data) => preview = data);
    } on PlatformException catch (pe) {
      error = NetworkError(message: pe.message + '\n' + pe.details);
    } catch (e) {
      print(e);
      error = NetworkError(message: 'Unknown Error');
    }
    isLoading = false;
  }

  @override
  void dispose() {
    _userProfileEditBloc.dispose();
    super.dispose();
  }

  void logout() {
    _userId = null;
  }

  Future uploadEditorInfo() async {
    if (isStartup) {
    } else {}
  }

  void clearEditor() async {
    if (isStartup) {
    } else {}
  }

  Future addTeamMember(UserInfoModel model) async {
    isLoading = true;
    try {
      await _firestoreWriter.postNewTeamMember(
        model: model,
        document: _userDocument,
      );
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }

  Future removeTeamMember(Preview model) async {
    isLoading = true;
    try {
      await _firestoreWriter.removeTeamMember(
        model: model,
        document: _userDocument,
      );
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }
}

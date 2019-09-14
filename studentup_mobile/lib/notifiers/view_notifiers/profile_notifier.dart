import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/input_blocs/user_profile_edit_bloc.dart';
import 'package:studentup_mobile/mixins/storage_io.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/notifications/notification_service.dart';
import 'package:studentup_mobile/services/storage/firebase/firebase_storage.dart';

class ProfileNotifier extends NetworkIO with UserProfileEditBloc, StorageIO {
  String _userId;

  DocumentReference _userDocument;
  bool _isStartup;
  Preview _preview;

  ProfileNotifier([String uid]) : _userId = uid;

  bool get isStartup => _isStartup;
  Preview get info => _preview;

  //USER INFORMATION
  Stream<UserInfoModel> get userInfoStream =>
      reader.fetchUserInfoStream(_userDocument?.path).asBroadcastStream();
  Stream<List<EducationModel>> get education => reader.fetchEducation(_userId);
  Stream<List<LaborExeprienceModel>> get experience =>
      reader.fetchExperience(_userId);
  Stream<List<SkillsModel>> get skills => reader.fetchSkills(_userId);

  //STARTUP INFORMATION
  Stream<StartupInfoModel> get startupInfoStream =>
      reader.fetchStartupInfoStream(_userDocument?.path).asBroadcastStream();
  Stream<List<ProjectModel>> get ongoingProjects =>
      reader.fetchOngoingProjects(_userId);
  Stream<List<ProjectModel>> get pastProjects =>
      reader.fetchPastProjects(_userId);

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
  void dispose() {
    disposeMixin();
    super.dispose();
  }

  @override
  Future fetchData([dynamic data]) async {
    if (Locator.of<AuthService>()?.currentUser?.uid == null) return;
    isReading = true;
    _userId ??= Locator.of<AuthService>().currentUser.uid;
    try {
      final Map<dynamic, bool> result = await reader.findUserDocument(_userId);
      _userDocument = result.keys.length > 0
          ? result.keys.first as DocumentReference
          : null;
      _isStartup = result.values.length > 0 ? result.values.first : false;
      if (_isStartup)
        startupInfoStream.listen((data) => preview = data);
      else
        userInfoStream.listen((data) => preview = data);
      initializeMixin(isStartup: _isStartup);
      await sendData();
    } catch (e) {
      print(e);
      readError = NetworkError(message: e.toString());
    }
    isReading = false;
  }

  @override
  Future<bool> sendData([data]) async {
    if (_userId != Locator.of<AuthService>().currentUser.uid) return false;
    try {
      switch (data.runtimeType) {
        case UserInfoModel:
          await _addTeamMember(data);
          break;
        case Preview:
          await _removeTeamMember(data);
          break;
        case bool:
          await _editProfile(data);
          break;
        case Null:
          await _updateNotificationTokens();
          break;
        default:
          throw 'No Action for Type: ${data.runtimeType}';
      }
    } catch (e) {
      print(e);
      writeError = NetworkError(message: e.toString());
      return false;
    }
    return true;
  }

  Future<void> logout() async {
    _userId = null;
    await writer.updateNotificationTokens(
      docPath: _userDocument.path,
      token: Locator.of<NotificationService>().deviceToken,
      remove: true,
    );
  }

  Future _addTeamMember(UserInfoModel model) async {
    isWriting = true;
    await writer.postNewTeamMember(
      model: model,
      docPath: _userDocument.path,
    );
    isWriting = false;
  }

  Future _removeTeamMember(Preview model) async {
    isWriting = true;
    await writer.removeTeamMember(
      model: model,
      docPath: _userDocument.path,
    );
    isWriting = false;
  }

  Future _editProfile(bool isStudent) async {
    isWriting = true;
    if (image != null) {
      print('started uploading');
      final List<String> paths =
          await storage.upload(files: [image], location: profilesFolder);
      print('done uploading');
      if (paths.isNotEmpty) {
        await writer.updateProfileInfo(
          docPath: _userDocument.path,
          data: editorData
            ..addAll(
                {'${_isStartup ? 'image_url' : 'media_ref'}': paths.first}),
        );
      }
    } else {
      await writer.updateProfileInfo(
        docPath: _userDocument.path,
        data: editorData,
      );
    }
    isWriting = false;
  }

  Future _updateNotificationTokens() async {
    if (_userId == Locator.of<AuthService>().currentUser.uid)
      await writer.updateNotificationTokens(
        docPath: _userDocument.path,
        token: Locator.of<NotificationService>().deviceToken,
      );
  }
}

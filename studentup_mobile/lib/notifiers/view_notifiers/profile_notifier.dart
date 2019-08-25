import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/util.dart';

// ? TODO: auth/linkedin
class ProfileNotifier extends NetworkNotifier {
  String _uid;
  UserInfoModel _infoModel;
  List<SkillsModel> _skills;
  List<EducationModel> _education;
  List<LaborExeprienceModel> _experience;

  FirestoreReader _firestore;
  FirestoreWriter _firestoreUpload;

  TextEditingController _nameEditor;
  TextEditingController _universityEditor;
  TextEditingController _locationEditor;
  TextEditingController _bioEditor;

  ProfileNotifier() {
    _firestore = FirestoreReader();
    _firestoreUpload = FirestoreWriter();
    _uid = 'sYP0IBARJtdYj9apnwYD'; //Locator.of<AuthService>().currentUser.uid;
    _education = [];
    _experience = [];
    _nameEditor = TextEditingController();
    _universityEditor = TextEditingController();
    _locationEditor = TextEditingController();
    _bioEditor = TextEditingController();
    fetchData();
  }

  TextEditingController get nameEditor => _nameEditor;
  TextEditingController get universityEditor => _universityEditor;
  TextEditingController get locationEditor => _locationEditor;
  TextEditingController get bioEditor => _bioEditor;

  bool get _noChanges =>
      _nameEditor.text.isEmpty &&
      _universityEditor.text.isEmpty &&
      _locationEditor.text.isEmpty &&
      _bioEditor.text.isEmpty;

  UserInfoModel get info => _infoModel;
  List<SkillsModel> get skills => isLoading || hasError ? [] : _skills;
  List<EducationModel> get education => isLoading || hasError ? [] : _education;
  List<LaborExeprienceModel> get experience =>
      isLoading || hasError ? [] : _experience;

  @override
  Future onRefresh() async => fetchData();

  @override
  Future fetchData([dynamic data]) async {
    isLoading = true;
    try {
      if (_infoModel == null) _infoModel = await _firestore.fetchUser(_uid);
      _infoModel.locationString =
          await Util.geoPointToLocation(_infoModel.location);
      _skills = await _firestore.fetchSkills(_uid);
      _education = await _firestore.fetchEducation(_uid);
      _experience = await _firestore.fetchExperience(_uid);
    } on PlatformException catch (pe) {
      error = NetworkError(message: pe.message + '\n' + pe.details);
    } catch (e) {
      print(e);
      error = NetworkError(message: 'Unknown Error');
    }
    isLoading = false;
  }

  Future fetchInfoData() async {
    isLoading = true;
    try {
      _infoModel = await _firestore.fetchUser(_uid);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }

  Map<String, dynamic> _getData() {
    Map<String, dynamic> data = {};
    if (_nameEditor.text.isNotEmpty) data['given_name'] = _nameEditor.text;
    if (_universityEditor.text.isNotEmpty)
      data['university'] = _universityEditor.text;
    //if (_locationEditor.text.isNotEmpty)
    //  data['location'] = _locationEditor.text;
    if (_bioEditor.text.isNotEmpty) data['bio'] = _bioEditor.text;
    return data;
  }

  Future uploadEditorInfo() async {
    if (_noChanges) return;
    isLoading = true;
    try {
      await _firestoreUpload.updateProfileInfo(
        _uid,
        _getData(),
      );
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    fetchInfoData();
  }

  void clearEditor() {
    _nameEditor.clear();
    _universityEditor.clear();
    _locationEditor.clear();
    _bioEditor.clear();
  }
}

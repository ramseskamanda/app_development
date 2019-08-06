import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_dev/models/education_model.dart';
import 'package:ui_dev/models/labor_experience_model.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/error_handling/unknown_view_error.dart';
import 'package:ui_dev/notifiers/error_handling/view_error.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

// ? TODO: auth/linkedin
// * TODO: skills
class ProfileNotifier extends ViewNotifier {
  String _uid;
  UserInfoModel _infoModel;
  List<EducationModel> _education;
  List<LaborExeprienceModel> _experience;

  FirestoreReaderService _firestoreService;
  FirestoreUploadService _firestoreUploadService;

  TextEditingController _nameEditor;
  TextEditingController _universityEditor;
  TextEditingController _locationEditor;
  TextEditingController _bioEditor;

  ProfileNotifier({@required String uid}) {
    _firestoreService = FirestoreReaderService();
    _firestoreUploadService = FirestoreUploadService();
    _uid = uid;
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
  List<EducationModel> get education => isLoading || hasError ? [] : _education;
  List<LaborExeprienceModel> get experience =>
      isLoading || hasError ? [] : _experience;

  @override
  Future onRefresh() async => fetchData();

  @override
  Future fetchData([dynamic data]) async {
    isLoading = true;
    try {
      if (_infoModel == null)
        _infoModel = await _firestoreService.fetchUserInformation(_uid);
      _education = await _firestoreService.fetchEducation(_uid);
      _experience = await _firestoreService.fetchExperience(_uid);
    } on PlatformException catch (pe) {
      error = NetworkError(pe.message + '\n' + pe.details);
    } catch (e) {
      if (e.runtimeType is ViewError)
        error = e;
      else {
        print(e);
        error = UnknownViewError();
      }
    }
    isLoading = false;
  }

  Future fetchInfoData() async {
    isLoading = true;
    try {
      _infoModel = await _firestoreService.fetchUserInformation(_uid);
    } catch (e) {
      if (e is PlatformException) error = NetworkError(e.code);
      if (e is ViewError)
        error = e;
      else
        error = UnknownViewError();
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
      await _firestoreUploadService.updateProfileInfo(
        _uid,
        _getData(),
      );
    } catch (e) {
      if (e is PlatformException) error = NetworkError(e.code);
      if (e is ViewError)
        error = e;
      else
        error = UnknownViewError();
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

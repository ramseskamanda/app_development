import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/firestore_service.dart';

class StartupPageNotifier extends NetworkNotifier {
  StartupInfoModel _model;
  //team members
  List<UserInfoModel> _team;
  //ongoing projects
  List<ProjectModel> _projects;

  FirestoreReader _firestoreReader;

  StartupPageNotifier(StartupInfoModel model) {
    _team = [];
    _projects = [];
    _model = model;
    _firestoreReader = FirestoreReader();
    fetchData();
  }

  List<UserInfoModel> get team => !(isLoading || hasError) ? _team : [];
  List<ProjectModel> get projects => !(isLoading || hasError) ? _projects : [];

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _team = await _firestoreReader.fetchAllUsers(_model.team);
      // _projects = await _firestoreReader.fetchProjectsByOwner(_model.docId);
    } catch (e) {
      print(e);
      error = NetworkError(message: 'Something went wrong...');
    }
    isLoading = false;
  }

  @override
  Future onRefresh() => fetchData();
}

import 'package:ui_dev/models/project_model.dart';
import 'package:ui_dev/models/startup_info_model.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class StartupPageNotifier extends ViewNotifier {
  StartupInfoModel _model;
  //team members
  List<UserInfoModel> _team;
  //ongoing projects
  List<ProjectModel> _projects;

  FirestoreReaderService _firestoreReaderService;

  StartupPageNotifier(StartupInfoModel model) {
    _team = [];
    _projects = [];
    _model = model;
    _firestoreReaderService = FirestoreReaderService();
    fetchData();
  }

  List<UserInfoModel> get team => !(isLoading || hasError) ? _team : [];
  List<ProjectModel> get projects => !(isLoading || hasError) ? _projects : [];

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _team = await _firestoreReaderService.fetchAllUsersIn(_model.team);
      _projects =
          await _firestoreReaderService.fetchProjectsByOwner(_model.docId);
      if (_team == null || _projects == null)
        error = NetworkError('Something went terribly wrong...');
    } catch (e) {
      print(e);
      error = (e is NetworkError) ? e : NetworkError('Something went wrong...');
    }
    isLoading = false;
  }

  @override
  Future onRefresh() => fetchData();
}

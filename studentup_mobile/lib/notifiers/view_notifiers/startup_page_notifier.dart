import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';

class StartupPageNotifier extends NetworkReader {
  StartupInfoModel _model;
  //team members
  List<Preview> _team;
  //ongoing projects
  List<ProjectModel> _projects;

  StartupPageNotifier(StartupInfoModel model) {
    _team = [];
    _projects = [];
    _model = model;
    fetchData();
  }

  Stream<StartupInfoModel> get startupStream =>
      reader.fetchStartupInfoStream('/startups/${_model.docId}');
  List<Preview> get team => !(isLoading || hasError) ? _team : [];
  List<ProjectModel> get ongoingProjects => !(isLoading || hasError)
      ? _projects.where((m) => m.deadline.isAfter(DateTime.now())).toList()
      : [];
  List<ProjectModel> get pastProjects => !(isLoading || hasError)
      ? _projects.where((m) => m.deadline.isBefore(DateTime.now())).toList()
      : [];

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _team = _model.team;
      //TODO: Change this to use a stream
      _projects = await reader.fetchProjectsByOwner(_model.docId);
    } catch (e) {
      print(e);
      error = NetworkError(message: 'Something went wrong...');
    }
    isLoading = false;
  }
}

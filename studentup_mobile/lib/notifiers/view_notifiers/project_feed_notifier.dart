import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';

class ProjectFeedNotifier extends NetworkReader {
  List<ProjectModel> _projects;

  ProjectFeedNotifier() {
    _projects = <ProjectModel>[];
    fetchData();
  }

  List<ProjectModel> get projects =>
      isLoading || hasError || _projects == null ? [] : _projects;

  @override
  Future fetchData([dynamic data]) async {
    isLoading = true;
    try {
      //fetch projects data
      _projects = await reader.fetchProjects(QueryOrder.newest);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }
}

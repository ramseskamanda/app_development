import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/util/user_config.dart';

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
      QueryOrder _order = Locator.of<LocalStorageService>()
                  .getFromUserDisk(PROJECTS_QUERY_ORDER) ??
              false
          ? QueryOrder.popularity
          : QueryOrder.newest;
      _projects = await reader.fetchProjects(_order);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }
}

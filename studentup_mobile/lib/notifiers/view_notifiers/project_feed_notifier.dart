import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class ProjectFeedNotifier extends NetworkNotifier {
  List<ProjectModel> _projects;
  FirestoreReader _firestoreService;

  ProjectFeedNotifier() {
    _projects = <ProjectModel>[];
    _firestoreService = Locator.of<FirestoreReader>();
    fetchData();
  }

  List<ProjectModel> get projects =>
      isLoading || hasError || _projects == null ? [] : _projects;

  @override
  Future onRefresh() async => fetchData();

  @override
  Future fetchData([dynamic data]) async {
    isLoading = true;
    try {
      //fetch projects data
      _projects = await _firestoreService.fetchProjects(QueryOrder.newest);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }
}

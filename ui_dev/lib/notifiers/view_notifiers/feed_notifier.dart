import 'package:ui_dev/enum/query_order.dart';
import 'package:ui_dev/models/prize_model.dart';
import 'package:ui_dev/models/project_model.dart';
import 'package:ui_dev/models/startup_info_model.dart';
import 'package:ui_dev/models/think_tank_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class FeedNotifier extends ViewNotifier {
  List<StartupInfoModel> _startups;
  List<PrizeModel> _prizes;
  List<ProjectModel> _projects;
  List<ThinkTanksModel> _thinkTanks;
  FirestoreReaderService _firestoreService;

  FeedNotifier() {
    _startups = <StartupInfoModel>[];
    _prizes = <PrizeModel>[];
    _projects = <ProjectModel>[];
    _thinkTanks = <ThinkTanksModel>[];
    _firestoreService = FirestoreReaderService();
    fetchData();
  }

  List<StartupInfoModel> get startups => isLoading || hasError ? [] : _startups;
  List<PrizeModel> get prizes => isLoading || hasError ? [] : _prizes;
  List<ProjectModel> get projects => isLoading || hasError ? [] : _projects;
  List<ThinkTanksModel> get thinkTanks =>
      isLoading || hasError ? [] : _thinkTanks;

  @override
  Future onRefresh() async => fetchData();

  @override
  Future fetchData([dynamic data]) async {
    isLoading = true;
    //fetch startup data
    _startups = await _firestoreService.fetchStartups(QueryOrder.newest);
    //fetch prize data
    _prizes = await _firestoreService.fetchPrizes(QueryOrder.popularity);
    //fetch project data
    _projects = await _firestoreService.fetchProjects(QueryOrder.popularity);
    //fetch think tanks data
    _thinkTanks =
        await _firestoreService.fetchThinkTanks(QueryOrder.popularity);
    isLoading = false;
  }
}

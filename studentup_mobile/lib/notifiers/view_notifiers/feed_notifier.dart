import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/util/util.dart';

class FeedNotifier extends NetworkNotifier {
  List<StartupInfoModel> _startups;
  List<ThinkTanksModel> _thinkTanks;
  FirestoreReader _firestoreService;

  FeedNotifier() {
    _startups = <StartupInfoModel>[];
    _thinkTanks = <ThinkTanksModel>[];
    _firestoreService = FirestoreReader();
    fetchData();
  }

  List<StartupInfoModel> get startups => isLoading || hasError ? [] : _startups;
  List<ThinkTanksModel> get thinkTanks =>
      isLoading || hasError ? [] : _thinkTanks;

  @override
  Future onRefresh() async => fetchData();

  @override
  Future fetchData([dynamic data]) async {
    isLoading = true;
    try {
      //fetch startup data
      _startups = await _firestoreService.fetchStartups(QueryOrder.newest);
      _startups.forEach((model) async {
        model.locationString = await Util.geoPointToLocation(model.location);
      });
      //fetch think tanks data
      _thinkTanks =
          await _firestoreService.fetchThinkTanks(QueryOrder.popularity);
    } catch (e) {
      if (!e is NetworkError)
        error = NetworkError(message: 'Unknown Error Occured');
      error = e;
    }
    isLoading = false;
  }
}

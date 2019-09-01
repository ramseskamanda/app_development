import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/util.dart';

class FeedNotifier extends NetworkNotifier {
  List<StartupInfoModel> _startups;
  List<ThinkTanksModel> _thinkTanks;
  FirestoreReader _firestoreReader;
  FirestoreWriter _firestoreWriter;

  FeedNotifier() {
    _startups = <StartupInfoModel>[];
    _thinkTanks = <ThinkTanksModel>[];
    _firestoreReader = Locator.of<FirestoreReader>();
    _firestoreWriter = Locator.of<FirestoreWriter>();
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
      _startups = await _firestoreReader.fetchStartups(QueryOrder.newest);
      _startups.forEach((model) async {
        model.locationString = await Util.geoPointToLocation(model.location);
      });
      //fetch think tanks data
      _thinkTanks =
          await _firestoreReader.fetchThinkTanks(QueryOrder.popularity);
    } catch (e) {
      if (!e is NetworkError)
        error = NetworkError(message: 'Unknown Error Occured');
      error = e;
    }
    isLoading = false;
  }

  Future<bool> delete(ThinkTanksModel model) async {
    try {
      await _firestoreWriter.removeThinkTank(model);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
      return false;
    }
    return true;
  }
}

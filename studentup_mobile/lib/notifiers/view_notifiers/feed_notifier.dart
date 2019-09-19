import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/util/user_config.dart';

class FeedNotifier extends NetworkIO {
  List<StartupInfoModel> _startups;
  List<ThinkTankModel> _thinkTanks;

  FeedNotifier() {
    _startups = <StartupInfoModel>[];
    _thinkTanks = <ThinkTankModel>[];
    fetchData();
  }

  List<StartupInfoModel> get startups => isLoading || hasError ? [] : _startups;
  List<ThinkTankModel> get thinkTanks =>
      isLoading || hasError ? [] : _thinkTanks;

  @override
  Future fetchData([dynamic data]) async {
    isReading = true;
    try {
      //fetch startup data
      //TODO: Fix this to sort startups by a new metric of success
      // QueryOrder _startupsOrder = Locator.of<LocalStorageService>()
      //             .getFromUserDisk(STARTUP_BADGES_QUERY_ORDER) ??
      //         false
      //     ? QueryOrder.popularity
      //     : QueryOrder.newest;
      _startups = await reader.fetchStartups(QueryOrder.newest);
      //fetch think tanks data
      QueryOrder _tanksOrder = Locator.of<LocalStorageService>()
                  .getFromUserDisk(THINK_TANK_QUERY_ORDER) ??
              false
          ? QueryOrder.newest
          : QueryOrder.popularity;
      _thinkTanks = await reader.fetchThinkTanks(_tanksOrder);
    } catch (e) {
      readError = NetworkError(message: e.toString());
    }
    isReading = false;
  }

  @override
  Future<bool> sendData([dynamic model]) async {
    try {
      await writer.removeThinkTank(model as ThinkTankModel);
    } catch (e) {
      print(e);
      writeError = NetworkError(message: e.toString());
      return false;
    }
    return true;
  }
}

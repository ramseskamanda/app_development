import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';

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
      _startups = await reader.fetchStartups(QueryOrder.newest);
      //fetch think tanks data
      _thinkTanks = await reader.fetchThinkTanks(QueryOrder.newest);
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

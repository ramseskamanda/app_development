import 'package:studentup_mobile/models/prize_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';

class PrizeNotifier extends NetworkReader {
  //prizes
  List<PrizeModel> _prizes;
  BaseAPIReader _firestoreReader;

  PrizeNotifier() {
    _firestoreReader = Locator.of<BaseAPIReader>();
    _prizes = [];
    fetchData();
  }

  List<PrizeModel> get prizes => _prizes;

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _prizes = await _firestoreReader.fetchPrizesRanking();
    } catch (e) {
      print(e);
      error = NetworkError(message: 'Something went wrong...');
    }
    isLoading = false;
  }
}

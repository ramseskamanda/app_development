import 'package:ui_dev/models/prize_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class PrizeNotifier extends ViewNotifier {
  //prizes
  List<PrizeModel> _prizes;
  FirestoreReaderService _firestoreReaderService;

  PrizeNotifier() {
    _firestoreReaderService = FirestoreReaderService();
    _prizes = [];
    fetchData();
  }

  List<PrizeModel> get prizes => _prizes;

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _prizes = await _firestoreReaderService.fetchPrizesRanking();
      if (_prizes == null)
        error = NetworkError('Something went terribly wrong');
    } catch (e) {
      print(e);
      error = NetworkError('Something went wrong...');
    }
    isLoading = false;
  }

  @override
  Future onRefresh() => fetchData();
}

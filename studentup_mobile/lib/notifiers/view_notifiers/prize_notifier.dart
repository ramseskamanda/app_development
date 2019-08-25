import 'package:studentup_mobile/models/prize_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/firestore_service.dart';

class PrizeNotifier extends NetworkNotifier {
  //prizes
  List<PrizeModel> _prizes;
  FirestoreReader _firestoreReader;

  PrizeNotifier() {
    _firestoreReader = FirestoreReader();
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

  @override
  Future onRefresh() => fetchData();
}

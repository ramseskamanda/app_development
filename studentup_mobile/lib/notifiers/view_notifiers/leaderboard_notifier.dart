import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/firestore_service.dart';

class LeaderboardNotifier extends NetworkNotifier {
  bool _monthly;
  List<UserInfoModel> _leaderboard;
  FirestoreReader _firestoreReader;

  LeaderboardNotifier(bool monthly) {
    _monthly = monthly;
    _leaderboard = [];
    _firestoreReader = FirestoreReader();
    fetchData();
  }

  bool get monthly => _monthly;
  List<UserInfoModel> get leaderboard =>
      !(isLoading || hasError || _leaderboard == null) ? _leaderboard : [];

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _leaderboard = await _firestoreReader.fetchRankings(monthly: _monthly);
    } catch (e) {
      print(e);
      error = NetworkError(message: 'Something went wrong...');
    }
    isLoading = false;
  }

  @override
  Future onRefresh() => fetchData();
}

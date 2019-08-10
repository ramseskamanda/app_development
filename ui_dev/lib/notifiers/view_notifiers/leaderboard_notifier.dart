import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

class LeaderboardNotifier extends ViewNotifier {
  bool _monthly;
  List<UserInfoModel> _leaderboard;
  FirestoreReaderService _firestoreReaderService;

  LeaderboardNotifier(bool monthly) {
    _monthly = monthly;
    _leaderboard = [];
    _firestoreReaderService = FirestoreReaderService();
    fetchData();
  }

  bool get monthly => _monthly;
  List<UserInfoModel> get leaderboard =>
      !(isLoading || hasError) ? _leaderboard : [];

  @override
  Future fetchData() async {
    isLoading = true;
    try {
      _leaderboard =
          await _firestoreReaderService.fetchRankings(monthly: _monthly);
      if (_leaderboard == null)
        error = NetworkError('Something went terribly wrong...');
    } catch (e) {
      print(e);
      error = NetworkError('Something went wrong...');
    }
    isLoading = false;
  }

  @override
  Future onRefresh() => fetchData();
}

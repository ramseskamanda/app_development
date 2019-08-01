import 'package:ui_dev/models/competition_model.dart';
import 'package:ui_dev/services/base_service.dart';
import 'package:ui_dev/services/firebase/firestore.dart';
import 'package:ui_dev/services/firebase/storage.dart';
import 'package:timeago/timeago.dart' as timeago;

class CompetitionNotifier extends BaseService {
  //get student info about competition
  //post student info to competition

  FirestoreService _firestoreService;
  FirebaseStorageService _firebaseStorageService;
  CompetitionModel _model;
  String _imageUrl;

  bool _isDownloading = false;

  CompetitionNotifier(String id) {
    _firestoreService = FirestoreService();
    _firebaseStorageService = FirebaseStorageService();
    fetchCompetition(id);
  }

  bool get isDownloading => _isDownloading;
  set isDownloading(bool value) {
    _isDownloading = value;
    notifyListeners();
  }

  CompetitionModel get model => _model;
  String get imageUrl => _imageUrl;
  String get timeLeft => timeago
      .format(_model.deadline, allowFromNow: true)
      .replaceAll('from now', 'left');

  Future<void> fetchCompetition(String id) async {
    isLoading = true;
    _model = await _firestoreService.getCompetitionById(id);
    if (_model == null || _model.runtimeType == Error) error = Error();
    isLoading = false;
  }

  Future downloadAttachments() async {
    isDownloading = true;
    String filePath = _model.media;
    await _firebaseStorageService.download(
      filePath: filePath,
      callback: () => isDownloading = false,
      onError: () => error = Error(),
    );
  }
}

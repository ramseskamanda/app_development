import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/storage/firebase/firebase_storage.dart';
import 'package:studentup_mobile/services/locator.dart';

mixin StorageIO on NetworkIO {
  bool _isDone = false;
  List<StorageUploadTask> _uploadTasks = [];
  FirebaseStorageService _firebaseStorage =
      Locator.of<FirebaseStorageService>();

  FirebaseStorageService get storage =>
      _firebaseStorage ?? Locator.of<FirebaseStorageService>();

  bool get isDone => _isDone ?? true;

  set uploadTasks(List<StorageUploadTask> value) {
    _uploadTasks.addAll(value);
    _isDone = false;
    notifyListeners();
  }

  set isDone(bool value) {
    _isDone = value;
    notifyListeners();
  }

  Future downloadAttachmentsAndPreview(List<String> files) async {
    try {
      isReading = true;
      for (String attachment in files)
        await _firebaseStorage.download(
          filePath: attachment,
          callback: () => isReading = false,
          onError: () => readError =
              NetworkError(message: 'An error occured during download.'),
        );
    } catch (e) {
      print(e);
      readError = NetworkError(message: e.toString());
    }
  }

  Observable<double> get uploadStream =>
      Observable.zip(_uploadTasks.map((u) => u.events),
          (List<StorageTaskEvent> events) {
        return events.isNotEmpty
            ? events.fold<double>(
                    0, (total, e) => total + e.snapshot.bytesTransferred) /
                events.fold<double>(
                    0, (total, e) => total + e.snapshot.totalByteCount)
            : 0;
      });
}

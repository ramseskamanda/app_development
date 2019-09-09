import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/storage/base_file_storage_api.dart';
import 'package:studentup_mobile/services/locator.dart';

mixin StorageIO on NetworkIO {
  bool _isDone = false;
  List<StorageUploadTask> _uploadTasks = [];
  BaseFileStorageAPI _firebaseStorage = Locator.of<BaseFileStorageAPI>();

  BaseFileStorageAPI get storage =>
      _firebaseStorage ?? Locator.of<BaseFileStorageAPI>();

  bool get isDone => _isDone ?? true;

  set isDone(bool value) {
    _isDone = value;
    notifyListeners();
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

import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorage _firebaseStorage;
  Uuid _uuid;

  FirebaseStorageService() {
    _uuid = Uuid();
    _firebaseStorage =
        FirebaseStorage(storageBucket: 'gs://studentup-nl.appspot.com/');
  }

  List<String> createFilePaths(int numFiles, String folderName) {
    List<String> _paths = <String>[];
    for (int _ = 0; _ < numFiles; _++) _paths.add('$folderName/${_uuid.v1()}');
    return _paths;
  }

  //TODO: turn this into an async*
  List<StorageUploadTask> startUpload(List<File> data, List<String> filePaths) {
    assert(data.length == filePaths.length);
    List<StorageUploadTask> _tasks = <StorageUploadTask>[];
    try {
      for (int i = 0; i < data.length; i++)
        _tasks.add(_firebaseStorage.ref().child(filePaths[i]).putFile(data[i]));
    } catch (e) {
      print(e);
    }
    return _tasks;
  }
}

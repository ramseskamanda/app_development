import 'dart:io';
import 'package:path/path.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorage _firebaseStorage;

  FirebaseStorageService() {
    _firebaseStorage =
        FirebaseStorage(storageBucket: 'gs://studentup-nl.appspot.com/');
  }

  Future<String> getImageUrl(String path) async {
    return await _firebaseStorage.ref().child(path).getDownloadURL();
  }

  static List<String> createFilePaths(List<File> files, String folderName) {
    List<String> _paths = <String>[];
    Uuid _uuid = Uuid();
    Context _context = Context();
    for (File file in files) {
      String generatedPath = _uuid.v1();
      String extension = _context.extension(file.path);
      _paths.add('$folderName/${generatedPath + extension}');
    }
    return _paths;
  }

  Future<void> download(
      {String filePath, Function callback, Function onError}) async {
    //TODO: improve this method by saving to memory and retrieving from it
    var meta = await _firebaseStorage.ref().child(filePath).getMetadata();
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$filePath');
    final StorageReference ref = FirebaseStorage.instance.ref().child(filePath);
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    downloadTask.future.whenComplete(() async {
      callback();
      //check that file exists
      if (await file.exists()) {
        //open file
        OpenFile.open(file.path, type: meta.contentType);
      } else {
        onError();
      }
    });
  }

  //TODO: turn this into an async*
  List<StorageUploadTask> startUpload(List<File> data, List<String> filePaths) {
    assert(data.length == filePaths.length);
    print(data.first.path);
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

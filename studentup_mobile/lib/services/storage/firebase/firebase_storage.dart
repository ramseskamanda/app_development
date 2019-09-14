import 'dart:io';
import 'package:studentup_mobile/services/storage/base_file_storage_api.dart';

import 'package:firebase_storage/firebase_storage.dart';

const String projectsFolder = 'projects_files';
const String profilesFolder = 'profiles_pictures';

class FirebaseStorageService extends BaseFileStorageAPI {
  FirebaseStorage _firebaseStorage;

  FirebaseStorageService()
      : _firebaseStorage =
            FirebaseStorage(storageBucket: 'gs://studentup-nl.appspot.com/');

  @override
  Future<String> getFileDownloadUrl({String path}) async =>
      await _firebaseStorage.ref().child(path).getDownloadURL();

  @override
  Future<List<String>> download({List<String> filePaths}) async {
    if (filePaths?.isEmpty ?? true) return [];
    final List<String> uris =
        await BaseFileStorageAPI.createLocalFilePaths(downloadUrls: filePaths);
    assert(filePaths.length == uris.length);
    for (int i = 0; i < uris.length; i++) {
      try {
        await dio.download(
          filePaths[i],
          uris[i],
          onReceiveProgress: (received, total) =>
              print('${(received / total) * 100}%'),
        );
      } catch (e) {/* Continues despite not downloading all the files */}
    }
    return uris ?? [];
  }

  @override
  Future<List<String>> upload({List<File> files, String location}) async {
    if (files.isEmpty) return [];
    final List<String> downloadUrls = [];
    final List<String> _paths = BaseFileStorageAPI.createRemoteFilePaths(
        files: files, folderName: location);
    final List<StorageUploadTask> _queue = [];
    for (int i = 0; i < _paths.length; i++)
      _queue.add(_firebaseStorage.ref().child(_paths[i]).putFile(files[i]));
    for (StorageUploadTask task in _queue) {
      final StorageTaskSnapshot snap = await task.onComplete;
      downloadUrls.add(await snap.ref.getDownloadURL());
    }
    return downloadUrls;
  }
}

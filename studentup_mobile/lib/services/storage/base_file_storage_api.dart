import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract class BaseFileStorageAPI {
  //TODO: Implement general queue so that only a certain number of downloads can be started at the same time
  @protected
  final Dio dio = Dio();
  @protected
  static List<String> createRemoteFilePaths(
      {List<File> files, String folderName}) {
    assert(!files.contains(null));
    if (files.isEmpty) return [];
    final List<String> _paths = <String>[];
    final Uuid _uuid = Uuid();
    for (File file in files) {
      String generatedPath = _uuid.v1();
      String extension = url.extension(file.path);
      _paths.add('$folderName/${generatedPath + extension}');
    }
    return _paths;
  }

  @protected
  static Future<List<String>> createLocalFilePaths({
    List<String> downloadUrls,
  }) async {
    assert(!downloadUrls.contains(null));
    if (downloadUrls.isEmpty) return [];
    final List<String> _paths = <String>[];
    var dir = await getApplicationDocumentsDirectory();
    for (String link in downloadUrls) {
      String fileName = url.basename(link);
      _paths.add('${dir.path}/$fileName');
    }
    return _paths;
  }

  Future<void> showFile({File file}) async {
    if (!await file.exists()) throw 'File Does Not Exist';
    final FileStat stats = await file.stat();
    print('Trying to open ${file.path} with Mode: ' + stats.modeString());
    print('File ${file.path} has Type: ' + stats.type.toString());
    print(await OpenFile.open(file.path));
  }

  Future<String> getFileDownloadUrl({String path});
  //TODO: add progress indicator on uploads and downloads
  Future<List<String>> upload({List<File> files, String location});
  Future<List<String>> download({List<String> filePaths});
}

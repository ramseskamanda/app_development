import 'package:flutter/foundation.dart';

class FileAsset {
  final String id;
  final String fileName;
  final String downloadUrl;
  final String fileType;
  final DateTime postedAt;

  FileAsset({
    @required this.id,
    @required this.downloadUrl,
    @required this.fileName,
    @required this.postedAt,
    this.fileType,
  });
}

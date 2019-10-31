import 'package:flutter/material.dart';
import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/views/communities/common/community_action_menu.dart';

class FileWidget extends StatelessWidget {
  final FileAsset file;

  const FileWidget({Key key, @required this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => print('Open file'),
        title: Text(file.fileName),
        trailing: ActionMenuCommunities(
          reportCallback: () => print('report ${file.fileName}'),
        ),
        leading: file.fileType == 'image'
            ? const Text('📸', style: TextStyle(fontSize: 24.0))
            : const Text('🗂️', style: TextStyle(fontSize: 24.0)),
      ),
    );
  }
}

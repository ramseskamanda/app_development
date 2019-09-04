import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_page_notifier.dart';
import 'package:studentup_mobile/services/project_creation_service.dart';

class FileAttachment extends StatelessWidget {
  final bool isAddButton;
  final int index;

  const FileAttachment({Key key, this.isAddButton, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectCreationService>(
      builder: (context, service, child) {
        return ListTile(
          onTap: isAddButton ? () => service.pickFile() : null,
          leading: isAddButton
              ? Icon(Icons.attach_file)
              : Icon(Icons.insert_drive_file),
          trailing: isAddButton
              ? null
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => service.removeFile(index),
                ),
          title: isAddButton
              ? const Text(
                  'Add attachments, if necessary',
                  style: TextStyle(
                    color: CupertinoColors.inactiveGray,
                  ),
                )
              : Text(
                  basename(service.files[index].path),
                  style: TextStyle(
                    color: CupertinoColors.black,
                  ),
                ),
        );
      },
    );
  }
}

class SingleFileAttachment extends StatelessWidget {
  final bool canEdit;

  const SingleFileAttachment({Key key, @required this.canEdit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectPageNotifier>(
      builder: (context, notifier, child) {
        bool isAddButton = notifier.file == null;
        return ListTile(
          onTap: isAddButton && canEdit
              ? () async => await notifier.pickFile()
              : null,
          leading: isAddButton
              ? Icon(Icons.attach_file)
              : Icon(Icons.insert_drive_file),
          trailing: isAddButton || !canEdit
              ? null
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => notifier.removeFile(),
                ),
          title: isAddButton
              ? Text(
                  !canEdit ? 'No attachments' : 'Add attachments, if necessary',
                  style: TextStyle(
                    color: CupertinoColors.inactiveGray,
                  ),
                )
              : Text(
                  basename(notifier.file.path),
                  style: TextStyle(
                    color: CupertinoColors.black,
                  ),
                ),
        );
      },
    );
  }
}

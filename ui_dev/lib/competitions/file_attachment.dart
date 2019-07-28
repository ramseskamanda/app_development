import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileAttachment extends StatelessWidget {
  final bool isAddButton;
  final int index;

  const FileAttachment({Key key, this.isAddButton, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: isAddButton ? () => print('object') : null,
      leading:
          isAddButton ? Icon(Icons.attach_file) : Icon(Icons.insert_drive_file),
      trailing: isAddButton
          ? null
          : IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => print('delete'),
            ),
      title: isAddButton
          ? const Text(
              'Add attachments, if necessary',
              style: TextStyle(
                color: CupertinoColors.inactiveGray,
              ),
            )
          : Text(
              'File #$index',
              style: TextStyle(
                color: CupertinoColors.black,
              ),
            ),
    );
  }
}

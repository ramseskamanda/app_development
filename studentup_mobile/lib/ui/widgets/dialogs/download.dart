import 'package:flutter/material.dart';

class DownloadDialog {
  Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Download this file?'),
          content: const Text(
            'Are you sure you want to download this file? Keep in mind downloads are temporary, save important documents externally.',
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(_).pop(false),
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: const Text('Start Download'),
              onPressed: () => Navigator.of(_).pop(true),
            ),
          ],
        );
      },
    );
  }
}

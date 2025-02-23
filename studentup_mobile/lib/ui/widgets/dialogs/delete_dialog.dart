import 'package:flutter/material.dart';

class DeletionDialog {
  Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delete this item?'),
          content: const Text(
            'Once this item is deleted, you will not be able to get it back.\n Are you sure you want to delete it?',
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(_).pop(false),
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: const Text('Delete'),
              onPressed: () => Navigator.of(_).pop(true),
            ),
          ],
        );
      },
    );
  }
}

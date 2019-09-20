import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoutDialog {
  Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: const Text(
            'Once logged out, you will not receive notifications and won\'t have access to the platform until you log back in.\n Are you sure you want to continue?',
          ),
          actions: <Widget>[
            FlatButton(
              textColor: CupertinoColors.black,
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(_).pop(false),
            ),
            RaisedButton(
              color: CupertinoColors.destructiveRed,
              textColor: Colors.white,
              child: const Text('Logout'),
              onPressed: () => Navigator.of(_).pop(true),
            ),
          ],
        );
      },
    );
  }
}

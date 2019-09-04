import 'package:flutter/material.dart';

class ComingSoon {
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Coming Soon!'),
          content: const Text(
              'Unfortunately, this feature isn\'t available yet. Check back in daily to see what becomes of it!'),
          actions: <Widget>[
            FlatButton(
              child: const Text('I\'ll be back!'),
              onPressed: () => Navigator.of(_).pop(),
            ),
          ],
        );
      },
    );
  }
}

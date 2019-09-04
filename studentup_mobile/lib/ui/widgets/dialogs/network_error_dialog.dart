import 'package:flutter/material.dart';

class NetworkErrorDialog {
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('A Network Error Occured'),
          content: const Text('Something went wrong. Please try again.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('O.K.'),
              onPressed: () => Navigator.of(_).pop(),
            ),
          ],
        );
      },
    );
  }
}

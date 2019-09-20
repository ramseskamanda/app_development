import 'package:flutter/material.dart';

class ProjectDialog {
  Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Submit your application?'),
          content: const Text(
            'Once your application has been submitted, the owner of the project will review it.\n'
            'Stay on your toes, they can contact you or notify you any minute now!',
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(_).pop(false),
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: const Text('Submit'),
              onPressed: () => Navigator.of(_).pop(true),
            ),
          ],
        );
      },
    );
  }
}

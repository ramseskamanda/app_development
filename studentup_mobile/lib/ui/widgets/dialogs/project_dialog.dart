import 'package:flutter/material.dart';

class ProjectDialog {
  Future<bool> show(BuildContext context, {bool withdraw = false}) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            withdraw
                ? 'Withdraw your application?'
                : 'Submit your application?',
          ),
          content: Text(
            withdraw
                ? 'Once your application is withdrawn, the owner of the project will not be able to see the files you'
                    'sent or information you provided when signing up.'
                : 'Once your application has been submitted, the owner of the project will review it.\n'
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
              child: Text(withdraw ? 'Withdraw' : 'Submit'),
              onPressed: () => Navigator.of(_).pop(true),
            ),
          ],
        );
      },
    );
  }
}

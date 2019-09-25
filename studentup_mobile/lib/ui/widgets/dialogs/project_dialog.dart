import 'package:flutter/cupertino.dart';
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

class ProjectDeadlineError {
  void show(BuildContext context, {bool timetraveller}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(timetraveller ? 'No time travel!' : 'Keep it short!'),
        content: Text(
          timetraveller
              ? 'The date you selected is before our earliest deadline possible. Please select a later date.'
              : 'The date selected is too far in the future. Please select an earlier date',
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'OK',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

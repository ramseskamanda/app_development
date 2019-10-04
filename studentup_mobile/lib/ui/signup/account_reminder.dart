import 'package:flutter/material.dart';

class AccountReminder extends StatelessWidget {
  final String reminder;
  final String link;
  final void Function() callback;

  const AccountReminder({
    Key key,
    @required this.callback,
    @required this.reminder,
    @required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(reminder + ' '),
        GestureDetector(
          onTap: callback,
          child: Text(
            link,
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}

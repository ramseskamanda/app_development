import 'package:flutter/material.dart';

typedef void FABCallBack();

class PaddedFAB extends StatelessWidget {
  final IconData icon;
  final String text;
  final FABCallBack onPressed;

  PaddedFAB({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      child: text == null
          ? FloatingActionButton(
              child: Icon(icon),
              onPressed: onPressed,
            )
          : FloatingActionButton.extended(
              icon: Icon(icon),
              label: Text(text),
              onPressed: onPressed,
            ),
    );
  }
}

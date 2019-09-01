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
      padding: EdgeInsets.only(
        bottom: kBottomNavigationBarHeight + kFloatingActionButtonMargin + 12.0,
      ),
      child: text == null
          ? FloatingActionButton(
              heroTag: 'padded',
              child: Icon(
                icon,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              onPressed: onPressed,
            )
          : FloatingActionButton.extended(
              heroTag: 'padded',
              icon: Icon(icon),
              label: Text(text),
              onPressed: onPressed,
            ),
    );
  }
}

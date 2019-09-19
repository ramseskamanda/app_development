import 'package:flutter/cupertino.dart';
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
              backgroundColor: Theme.of(context).accentColor,
              heroTag: 'padded',
              child: Icon(
                icon,
                color: CupertinoColors.white,
              ),
              onPressed: onPressed,
            )
          : FloatingActionButton.extended(
              backgroundColor: Theme.of(context).accentColor,
              heroTag: 'padded',
              icon: Icon(
                icon,
                color: CupertinoColors.white,
              ),
              label: Text(text),
              onPressed: onPressed,
            ),
    );
  }
}

import 'package:flutter/material.dart';

class StadiumButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;

  StadiumButton({
    Key key,
    @required this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 32.0,
                    color: Colors.white,
                  ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.button.copyWith(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
            color: Theme.of(context).accentColor,
            onPressed: onPressed,
            shape: StadiumBorder(),
          ),
        ),
      ],
    );
  }
}

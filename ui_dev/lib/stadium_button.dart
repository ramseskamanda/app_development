import 'package:flutter/material.dart';

class StadiumButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const StadiumButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              shape: StadiumBorder(),
              color: Theme.of(context).accentColor,
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white),
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

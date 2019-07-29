import 'package:flutter/material.dart';

class StadiumButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;

  const StadiumButton({
    @required this.text,
    @required this.onPressed,
  }) : this.icon = null;

  const StadiumButton.icon({
    @required this.text,
    @required this.onPressed,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        children: <Widget>[
          Expanded(
            child: icon == null
                ? RaisedButton(
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
                  )
                : RaisedButton.icon(
                    shape: StadiumBorder(),
                    color: Theme.of(context).accentColor,
                    icon: Icon(icon, color: Colors.white),
                    label: Text(
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

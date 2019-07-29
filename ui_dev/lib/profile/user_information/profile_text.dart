import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Ramses Kamanda',
          style: Theme.of(context).textTheme.headline.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
                fontSize: 28.0,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.0),
        Text(
          'Maastricht University',
          style: Theme.of(context).textTheme.title.copyWith(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.0),
        Text(
          'Maastricht, Netherlands',
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(fontWeight: FontWeight.w300, fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

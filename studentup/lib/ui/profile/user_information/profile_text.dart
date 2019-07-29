import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Text('Lvl. 6'),
                  Spacer(flex: 20),
                  Text('210 XP'),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 4.0),
              LinearPercentIndicator(
                lineHeight: 8.0,
                percent: 0.8,
                progressColor: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Ramses Kamanda',
          style: Theme.of(context).textTheme.headline.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
                fontSize: 28.0,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Text(
          'Maastricht University',
          style: Theme.of(context).textTheme.title.copyWith(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6.0),
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

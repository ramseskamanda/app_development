import 'package:flutter/material.dart';
import 'package:ui_dev/stadium_button.dart';

class Submitted extends StatelessWidget {
  final bool isCompetition;

  const Submitted({Key key, this.isCompetition = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                isCompetition ? 'Competition Published!' : 'Answer submitted!',
                softWrap: true,
                style: Theme.of(context).textTheme.display1,
              ),
              const SizedBox(height: 32.0),
              Icon(
                Icons.check_circle,
                size: 48.0,
                color: Theme.of(context).accentColor,
              ),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Made a mistake? Don\'t worry! You can edit your competitions from your profile page.',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: StadiumButton(
                  text: 'Finish',
                  onPressed: () => print('object'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

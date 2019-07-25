import 'package:flutter/material.dart';
import 'package:ui_dev/stadium_button.dart';

class Submitted extends StatelessWidget {
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
                'Answer submitted!',
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
                  'Made a mistake? Don\'t worry! You can resubmit three times before the dealine.',
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

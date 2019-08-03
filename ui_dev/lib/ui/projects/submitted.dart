import 'package:flutter/material.dart';
import 'package:ui_dev/widgets/stadium_button.dart';

class Submitted extends StatelessWidget {
  final bool isProject;

  const Submitted({Key key, this.isProject = false}) : super(key: key);

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
                isProject ? 'Project Published!' : 'Application submitted!',
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
                  isProject
                      ? 'Made a mistake? Don\'t worry! You can edit your Projects from your profile page.'
                      : 'You will be notified if you were selected for this project.',
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

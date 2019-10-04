import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Widget> get onboarding => <Widget>[
      OnaboardingScreen(
        title: 'Search for start-ups,\n projects, and peers.',
        description:
            'Studentup is the place where start-ups, entrepreneurs, and students find each other.',
        assetUri: 'assets/onboarding/1.png',
      ),
      OnaboardingScreen(
        title: 'Participate in start-up think-tanks.',
        description:
            'Share your ideas anonymously to start-ups, and vote on ideas from others.',
        assetUri: 'assets/onboarding/2.png',
      ),
      OnaboardingScreen(
        title: 'Win attractive prizes each month.',
        description: 'Find your future teammates and achieve more, together.',
        assetUri: 'assets/onboarding/3.png',
      ),
    ];

class OnaboardingScreen extends StatelessWidget {
  final String title;
  final String description;
  final String assetUri;

  const OnaboardingScreen({
    Key key,
    @required this.title,
    @required this.description,
    @required this.assetUri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final TextTheme themeData = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            assetUri,
            fit: BoxFit.contain,
            height: media.devicePixelRatio < 1.0
                ? media.size.height * 0.25
                : media.size.height * 0.3,
          ),
          const SizedBox(height: 24.0),
          Text(
            title,
            softWrap: true,
            textAlign: TextAlign.center,
            style: media.devicePixelRatio < 1.0
                ? themeData.title
                    .copyWith(fontWeight: FontWeight.bold)
                    .apply(color: themeData.display1.color.withAlpha(255))
                : themeData.display1
                    .copyWith(fontWeight: FontWeight.bold)
                    .apply(color: themeData.display1.color.withAlpha(255)),
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            softWrap: true,
            textAlign: TextAlign.center,
            style: themeData.title.copyWith(fontWeight: FontWeight.w600),
          ),
          Opacity(
            opacity: 0.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: const Text('Padding'),
                    onPressed: null,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

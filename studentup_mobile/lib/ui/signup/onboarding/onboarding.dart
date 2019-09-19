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
        description:
            'Get on top of the leaderboard by improving your profile and participating in projects and think-tanks.',
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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Image(
            image: AssetImage(assetUri),
            fit: BoxFit.contain,
            frameBuilder: (_, child, __, ___) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: child,
              );
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(fontWeight: FontWeight.bold)
                  .apply(
                      color: Theme.of(context)
                          .textTheme
                          .display1
                          .color
                          .withAlpha(255)),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Spacer(flex: 4),
        ],
      ),
    );
  }
}

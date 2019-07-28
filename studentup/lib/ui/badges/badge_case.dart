import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BadgeCase extends StatelessWidget {
  final Random rand = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => print('object'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Badges',
                    style: Theme.of(context).textTheme.display1.copyWith(
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 48.0),
                SectionTitle(
                  title: 'Earned',
                  onPressed: () => print('object'),
                ),
                GridView.count(
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: <Widget>[
                    for (var i = 0; i < 6; i++)
                      CircleAvatar(
                        backgroundColor: Colors
                            .primaries[rand.nextInt(Colors.primaries.length)],
                      )
                  ],
                ),
                const SizedBox(height: 16.0),
                SectionTitle(
                  title: 'Popular',
                  onPressed: () => print('object'),
                ),
                GridView.count(
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: <Widget>[
                    for (var i = 0; i < 6; i++)
                      CircleAvatar(
                        backgroundColor: Colors
                            .primaries[rand.nextInt(Colors.primaries.length)],
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const SectionTitle({Key key, @required this.title, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(fontWeight: FontWeight.w600),
          ),
          FlatButton(
            child: const Text('See all'),
            textColor: Theme.of(context).accentColor,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}

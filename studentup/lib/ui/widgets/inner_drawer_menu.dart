import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InnerDrawerMenu extends StatelessWidget {
  final Scaffold child;

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  InnerDrawerMenu({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      position: InnerDrawerPosition.start,
      scaffold: child,
      child: InnerDrawerChild(),
      animationType: InnerDrawerAnimation.quadratic,
      onTapClose: true,
    );
  }
}

class InnerDrawerChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => print('object'),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                accountEmail: const Text('ramses.kamanda@gmail.com'),
                accountName: const Text('Ramses Kamanda'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://via.placeholder.com/150',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Text(
                        'Profile 80% complete',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Spacer(flex: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Complete',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: 0.8,
                    progressColor: Theme.of(context).accentColor,
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 72.0),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('My Competitions'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text('Saved Profiles'),
              onTap: () {},
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.weekend,
                      color: CupertinoColors.destructiveRed,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: CupertinoColors.destructiveRed,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

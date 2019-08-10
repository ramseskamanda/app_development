import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ui_dev/ui/leaderboard/leaderboard_list.dart';
import 'package:ui_dev/ui/leaderboard/prize_list.dart';

class LeaderBoardRoot extends StatelessWidget {
  final List<Tab> _tabs = [
    Tab(text: 'Prizes'),
    Tab(text: 'Monthly'),
    Tab(text: 'All Time'),
  ];

  void _showPersonalRanking(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('You are ranked:'),
          content: const Text(
            //TODO: give this custom number
            '10th',
            textAlign: TextAlign.center,
          ),
          contentPadding: const EdgeInsets.all(32.0),
          contentTextStyle: Theme.of(context)
              .textTheme
              .display3
              .apply(color: CupertinoColors.black),
          actions: <Widget>[
            FlatButton(
              child: const Text('Good!'),
              textColor: CupertinoColors.activeBlue,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: (_tabs.length / 2).floor(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text('Leaderboards'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                EvilIcons.getIconData('trophy'),
                size: 28.0,
              ),
              onPressed: () => _showPersonalRanking(context),
            )
          ],
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              PrizeList(),
              LeaderboardListView(monthly: true),
              LeaderboardListView(monthly: false),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/evil_icons.dart';
import 'package:ui_dev/leaderboard/leaderboard_list.dart';
import 'package:ui_dev/leaderboard/prize_list.dart';

class LeaderBoardRoot extends StatelessWidget {
  final List<Tab> _tabs = [
    Tab(text: 'Prizes'),
    Tab(text: 'Monthly'),
    Tab(text: 'All Time'),
  ];

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
              onPressed: () => print('show personal rankings'),
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

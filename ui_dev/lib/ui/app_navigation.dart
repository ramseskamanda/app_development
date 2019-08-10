import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:ui_dev/ui/home/home.dart';
import 'package:ui_dev/ui/leaderboard/leaderboard_root.dart';
import 'package:ui_dev/ui/profile/profile.dart';
import 'package:ui_dev/ui/search/search_root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int _currentTab = 0;

  List<Widget> _tabs = <Widget>[
    Home(),
    SearchRoot(),
    LeaderBoardRoot(),
    Profile(),
  ];

  List<BottomNavigationBarItem> _navigationBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: const Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: const Text('Search'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.game_controller),
      title: const Text('Leaderboards'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: const Text('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    assert(_navigationBar.length == _tabs.length);
    return WillPopScope(
      onWillPop: () async => false,
      child: InnerDrawer(
        position: InnerDrawerPosition.start,
        animationType: InnerDrawerAnimation.quadratic,
        onTapClose: true,
        child: Material(),
        scaffold: CupertinoTabScaffold(
          tabBuilder: (BuildContext context, int index) => _tabs[index],
          tabBar: CupertinoTabBar(
            currentIndex: _currentTab,
            items: _navigationBar,
            onTap: (int index) {
              setState(() {
                _currentTab = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

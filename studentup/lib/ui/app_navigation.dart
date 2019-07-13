import 'package:studentup/services/provider_service.dart';
import 'package:studentup/ui/notifications/notifications.dart';
import 'package:studentup/ui/search/search.dart';
import 'package:studentup/ui/ui.dart';
import 'package:studentup/util/notification_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with NotificationMixin {
  int _currentTab = 0;

  List<Widget> _tabs = <Widget>[
    Home(),
    SearchTab(),
    Notifications(),
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
      icon: Icon(CupertinoIcons.bell),
      title: const Text('Notifications'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: const Text('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    assert(_navigationBar.length == _tabs.length);
    return MultiProvider(
      providers: userBasedProviders,
      child: WillPopScope(
        onWillPop: () async => false,
        child: CupertinoTabScaffold(
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

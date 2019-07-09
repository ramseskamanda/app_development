import 'package:studentup/notifiers/userprofile_notifier.dart';
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
    Marketplace(),
    Profile(),
  ];

  List<BottomNavigationBarItem> _navigationBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.view_list),
      title: const Text('Events'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: const Text('Market'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: const Text('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<UserProfileNotifier>(
          builder: (_) => UserProfileNotifier()..initialize(),
        ),
      ],
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

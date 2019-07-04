import 'package:studentup/notifiers/userprofile_notifier.dart';
import 'package:studentup/ui/ui.dart';
import 'package:studentup/util/notification_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with NotificationMixin {
  int _currentTab;
  GlobalKey<InnerDrawerState> _drawerKey;

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

  void _updateTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  void initState() {
    assert(_navigationBar.length == _tabs.length);
    super.initState();
    _currentTab = 0;
    _drawerKey = GlobalKey<InnerDrawerState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        Provider<GlobalKey<InnerDrawerState>>.value(value: _drawerKey),
        ChangeNotifierProvider<UserProfileNotifier>(
            builder: (_) => UserProfileNotifier()..initialize()),
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: InnerDrawer(
          key: _drawerKey,
          swipe: true,
          onTapClose: true,
          animationType: InnerDrawerAnimation.quadratic,
          position: InnerDrawerPosition.start,
          child: ApplicationDrawer(),
          scaffold: CupertinoTabScaffold(
            tabBuilder: (BuildContext context, int index) => _tabs[index],
            tabBar: CupertinoTabBar(
              currentIndex: _currentTab,
              onTap: _updateTab,
              items: _navigationBar,
            ),
          ),
        ),
      ),
    );
  }
}

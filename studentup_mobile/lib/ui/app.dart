import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/analytics_types.dart';
import 'package:studentup_mobile/notifiers/test_notifier.dart';
import 'package:studentup_mobile/services/analytics_service.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/home/feed/feed.dart';
import 'package:studentup_mobile/ui/search/search_root.dart';
import 'package:studentup_mobile/ui/widgets/toasts/complete_profile_toast.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int _currentTab = 0;

  List<Widget> _tabs = <Widget>[
    Feed(),
    Scaffold(
      body: Center(
        child: RaisedButton.icon(
          icon: Icon(
            Icons.power_settings_new,
            color: CupertinoColors.destructiveRed,
          ),
          label: const Text('Log out'),
          onPressed: () => Locator.of<AuthService>().logout(),
        ),
      ),
    ),
    SearchRoot(),
    Scaffold(
      body: Center(
        child: RaisedButton.icon(
          icon: Icon(
            Icons.bug_report,
            color: CupertinoColors.destructiveRed,
          ),
          label: const Text('Report custom event'),
          onPressed: () => Locator.of<AnalyticsService>()
              .logSpecialEvent(AnalyticsType.TEST),
        ),
      ),
    ),
    Scaffold(),
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
      icon: Icon(CupertinoIcons.mail),
      title: const Text('Mail'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: const Text('Profile'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks)
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          if (Locator.of<AuthService>().currentUserisNew)
            CompleteProfileToast.show(
                context: context,
                stateManagerCallback: () {
                  setState(() {
                    _currentTab = _tabs.length - 1;
                  });
                });
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    assert(_navigationBar.length == _tabs.length);
    return ChangeNotifierProvider<ProfileNotifier>(
      builder: (_) => ProfileNotifier(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: CupertinoTabScaffold(
          tabBuilder: (BuildContext context, int index) => _tabs[index],
          tabBar: CupertinoTabBar(
            currentIndex: _currentTab,
            items: _navigationBar,
            onTap: (int index) {
              setState(() {
                //TODO: reset the page's navigator
                _currentTab = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

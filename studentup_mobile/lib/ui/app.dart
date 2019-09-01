import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/home/home.dart';
import 'package:studentup_mobile/ui/profile/profile.dart';
import 'package:studentup_mobile/ui/projects/projects_root.dart';
import 'package:studentup_mobile/ui/search/search_root.dart';
import 'package:studentup_mobile/ui/widgets/toasts/complete_profile_toast.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int _currentTab = 0;

  List<Widget> _tabs = <Widget>[
    Home(),
    SearchRoot(),
    ProjectFeedRoot(),
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
      icon: Icon(CupertinoIcons.lab_flask),
      title: const Text('Projects'),
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(CupertinoIcons.mail),
    //   title: const Text('Mail'),
    // ),
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
              },
            );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    assert(_navigationBar.length == _tabs.length);
    return ChangeNotifierProvider<ProfileNotifier>(
      builder: (_) {
        final value = ProfileNotifier();
        Locator.registerUniqueProfile(value);
        return value;
      },
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

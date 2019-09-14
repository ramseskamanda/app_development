import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/mixins/notification_mixin.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/home/home.dart';
import 'package:studentup_mobile/ui/profile/profile_root.dart';
import 'package:studentup_mobile/ui/projects/projects_root.dart';
import 'package:studentup_mobile/ui/search/search_root.dart';
import 'package:studentup_mobile/ui/widgets/toasts/complete_profile_toast.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>
    with NotificationDisplayMixin {
  List<Widget> _tabs = <Widget>[
    Home(),
    SearchRoot(),
    ProjectFeedRoot(),
    ProfileRoot(),
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
    initializeMixin(context);
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks)
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          // Provider.of<ProfileNotifier>(context).fetchData();

          if (Locator.of<AuthService>().currentUserisNew)
            CompleteProfileToast.show(
              context: context,
              stateManagerCallback: () =>
                  Provider.of<InnerRouter>(context).goToProfile(),
            );
        },
      );
  }

  @override
  void dispose() {
    disposeMixin();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('[TRACE] :: BUILDING MAIN APPLICATION');
    // Provider.of<ProfileNotifier>(context).fetchData();

    assert(_navigationBar.length == _tabs.length);
    InnerRouter router = Provider.of<InnerRouter>(context);
    router.profileTab = _tabs.length - 1;
    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoTabScaffold(
        controller: router.navBar,
        tabBuilder: (BuildContext context, int index) => _tabs[index],
        tabBar: CupertinoTabBar(
          items: _navigationBar,
          onTap: (int index) {
            if (index == 0) router.resetHomePage();
          },
        ),
      ),
    );
  }
}

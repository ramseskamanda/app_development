import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup/ui/widgets/profile_drawer_button.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Notifications extends StatelessWidget {
  final List<String> _tabs = <String>[
    'All',
    'Mentions',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          bottom: TabBar(
            tabs: _tabs.map((String name) => Tab(text: name)).toList(),
          ),
          leading: ProfileDrawerButton(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                CupertinoIcons.settings,
                size: 32.0,
              ),
              onPressed: () => print('notifications settings'),
            ),
          ],
        ),
        body: TabBarView(
          children: _tabs.map((String name) => TabView(name)).toList(),
        ),
      ),
    );
  }
}

class TabView extends StatelessWidget {
  final String name;
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  TabView(this.name);

  Future<void> _onRefresh() async {
    Future.delayed(Duration(seconds: 1), () => print('Refreshed'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LiquidPullToRefresh(
        key: _key,
        height: 50.0,
        showChildOpacityTransition: true,
        onRefresh: _onRefresh,
        child: ListView.separated(
          key: PageStorageKey<String>(name),
          itemCount: 100,
          separatorBuilder: (context, index) => SizedBox(height: 4.0),
          itemBuilder: (context, index) => ListTile(
            title: Text('$name Notification #$index'),
          ),
        ),
      ),
    );
  }
}

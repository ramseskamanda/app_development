import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup/ui/widgets/profile_drawer_button.dart';

class Notifications extends StatelessWidget {
  final List<String> _tabs = <String>[
    'All',
    'Mentions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  title: const Text('Notifications'),
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: Colors.transparent,
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
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverFixedExtentList(
                            itemExtent: 48.0,
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

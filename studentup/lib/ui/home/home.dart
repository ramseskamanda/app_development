import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:studentup/ui/home/discussions_list.dart';
import 'package:studentup/ui/home/trending.dart';
import 'package:studentup/ui/widgets/screen_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<InnerDrawerState> _drawerKey =
        Provider.of<GlobalKey<InnerDrawerState>>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: _drawerKey.currentState.open,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.message),
                onPressed: () => print('messages'),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.11,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  ScreenTitle('Home'),
                  TrendingCompetitions(),
                  DiscussionsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

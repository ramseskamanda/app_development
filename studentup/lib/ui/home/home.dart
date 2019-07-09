import 'package:studentup/ui/home/discussions_list.dart';
import 'package:studentup/ui/home/trending.dart';
import 'package:studentup/ui/widgets/screen_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup/ui/widgets/widgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              snap: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: ProfileDrawerButton(),
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () => print('messages'),
                ),
              ],
            ),
          ];
        },
        body: SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.11,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //ScreenTitle('Home'),
                    //TrendingCompetitions(),
                    //DiscussionsList(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

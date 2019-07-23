import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/evil_icons.dart';
import 'package:ui_dev/leaderboard/trophy_screen.dart';
import 'package:ui_dev/models/student_model.dart';
import 'package:ui_dev/test_data.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class LeaderBoardRoot extends StatelessWidget {
  final List<Tab> _tabs = [
    Tab(text: 'Monthly'),
    Tab(text: 'All Time'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text('Leaderboards'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(CupertinoIcons.bell),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                EvilIcons.getIconData('trophy'),
                size: 28.0,
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TrophyScreen(),
                ),
              ),
            )
          ],
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              LeaderboardListView(monthly: true),
              LeaderboardListView(monthly: false),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderboardListView extends StatefulWidget {
  final bool monthly;

  const LeaderboardListView({Key key, @required this.monthly})
      : super(key: key);

  @override
  _LeaderboardListViewState createState() => _LeaderboardListViewState();
}

class _LeaderboardListViewState extends State<LeaderboardListView> {
  ScrollController _scrollController = ScrollController();
  List<StudentModel> _data = [...TestData.students];

  Future<void> _onRefresh() async {}

  Future<void> _loadMore() async {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _data.add(
          StudentModel(
            name: 'Thomas Lang',
            exp: 0.0,
            monthlyExp: 0.0,
            completedProjects: 0,
            university: 'München',
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
    if (widget.monthly)
      _data.sort((a, b) => b.monthlyExperience.compareTo(a.monthlyExperience));
    else
      _data.sort((a, b) => b.experiencePoints.compareTo(a.experiencePoints));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _data.length + 1,
        itemExtent: MediaQuery.of(context).size.height * 0.085,
        itemBuilder: (BuildContext context, int index) {
          if (index == _data.length) return CupertinoActivityIndicator();
          return ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '#${index + 1}',
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: CupertinoColors.black),
                ),
                SizedBox(width: 16.0),
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://via.placeholder.com/150',
                    errorListener: () =>
                        print('CachedNetworkImageProvider Error'),
                  ),
                )
              ],
            ),
            title: Text(_data[index].name),
            subtitle: Text(_data[index].university),
            trailing: Text(
              '${widget.monthly ? _data[index].monthlyExperience : _data[index].experiencePoints} pts',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: CupertinoColors.black),
            ),
          );
        },
      ),
    );
  }
}

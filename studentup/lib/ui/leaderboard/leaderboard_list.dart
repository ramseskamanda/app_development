import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class LeaderboardListView extends StatefulWidget {
  final bool monthly;

  const LeaderboardListView({Key key, @required this.monthly})
      : super(key: key);

  @override
  _LeaderboardListViewState createState() => _LeaderboardListViewState();
}

class _LeaderboardListViewState extends State<LeaderboardListView> {
  ScrollController _scrollController = ScrollController();

  Future<void> _onRefresh() async {}

  Future<void> _loadMore() async {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        print('object');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
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
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: PodiumHeaderDelegate(
              expandedHeight: MediaQuery.of(context).size.height * 0.21,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: MediaQuery.of(context).size.height * 0.085,
            delegate: SliverChildBuilderDelegate(
              (context, index) => UserRankingListTile(
                monthly: widget.monthly,
                user: index,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class PodiumHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  PodiumHeaderDelegate({
    @required this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;

    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Opacity(
      opacity: percent,
      child: SizedBox(
        height: expandedHeight,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PodiumProfile(position: 2),
              PodiumProfile(position: 1),
              PodiumProfile(position: 3),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return this != oldDelegate;
  }
}

class PodiumProfile extends StatelessWidget {
  final int position;

  const PodiumProfile({Key key, this.position})
      : assert(position > 0 && position < 4, 'Podium is from 1 to 3.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Spacer(flex: 2),
        Text(
          '$position',
          style: Theme.of(context).textTheme.caption.copyWith(
                color: CupertinoColors.black,
                fontWeight: position == 1
                    ? FontWeight.bold
                    : position == 2 ? FontWeight.w600 : FontWeight.w500,
              ),
        ),
        Spacer(),
        CircleAvatar(
          radius: position == 1 ? 34.0 : 28.0,
          backgroundImage: CachedNetworkImageProvider(
            'https://via.placeholder.com/150',
          ),
        ),
        Spacer(),
        Text(
          'Ramses Kamanda',
          softWrap: true,
          style: Theme.of(context).textTheme.overline,
        ),
        Text(
          'Maastricht University',
          softWrap: true,
          style: Theme.of(context)
              .textTheme
              .overline
              .copyWith(color: CupertinoColors.lightBackgroundGray),
        ),
        Spacer(),
        Text(
          '200 XP',
          softWrap: true,
          style: Theme.of(context).textTheme.overline,
        ),
        Spacer(flex: 2),
      ],
    );
  }
}

class UserRankingListTile extends StatelessWidget {
  final int user;
  final bool monthly;

  const UserRankingListTile({Key key, this.user, this.monthly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: <Widget>[
          SizedBox(width: 16.0),
          /*  */
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Text(
                  '${user + 4}',
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 14,
            child: Card(
              shape: StadiumBorder(),
              child: Container(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      'https://via.placeholder.com/150',
                      errorListener: () =>
                          print('CachedNetworkImageProvider Error'),
                    ),
                  ),
                  title: Text('Ramses Kamanda'),
                  subtitle: Text('Maastricht University'),
                  trailing: Text(
                    '${monthly ? 10 : 20} pts',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

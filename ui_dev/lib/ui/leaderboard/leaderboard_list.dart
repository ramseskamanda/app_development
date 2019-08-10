import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/models/user_info_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/leaderboard_notifier.dart';

class LeaderboardListView extends StatefulWidget {
  final bool monthly;

  const LeaderboardListView({Key key, @required this.monthly})
      : super(key: key);

  @override
  _LeaderboardListViewState createState() => _LeaderboardListViewState();
}

class _LeaderboardListViewState extends State<LeaderboardListView>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();

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
    super.build(context);
    return ChangeNotifierProvider<LeaderboardNotifier>(
      builder: (_) => LeaderboardNotifier(widget.monthly),
      child: Consumer<LeaderboardNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading)
            return Center(child: const CircularProgressIndicator());
          if (notifier.hasError)
            return Center(child: Text(notifier.error.message));
          return LiquidPullToRefresh(
            onRefresh: () async => notifier.onRefresh(),
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
                      //index + 3 because of the podium
                      user: notifier.leaderboard[index + 3],
                      //index + 3 because of podium and + 1 for off-by-one error
                      ranking: (index + 3) + 1,
                    ),
                    childCount: notifier.leaderboard.length - 3 > 0
                        ? notifier.leaderboard.length - 3
                        : 0,
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Center(
                //     child: CupertinoActivityIndicator(),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
              PodiumProfile(ranking: 2),
              PodiumProfile(ranking: 1),
              PodiumProfile(ranking: 3),
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
  final int ranking;

  const PodiumProfile({Key key, this.ranking})
      : assert(ranking > 0 && ranking < 4, 'Podium is from 1 to 3.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaderboardNotifier>(
      builder: (context, notifier, child) {
        if (notifier.isLoading)
          return Center(child: const CircularProgressIndicator());
        if (notifier.hasError) return Center(child: const Icon(Icons.error));
        int index =
            ranking - 1 < notifier.leaderboard.length ? ranking - 1 : null;
        UserInfoModel user = index != null ? notifier.leaderboard[index] : null;
        if (ranking == null || user == null)
          return Center(
            child: CircleAvatar(
              backgroundColor: CupertinoColors.lightBackgroundGray,
              child: Text(ranking.toString()),
            ),
          );
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2),
            Text(
              '$ranking',
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: CupertinoColors.black,
                    fontWeight: ranking == 1
                        ? FontWeight.bold
                        : ranking == 2 ? FontWeight.w600 : FontWeight.w500,
                  ),
            ),
            const Spacer(),
            CachedNetworkImage(
              imageUrl: user.mediaRef,
              placeholder: (_, url) => CircleAvatar(
                radius: ranking == 1 ? 34.0 : 28.0,
                backgroundColor: CupertinoColors.lightBackgroundGray,
              ),
              errorWidget: (_, url, error) => CircleAvatar(
                radius: ranking == 1 ? 34.0 : 28.0,
                backgroundColor: CupertinoColors.lightBackgroundGray,
                child: Icon(Icons.error),
              ),
              imageBuilder: (_, image) {
                return CircleAvatar(
                  radius: ranking == 1 ? 34.0 : 28.0,
                  backgroundImage: image,
                );
              },
            ),
            const Spacer(),
            Text(
              user.givenName,
              softWrap: true,
              style: Theme.of(context).textTheme.overline,
            ),
            Text(
              user.university,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .overline
                  .copyWith(color: CupertinoColors.lightBackgroundGray),
            ),
            const Spacer(),
            Text(
              '${notifier.monthly ? user.experienceMonthly : user.experienceOverall} XP',
              softWrap: true,
              style: Theme.of(context).textTheme.overline,
            ),
            const Spacer(flex: 2),
          ],
        );
      },
    );
  }
}

class UserRankingListTile extends StatelessWidget {
  final UserInfoModel user;
  final int ranking;
  final bool monthly;

  const UserRankingListTile({Key key, this.user, this.monthly, this.ranking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: <Widget>[
          const SizedBox(width: 16.0),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Text(
                  ranking.toString(),
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
                  leading: CachedNetworkImage(
                    imageUrl: user.mediaRef,
                    placeholder: (_, url) => CircleAvatar(
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                    ),
                    errorWidget: (_, url, error) => CircleAvatar(
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                      child: Icon(Icons.error),
                    ),
                    imageBuilder: (_, image) {
                      return CircleAvatar(
                        backgroundImage: image,
                      );
                    },
                  ),
                  title: Text(user.givenName),
                  subtitle: Text(user.university),
                  trailing: Text(
                    '${monthly ? user.experienceMonthly : user.experienceOverall} pts',
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

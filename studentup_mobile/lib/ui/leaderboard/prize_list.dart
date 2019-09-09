import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/prize_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/prize_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/util/util.dart';

final double kBadgeSize = 48.0;

class PrizeList extends StatefulWidget {
  @override
  _PrizeListState createState() => _PrizeListState();
}

class _PrizeListState extends State<PrizeList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<PrizeNotifier>(
      builder: (_) => PrizeNotifier(),
      child: Consumer<PrizeNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading)
            return Center(child: const CircularProgressIndicator());
          if (notifier.hasError)
            return Center(child: Text(notifier.error.message));
          return CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: TimerHeaderDelegate(
                  expandedHeight: MediaQuery.of(context).size.height * 0.21,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverStaggeredGrid.extentBuilder(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  itemCount: notifier.prizes.length,
                  itemBuilder: (context, index) => PrizeGridTile(
                    key: ValueKey(notifier.prizes[index].docId),
                    model: notifier.prizes[index],
                  ),
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                      index < 3 ? 3 : 1, index < 3 ? 1.25 : 1.15),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PrizeGridTile extends StatelessWidget {
  final PrizeModel model;

  const PrizeGridTile({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        Router.prizeScreen,
        arguments: {'model': model},
      ),
      child: Card(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Hero(
                    tag: '${model.docId}',
                    child: CachedNetworkImage(
                      imageUrl: model.media,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: CupertinoColors.lightBackgroundGray,
                      ),
                      errorWidget: (_, __, error) => Container(
                        color: CupertinoColors.lightBackgroundGray,
                        child: Center(
                          child: const Icon(Icons.error),
                        ),
                      ),
                      imageBuilder: (_, image) => Container(
                        decoration: BoxDecoration(
                          image:
                              DecorationImage(image: image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          model.name,
                          style: Theme.of(context).textTheme.title,
                        ),
                        if (model.sponsored)
                          Text(
                            'Sponsored',
                            style: Theme.of(context).textTheme.caption,
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: -kBadgeSize / 2,
              left: -kBadgeSize / 2,
              child: Card(
                borderOnForeground: true,
                shape: CircleBorder(),
                child: SizedBox(
                  width: kBadgeSize,
                  height: kBadgeSize,
                  child: Center(
                    child: Text(
                      model.ranking.toString(),
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final Widget flexibleSpace;

  TimerHeaderDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    this.flexibleSpace,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final delegateSize = expandedHeight - shrinkOffset;
    final proportion = 2 - (expandedHeight / delegateSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight,
      child: Opacity(
        opacity: percent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Time until prize allocation',
              style: Theme.of(context).textTheme.title,
            ),
            Hero(
              tag: 'timer_prizes',
              child: FlipClock.reverseCountdown(
                duration: Util.getDuration(),
                backgroundColor: Theme.of(context).cardColor,
                digitColor: Theme.of(context).textTheme.title.color,
                digitSize: 32.0,
              ),
            ),
          ],
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
    return oldDelegate != this;
  }
}

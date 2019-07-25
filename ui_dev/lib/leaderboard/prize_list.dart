import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final double kBadgeSize = 48.0;

class PrizeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            itemCount: 12,
            itemBuilder: (context, index) => PrizeGridTile(
              key: ValueKey('prize_$index'),
              index: index,
            ),
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(index < 3 ? 3 : 1, index < 3 ? 1.25 : 1.15),
          ),
        ),
      ],
    );
  }
}

class PrizeGridTile extends StatelessWidget {
  final int index;

  const PrizeGridTile({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        'https://via.placeholder.com/150',
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
                        'Prize Name',
                        style: Theme.of(context).textTheme.title,
                      ),
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
                    '#${index + 1}',
                    style: Theme.of(context).textTheme.subtitle,
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
            FlipClock.reverseCountdown(
              duration: const Duration(days: 2, hours: 2, minutes: 2),
              backgroundColor: Theme.of(context).cardColor,
              digitColor: Theme.of(context).textTheme.title.color,
              digitSize: 32.0,
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

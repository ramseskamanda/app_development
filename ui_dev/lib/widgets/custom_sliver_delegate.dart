import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double stackChildHeight;
  final bool hideTitleWhenExpanded;
  final bool hideChildWhenExpanded;
  final Widget leading;
  final List<Widget> actions;
  final Widget title;
  final Widget flexibleSpace;

  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    this.hideChildWhenExpanded = false,
    this.leading,
    this.actions,
    this.title,
    this.flexibleSpace,
    this.stackChildHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition =
        expandedHeight - (stackChildHeight / 2) - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + (stackChildHeight / 2),
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              leading: leading,
              actions: actions,
              elevation: 0.0,
              title: Opacity(
                opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                child: title,
              ),
              flexibleSpace: flexibleSpace,
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: hideChildWhenExpanded ? percent : 1.0,
              child: Center(
                child: Material(
                  elevation: 6.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: stackChildHeight / 2,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://via.placeholder.com/150',
                      errorListener: () => print('object'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + stackChildHeight;

  @override
  double get minExtent => 100.0; //kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

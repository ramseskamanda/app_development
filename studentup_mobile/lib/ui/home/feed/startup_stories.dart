import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/feed_notifier.dart';

class StartupStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FeedNotifier>(
      builder: (context, feed, child) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount:
              !(feed.isLoading || feed.hasError) ? feed.startups.length + 1 : 6,
          separatorBuilder: (context, index) => const SizedBox(width: 10.0),
          itemBuilder: (context, index) {
            if (index == 0) return const SizedBox(width: 16.0);
            if (feed.isLoading)
              return CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.08,
                backgroundColor: CupertinoColors.lightBackgroundGray,
              );
            if (feed.hasError)
              return CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.08,
                backgroundColor: CupertinoColors.lightBackgroundGray,
                child: const Icon(
                  Icons.error,
                  color: CupertinoColors.destructiveRed,
                ),
              );
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: feed.startups[index - 1].imageUrl,
                  placeholder: (_, url) => CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.08,
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                  ),
                  errorWidget: (_, __, error) => CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.08,
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                    child: const Icon(
                      Icons.error,
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                  imageBuilder: (_, image) => CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.08,
                    backgroundImage: image,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  feed.startups[index - 1].name,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.bold)
                      .apply(color: CupertinoColors.black),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/feed_notifier.dart';
import 'package:studentup_mobile/router.dart';

class StartupStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FeedNotifier>(
      builder: (context, feed, child) {
        final int _length =
            !(feed.isLoading || feed.hasError) ? feed.startups.length + 2 : 6;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _length,
          separatorBuilder: (context, index) => const SizedBox(width: 10.0),
          itemBuilder: (context, index) {
            if (index == 0 || index == _length - 1)
              return const SizedBox(width: 16.0);
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
            StartupInfoModel model = feed.startups[index - 1];
            return GestureDetector(
              onTap: () {
                if (model != null)
                  Navigator.of(context).pushNamed(
                    Router.otherProfile,
                    arguments: {
                      'infoModel': Preview(
                        givenName: model.name,
                        imageUrl: model.imageUrl,
                        uid: model.docId,
                        isStartup: true,
                      ),
                    },
                  );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: model.imageUrl,
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
                  Text(model.name,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

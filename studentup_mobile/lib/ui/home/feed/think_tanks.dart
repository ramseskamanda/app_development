import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/feed_notifier.dart';
import 'package:studentup_mobile/ui/think_tank/think_tank.dart';

class ThinkTankPreviewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FeedNotifier>(
      builder: (context, feed, child) {
        if (feed.isLoading)
          return Center(child: const CircularProgressIndicator());
        if (feed.hasError) return Center(child: Text(feed.error.message));
        if (feed.thinkTanks.isEmpty)
          return Center(child: const Text('No think tanks here right now...'));
        return Column(
          children: <Widget>[
            for (ThinkTanksModel model in feed.thinkTanks) ...[
              ThinkTankPreview(model: model),
              SizedBox(
                height: 16.0,
              )
            ],
          ],
        );
      },
    );
  }
}

class ThinkTankPreview extends StatelessWidget {
  final ThinkTanksModel model;

  const ThinkTankPreview({Key key, @required this.model}) : super(key: key);

  void _goToThinkTank(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => ThinkTank(model: model),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () => _goToThinkTank(context),
            leading: CachedNetworkImage(
              imageUrl: model.askerImage,
              placeholder: (_, url) => CircleAvatar(
                backgroundColor: CupertinoColors.lightBackgroundGray,
              ),
              errorWidget: (_, __, error) => CircleAvatar(
                backgroundColor: CupertinoColors.lightBackgroundGray,
                child: const Icon(
                  Icons.error,
                  color: CupertinoColors.destructiveRed,
                ),
              ),
              imageBuilder: (_, image) => CircleAvatar(
                backgroundImage: image,
              ),
            ),
            title: Text(model.title),
            subtitle: Text(model.premise),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),
          GestureDetector(
            onTap: () => _goToThinkTank(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text('${model.commentCount} solutions posted'),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

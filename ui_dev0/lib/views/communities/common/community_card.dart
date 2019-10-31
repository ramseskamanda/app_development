import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/views/community_page/community_page_view.dart';

class CommunityCard extends StatelessWidget {
  final CommunityModel community;
  const CommunityCard({Key key, @required this.community}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CommunityPageView(community: community),
        ),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.26,
        child: Card(
          child: FractionallySizedBox(
            widthFactor: 0.86,
            child: Column(
              children: <Widget>[
                Spacer(flex: 3),
                Text(
                  community.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title.apply(
                        fontSizeFactor: 1.1,
                        fontWeightDelta: 2,
                      ),
                ),
                Spacer(),
                Text(
                  'Created by ${community.creator.name}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.group_solid,
                      color: Theme.of(context).accentColor,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '${community.memberCount} member(s)',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle.apply(
                          fontSizeDelta: 5,
                          color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  community.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subhead,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

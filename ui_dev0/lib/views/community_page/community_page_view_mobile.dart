import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/views/communities/common/community_action_menu.dart';
import 'package:ui_dev0/views/community_page/common/community_feed.dart';
import 'package:ui_dev0/views/community_page/common/community_files.dart';
import 'package:ui_dev0/views/community_page/common/community_info.dart';
import 'package:ui_dev0/views/community_page/state/community_controller.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';

class CommunityPageViewMobilePortrait
    extends BaseModelWidget<CommunityController> {
  final bool userJoined = true;
  final bool userRequestedAccess = true;
  final List<Tab> _tabs = [
    Tab(text: 'Discussions'),
    Tab(text: 'Files'),
  ];
  @override
  Widget build(BuildContext context, CommunityController model) {
    CommunityModel community = model.model;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Theme.of(context).iconTheme.color,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Column(
            children: <Widget>[
              Text(
                community.name,
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                'Created by ${community.creator.name}',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ],
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: _tabs,
            indicatorColor: Theme.of(context).accentColor,
            labelColor: Theme.of(context).textTheme.title.color,
          ),
          actions: <Widget>[
            ActionMenuCommunities(
              reportCallback: () => print('report ${community.name}'),
              canLeave:
                  userJoined || (!community.public && userRequestedAccess),
              canRequestToJoin:
                  !community.public && !userJoined && !userRequestedAccess,
              canJoin: community.public && !userJoined,
              modifyMembership: (requesting, joining) {
                if (requesting != null) {
                  print('requesting to join with text: "$requesting');
                } else {
                  if (joining) {
                    print('joining community');
                  } else {
                    if (userJoined) {
                      print('leaving group');
                    } else if (userRequestedAccess) {
                      print('withdrawing request');
                    }
                  }
                }
              },
              getInfo: true,
              getInfoCallback: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CommunityInfo(
                      community: community,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              CommunityPageFeed(),
              CommunityPageFiles(),
            ],
          ),
        ),
      ),
    );
  }
}

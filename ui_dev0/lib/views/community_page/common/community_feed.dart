import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/views/communities/common/community_action_menu.dart';
import 'package:ui_dev0/views/communities/common/community_post.dart';
import 'package:ui_dev0/views/community_page/common/community_input.dart';
import 'package:ui_dev0/views/community_page/state/community_controller.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';

class CommunityPageFeed extends BaseModelWidget<CommunityController> {
  @override
  Widget build(BuildContext context, CommunityController controller) {
    final CommunityModel community = controller.model;
    final bool userJoined = false; //Provider.of<CommunitiesController>(context)
    // .userCommunities
    // .value
    // .contains(community);
    final bool userRequestedAccess = true;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            if (community.public) ...[
              if (!userJoined) ...[
                const SizedBox(height: 16.0),
                FractionallySizedBox(
                  widthFactor: 0.86,
                  child: CupertinoButton.filled(
                    pressedOpacity: 0.7,
                    child: const Text('Join Community'),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
              Expanded(child: CommunityPostsFeed(postStream: controller.posts)),
            ] else ...[
              if (!userJoined) ...[
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 16.0),
                      Text(community.description),
                      const SizedBox(height: 16.0),
                      const Text(
                        'This is a private community.'
                        '\nRequest access to see all posts and members!',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                FractionallySizedBox(
                  widthFactor: 0.86,
                  child: CupertinoButton.filled(
                    pressedOpacity: 0.7,
                    child: !userRequestedAccess
                        ? const Text('Request Access')
                        : const Text('Withdraw Request'),
                    onPressed: () async {
                      if (!userRequestedAccess) {
                        final String result =
                            await showRequestAccessDialog(context);
                        if (result != null)
                          print('requesting access with text: "$result"');
                      } else {
                        print('withdrawing request');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
              ] else ...[
                CommunityPostsFeed(postStream: controller.posts),
              ]
            ],
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(child: CommunityTextField()),
        ),
      ],
    );
  }
}

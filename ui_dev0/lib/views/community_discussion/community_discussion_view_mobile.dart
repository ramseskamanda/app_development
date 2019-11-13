import 'package:flutter/material.dart';
import 'package:ui_dev0/views/communities/common/community_post.dart';
import 'package:ui_dev0/views/community_discussion/state/discussion_controller.dart';
import 'package:ui_dev0/views/community_page/common/community_input.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';

class CommunityDiscussionViewMobilPortrait
    extends BaseModelWidget<DiscussionController> {
  @override
  Widget build(BuildContext context, DiscussionController controller) {
    return Scaffold(
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
              'Conversation',
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              'Communities > ${controller.root.communityName}',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: CommunityPost(
                post: controller.root,
                communityName: controller.root.communityName,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CommunityTextField(),
            ),
          ],
        ),
      ),
    );
  }
}

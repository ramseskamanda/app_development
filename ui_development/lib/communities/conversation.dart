import 'package:flutter/material.dart';
import 'package:ui_development/communities/community_post.dart';
import 'package:ui_development/models.dart';

class Conversation extends StatelessWidget {
  final CommunityPostModel post;
  final String communityName;
  const Conversation({Key key, this.post, this.communityName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              'Communities > $communityName',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: CommunityPost(
            post: post,
            communityName: communityName,
          ),
        ),
      ),
    );
  }
}

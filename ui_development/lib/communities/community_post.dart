import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_development/communities/conversation.dart';
import 'package:ui_development/data.dart';
import 'package:ui_development/models.dart';
import 'package:ui_development/photo_gallery/image_gallery.dart';
import 'package:ui_development/util.dart';
import 'package:ui_development/widgets/community_action_menu.dart';
import 'package:ui_development/widgets/file_widget.dart';
import 'package:ui_development/widgets/reaction_tag.dart';

class AllCommunityPosts extends StatelessWidget {
  final CommunityModel community;

  const AllCommunityPosts({
    Key key,
    @required this.community,
  }) : super(key: key);

  List<Widget> _buildCommunityPosts() {
    List<CommunityPostModel> posts;
    if (community == defaultCommunity) {
      //Make this not a thing anymore through collectionGroupQueries
      posts = listCommunities
          .expand<CommunityPostModel>((community) => community.posts)
          .toList()
            ..sort((a, b) => b.postedAt.compareTo(a.postedAt));
    } else {
      posts = community.posts;
    }
    return posts
        .map(
          (post) => Card(
            child: CommunityPost.preview(
              post: post,
              communityName: community.name,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildCommunityPosts(),
    );
  }
}

class CommunityPostContent extends StatelessWidget {
  final bool preview;
  final String communityName;
  final CommunityPostModel post;
  const CommunityPostContent({
    Key key,
    @required this.post,
    @required this.preview,
    @required this.communityName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: post.replyGeneration * 24.0),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              if (preview) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Conversation(
                      post: post,
                      communityName: communityName,
                    ),
                  ),
                );
              } else {
                print('Go To Profile!');
              }
            },
            leading: GestureDetector(
              onTap: () => print('Go To Profile'),
              child: CachedNetworkImage(
                imageUrl: post.originalPoster.photoUrl,
                imageBuilder: (_, image) =>
                    CircleAvatar(backgroundImage: image),
              ),
            ),
            title: Row(
              children: <Widget>[
                Text(post.originalPoster.name),
                if (post.replyGeneration > 0) ...[
                  const SizedBox(width: 4.0),
                  Text(
                    formatDateTime(post.postedAt),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ],
            ),
            subtitle: post.replyGeneration == 0
                ? Text(formatDateTime(post.postedAt))
                : null,
            trailing: ActionMenuCommunities(
              reportCallback: () => print('report: ${post.hashCode} (post)'),
              replyConversation: post.replyGeneration == 1,
              reactComment: post.replyGeneration == 1,
              reactCallback: (reaction) => print(reaction),
            ),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              if (preview) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Conversation(
                      post: post,
                      communityName: communityName,
                    ),
                  ),
                );
              }
            },
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(post.content),
                  if (post.files.isNotEmpty) ...[
                    const SizedBox(height: 12.0),
                    ImagePostDisplayer(
                      images: post.files
                          .where((file) => file.fileType == 'image')
                          .toList(),
                    ),
                    const SizedBox(height: 12.0),
                    ...post.files
                        .where((file) => file.fileType != 'image')
                        .map((file) => FileWidget(file: file)),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          if (post.reactions.isNotEmpty) ...[
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                children: post.reactions.entries
                    .map(
                      (entry) => ReactionTag(
                        reactionType: entry.key,
                        count: entry.value,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 12.0),
          ],
        ],
      ),
    );
  }
}

class CommunityPost extends StatelessWidget {
  final String communityName;
  final CommunityPostModel post;
  final bool preview;
  const CommunityPost(
      {Key key, @required this.post, @required this.communityName})
      : preview = false,
        super(key: key);
  const CommunityPost.preview(
      {Key key, @required this.post, @required this.communityName})
      : preview = true,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CommunityPostContent(
          post: post,
          preview: preview,
          communityName: communityName,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton.icon(
                color: Colors.transparent,
                icon: const Icon(Icons.insert_emoticon),
                label: const Text('React'),
                onPressed: () async {
                  final String result = await showReactionDialog(context);
                  if (result != null) print(result);
                },
              ),
            ),
            Expanded(
              child: FlatButton.icon(
                  color: Colors.transparent,
                  icon: const Icon(Icons.reply),
                  label: const Text('Reply'),
                  onPressed: () {
                    if (preview) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Conversation(
                            post: post,
                            communityName: communityName,
                          ),
                        ),
                      );
                    } else {
                      print('Open TextField to reply with @someone');
                    }
                  }),
            ),
          ],
        ),
        if (preview) ...[
          if (post.replies.isNotEmpty) ...[
            CommunityPostContent(
              post: post.replies.first,
              preview: preview,
              communityName: communityName,
            ),
            if (post.replies.length > 1)
              ListTile(
                title: Text(
                  'See ${post.replyCount} more replies',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Conversation(
                      post: post,
                      communityName: communityName,
                    ),
                  ),
                ),
              ),
          ],
        ] else
          ...post.replies.map(
            (reply) => CommunityPostContent(
              preview: preview,
              post: reply,
              communityName: communityName,
              key: ValueKey(reply),
            ),
          ),
      ],
    );
  }
}

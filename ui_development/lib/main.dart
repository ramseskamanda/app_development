import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_development/data.dart';
import 'package:ui_development/models.dart';
import 'package:ui_development/photo_gallery/image_gallery.dart';
import 'package:ui_development/search_bar.dart';
import 'package:ui_development/theme.dart';
import 'package:ui_development/util.dart';
import 'package:ui_development/widgets/community_action_menu.dart';

import 'package:uuid/uuid.dart';

final uuid = new Uuid();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Communities(),
    );
  }
}

class Communities extends StatelessWidget {
  final CommunityDiscoverer discoverer = CommunityDiscoverer();
  final List<Tab> _tabs = [
    Tab(text: 'Discover'),
    Tab(text: 'My Communities'),
    Tab(text: 'My Feed'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            color: Theme.of(context).iconTheme.color,
            onPressed: () {},
          ),
          title: Text(
            'Communities',
            style: TextStyle(color: Theme.of(context).textTheme.title.color),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(CupertinoIcons.search),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {},
            )
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: _tabs,
            indicatorColor: Theme.of(context).accentColor,
            labelColor: Theme.of(context).textTheme.title.color,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              //Make this more efficient by only creating CommunityDiscoverer once
              ChangeNotifierProvider<CommunityDiscoverer>.value(
                value: discoverer,
                child: DiscoverCommunities(),
              ),
              MyCommunities(),
              MyCommunityFeed(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateCommunity()),
          ),
        ),
      ),
    );
  }
}

class DiscoverCommunities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CommunityDiscoverer discoverer = Provider.of(context);

    if (discoverer.hasError)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('An Error Occured...'),
            RaisedButton(
              child: const Text('Retry now!'),
              onPressed: () async => await discoverer.fetchData(),
            ),
          ],
        ),
      );

    if (discoverer.isLoading) return Center(child: CircularProgressIndicator());

    return LiquidPullToRefresh(
      onRefresh: () async => discoverer.fetchData(),
      child: ListView(
        children: listCommunities
            .map((community) => CommunityCard(community: community))
            .toList(),
      ),
    );
  }
}

class MyCommunities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: listCommunities.map((community) {
            return Card(
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: community.creator.photoUrl,
                  imageBuilder: (context, image) {
                    return CircleAvatar(
                      backgroundImage: image,
                    );
                  },
                ),
                title: Text(community.name),
                subtitle: Text(community.description),
                trailing: Chip(
                  label: Text(community.memberCount.toString()),
                  backgroundColor: CupertinoColors.activeBlue,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CommunityPage(
                        community: community,
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MyCommunityFeed extends StatefulWidget {
  @override
  _MyCommunityFeedState createState() => _MyCommunityFeedState();
}

class _MyCommunityFeedState extends State<MyCommunityFeed> {
  static final Random rand = Random();
  CommunityModel selected;
  final List<CommunityModel> _items = [
    defaultCommunity,
    ...listCommunities,
  ];

  @override
  void initState() {
    super.initState();
    selected = _items[0];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 16.0),
        Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selected,
              onChanged: (val) => setState(() => selected = val),
              items: _items
                  .map(
                    (community) => DropdownMenuItem(
                      value: community,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(community.name),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        AllCommunityPosts(community: selected),
        const SizedBox(height: kBottomNavigationBarHeight),
      ],
    );
  }
}

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

class CommunityCard extends StatelessWidget {
  final CommunityModel community;
  const CommunityCard({Key key, @required this.community}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CommunityPage(community: community),
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

class CommunityPage extends StatelessWidget {
  final CommunityModel community;
  final bool userJoined = true;
  final bool userRequestedAccess = false;
  final List<Tab> _tabs = [
    Tab(text: 'Discussions'),
    Tab(text: 'Files'),
  ];
  CommunityPage({Key key, @required this.community}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              CommunityPagePosts(community: community),
              CommunityPageFiles(community: community),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityPagePosts extends StatelessWidget {
  final CommunityModel community;
  final bool userJoined = true;
  final bool userRequestedAccess = false;

  const CommunityPagePosts({Key key, this.community}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
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
          AllCommunityPosts(community: community),
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
            AllCommunityPosts(community: community),
          ]
        ],
      ],
    );
  }
}

class CommunityPageFiles extends StatelessWidget {
  final CommunityModel community;

  const CommunityPageFiles({Key key, this.community}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<FileAsset> _files =
        community.posts.expand((post) => post.files).toList();
    if (_files.isEmpty)
      return Center(
        child: const Text('No files shared yet!'),
      );
    return ListView(
      children: _files
          .map((file) => FileWidget(key: ValueKey(file.id), file: file))
          .toList(),
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
                      (entry) => ActionChip(
                        avatar: Text(
                          chipEmojis[entry.key] ?? chipEmojis['default'],
                        ),
                        label: entry.key != null
                            ? Text(
                                entry.value?.toString() ?? 'Error 415',
                                style: TextStyle(
                                  color: chipLabelColor[entry.key] ??
                                      chipLabelColor['default'],
                                ),
                              )
                            : const Text('Error 415'),
                        backgroundColor:
                            chipColors[entry.key] ?? chipColors['default'],
                        onPressed: () {},
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

class FileWidget extends StatelessWidget {
  final FileAsset file;

  const FileWidget({Key key, @required this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => print('Open file'),
        title: Text(file.fileName),
        trailing: ActionMenuCommunities(
          reportCallback: () => print('report ${file.fileName}'),
        ),
        leading: file.fileType == 'image'
            ? const Text('📸', style: TextStyle(fontSize: 24.0))
            : const Text('🗂️', style: TextStyle(fontSize: 24.0)),
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

class ReactionPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        children: reactionEmojis
            .map(
              (emoji) => IconButton(
                icon: Text(
                  emoji,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop<String>(emoji);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

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

class CommunityInfo extends StatelessWidget {
  final CommunityModel community;

  const CommunityInfo({
    Key key,
    @required this.community,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: <Widget>[
            Text(
              community.name,
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              'Communities > ${community.name} > Info',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
        actions: <Widget>[
          ActionMenuCommunities(
            reportCallback: () => print('report : ${community.name}'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            if (!community.public && community.creator == currentUser) ...[
              const SizedBox(height: 16.0),
              FractionallySizedBox(
                widthFactor: 0.86,
                child: CupertinoButton.filled(
                  pressedOpacity: 0.7,
                  child: const Text('See Pending Requests'),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 16.0),
            ],
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Description', //Why we do it
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .apply(color: Theme.of(context).textTheme.title.color),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Text(community.description),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Members', //Who we are
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .apply(color: Theme.of(context).textTheme.title.color),
                  ),
                  if (community.public ||
                      (!community.public &&
                          currentUser.adminRoles.contains(community.id)))
                    IconButton(
                      icon: Icon(Icons.person_add),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CommunityMemberAddingPage(
                              currentMembers: community.members
                                ..insert(0, community.creator),
                            ),
                          ),
                        );
                      },
                    )
                ],
              ),
            ),
            MemberListTile(
              memberIsCreator: true,
              member: community.creator,
              communityId: community.id,
            ),
            ...community.members
                .map(
                  (member) => MemberListTile(
                    memberIsCreator: member == community.creator,
                    member: member,
                    communityId: community.id,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class CommunityMemberAddingPage extends StatefulWidget {
  final List<UserModel> currentMembers;
  const CommunityMemberAddingPage({
    Key key,
    @required this.currentMembers,
  }) : super(key: key);
  @override
  _CommunityMemberAddingPageState createState() =>
      _CommunityMemberAddingPageState();
}

class _CommunityMemberAddingPageState extends State<CommunityMemberAddingPage> {
  int length = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text('Add Members'),
        actions: <Widget>[
          CupertinoButton(
            child: const Text('Done'),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 0.9,
            child: CommunityMemberAdder(
              onAdd: () async => setState(() => length += 1),
              onDelete: (member) => setState(() => length -= 1),
              members: widget.currentMembers.sublist(
                  0,
                  length > widget.currentMembers.length
                      ? widget.currentMembers.length
                      : length),
            ),
          ),
        ),
      ),
    );
  }
}

class MemberListTile extends StatelessWidget {
  final String communityId;
  final bool memberIsCreator;
  final UserModel member;

  const MemberListTile({
    Key key,
    @required this.communityId,
    @required this.memberIsCreator,
    @required this.member,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool userIsAdmin = member.adminRoles.contains(communityId);
    return Card(
      child: ListTile(
        onTap: () {
          print('GO TO PROFILE');
        },
        leading: CachedNetworkImage(
          imageUrl: member.photoUrl,
          imageBuilder: (context, image) {
            return CircleAvatar(backgroundImage: image);
          },
        ),
        title: RichText(
          text: TextSpan(
            text: member.name,
            style: TextStyle(color: Theme.of(context).textTheme.title.color),
            children: [
              if (userIsAdmin)
                TextSpan(
                  text: '\t\t\tadmin',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              if (memberIsCreator)
                TextSpan(
                  text: '${userIsAdmin ? ' + ' : '\t\t\t'}creator',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
            ],
          ),
        ),
        trailing: ActionMenuCommunities(
          reportCallback: () => print('report: ${member.name}'),
          canLeave: member == currentUser,
          modifyMembership: (requesting, joining) => print('joining/leaving'),
        ),
      ),
    );
  }
}

class CreateCommunity extends StatefulWidget {
  @override
  _CreateCommunityState createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  final CommunityCreator communityCreator = CommunityCreator();
  int _currentPageIndex = 0;
  PageController _controller;
  final List<Widget> _list = <Widget>[
    CreateCommunityInfo(),
    CreateCommunityPrivacy(),
    CreateCommunityFirstMembers(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController()
      ..addListener(() =>
          setState(() => _currentPageIndex = _controller.page.truncate()));
  }

  @override
  void dispose() {
    communityCreator.dispose();
    _controller.dispose();
    super.dispose();
  }

  void previousPage() {
    if (_currentPageIndex == 0) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
    _controller.previousPage(
      duration: kTabScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    FocusScope.of(context).unfocus();
    if (_currentPageIndex == _list.length - 1) return;
    _controller.nextPage(
      duration: kTabScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  String _buildTitle() {
    switch (_currentPageIndex) {
      case 0:
        return 'Create Community';
      case 1:
        return 'Community Privacy';
      case 2:
        return 'First Members';
      default:
        return 'Create Community';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Theme.of(context).iconTheme.color,
          icon: Icon(Icons.arrow_back),
          onPressed: previousPage,
        ),
        title: Text(
          _buildTitle(),
          style: TextStyle(color: Theme.of(context).textTheme.title.color),
        ),
      ),
      body: ChangeNotifierProvider<CommunityCreator>.value(
        value: communityCreator,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                children: _list,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.86,
                  child: StreamBuilder<String>(
                      stream: communityCreator.input.name,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          shape: StadiumBorder(),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: _currentPageIndex != _list.length - 1
                              ? Text('Next')
                              : Text('Finish'),
                          onPressed:
                              (snapshot.hasData && snapshot.data.length >= 3)
                                  ? nextPage
                                  : null,
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateCommunityInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.86,
        child: Consumer<CommunityCreator>(
            builder: (context, communityCreator, child) {
          return Column(
            children: <Widget>[
              const SizedBox(height: 32.0),
              TextField(
                controller: communityCreator.input.nameController,
                maxLines: 1,
                maxLength: 32,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Community Name',
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: communityCreator.input.descriptionController,
                minLines: 5,
                maxLines: null,
                maxLength: 400,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write a description',
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CreateCommunityPrivacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CommunityCreator communityCreator = Provider.of(context);
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.86,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 32.0),
            const Text(
              'Would you like to create a public or private community?\nThis can still be changed after creation.',
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            RadioListTile<CommunityPrivacy>(
              title: const Text('Private Community'),
              subtitle: const Text('Invite-only community.'),
              value: CommunityPrivacy.private,
              groupValue: communityCreator.setting,
              onChanged: (val) => communityCreator.setting = val,
            ),
            RadioListTile<CommunityPrivacy>(
              title: const Text('Public Community'),
              subtitle: const Text('Everyone can see and join the community.'),
              value: CommunityPrivacy.public,
              groupValue: communityCreator.setting,
              onChanged: (val) => communityCreator.setting = val,
            ),
          ],
        ),
      ),
    );
  }
}

class CreateCommunityFirstMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CommunityCreator communityCreator = Provider.of(context);
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.86,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 32.0),
            Text(
              'Almost done! As a last step, invite the first members to your community.',
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.body2.apply(fontSizeDelta: 3),
            ),
            const SizedBox(height: 32.0),
            CommunityMemberAdder(
              members: communityCreator.earlyMembers,
              onAdd: () async => communityCreator.addMember(uuid.v4()),
              onDelete: (member) => communityCreator.removeMember(member),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}

class CommunityMemberAdder extends StatelessWidget {
  final List<UserModel> members;
  final void Function(UserModel) onDelete;
  final Future<void> Function() onAdd;

  const CommunityMemberAdder({
    Key key,
    @required this.members,
    @required this.onDelete,
    @required this.onAdd,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          title: 'Search for new members',
          widthFactor: 1.0,
          callback: () async => await onAdd(),
        ),
        const SizedBox(height: 32.0),
        if (members.length == 0) ...[
          const Text('No members added yet!'),
        ] else
          ...members.map((member) {
            return ListTile(
              title: Text(member.name),
              leading: CachedNetworkImage(
                imageUrl: member.photoUrl,
                imageBuilder: (context, image) {
                  return CircleAvatar(backgroundImage: image);
                },
              ),
              trailing: IconButton(
                icon: Icon(
                  CupertinoIcons.delete,
                  color: CupertinoColors.destructiveRed,
                ),
                onPressed: () => onDelete(member),
              ),
              onTap: () => print('GO TO PROFILE'),
            );
          }),
      ],
    );
  }
}

enum CommunityPrivacy {
  private,
  public,
}

class CommunityCreator extends ChangeNotifier {
  final CommunityCreatorBloc _inputBloc = CommunityCreatorBloc();
  CommunityPrivacy _setting = CommunityPrivacy.public;
  final List<UserModel> _earlyMembers = [];

  CommunityCreatorBloc get input => _inputBloc;
  CommunityPrivacy get setting => _setting;
  List<UserModel> get earlyMembers => _earlyMembers;

  set setting(CommunityPrivacy value) {
    _setting = value;
    notifyListeners();
  }

  void addMember(String value) {
    _earlyMembers.add(
      UserModel(
        name: value,
        photoUrl: 'assets/portrait.jpeg',
        adminRoles: [],
      ),
    );
    notifyListeners();
  }

  void removeMember(UserModel value) {
    _earlyMembers.remove(value);
    notifyListeners();
  }

  @override
  void dispose() {
    _inputBloc.dispose();
    super.dispose();
  }
}

class CommunityCreatorBloc {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final BehaviorSubject<String> _nameStream = BehaviorSubject();
  final BehaviorSubject<String> _descriptionStream = BehaviorSubject();

  TextEditingController get nameController => _name;
  TextEditingController get descriptionController => _description;
  ValueObservable<String> get name => _nameStream.stream;
  ValueObservable<String> get description => _descriptionStream.stream;

  CommunityCreatorBloc() {
    _name.addListener(() => _nameStream.sink.add(_name.text));
    _description
        .addListener(() => _descriptionStream.sink.add(_description.text));
  }

  void dispose() {
    _name.dispose();
    _description.dispose();
    _nameStream.close();
    _descriptionStream.close();
  }
}

class CommunityDiscoverer extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  CommunityDiscoverer() {
    print('CommunityDiscoverer gets built now');
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      _hasError = false;
      print('fetching data');
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading = false;
    } catch (e) {
      hasError = true;
    }
  }
}

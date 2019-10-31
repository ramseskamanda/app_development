import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_development/communities/community_post.dart';
import 'package:ui_development/communities/create/members.dart';
import 'package:ui_development/data.dart';
import 'package:ui_development/models.dart';
import 'package:ui_development/widgets/community_action_menu.dart';
import 'package:ui_development/widgets/file_widget.dart';

class CommunityPage extends StatelessWidget {
  final CommunityModel community;
  final bool userJoined = true;
  final bool userRequestedAccess = true;
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
  final bool userRequestedAccess = true;

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

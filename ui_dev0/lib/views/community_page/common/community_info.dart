import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/data_models/user_model.dart';
import 'package:ui_dev0/service_models/fake_data.dart';
import 'package:ui_dev0/views/communities/common/community_action_menu.dart';
import 'package:ui_dev0/views/create_community/common/members.dart';

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
            if (!community.public &&
                community.creator == FakeData.currentUser) ...[
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
                          FakeData.currentUser.adminRoles
                              .contains(community.id)))
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
          canLeave: member == FakeData.currentUser,
          modifyMembership: (requesting, joining) => print('joining/leaving'),
        ),
      ),
    );
  }
}

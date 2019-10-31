import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_development/communities/create/state_management/members.dart';
import 'package:ui_development/models.dart';
import 'package:ui_development/search_bar.dart';
import 'package:uuid/uuid.dart';

class CreateCommunityFirstMembers extends StatelessWidget {
  final Uuid uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    final CommunityMemberAdderViewModel viewModel = Provider.of(context);
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
              members: viewModel.earlyMembers,
              onAdd: () async => viewModel.addMember(testUser),
              onDelete: (member) => viewModel.removeMember(member),
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
          ...members.map(
            (member) {
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
            },
          ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studentup/ui/widgets/limited_text.dart';

final String _kTestText =
    'This is an example message that is too long to display in only the required number of characters, therefore it is expandable.';

class MessageThreadTile extends StatelessWidget {
  final int index;
  final GlobalKey<SlidableState> _slidableKey = GlobalKey<SlidableState>();

  MessageThreadTile({Key key, this.index}) : super(key: key);

  void _toggleOpen() {
    if (_slidableKey.currentState.overallMoveAnimation.isCompleted)
      _slidableKey.currentState.close();
    else
      _slidableKey.currentState.open(actionType: SlideActionType.secondary);
  }

  void _handleTap() {
    if (_slidableKey.currentState.overallMoveAnimation.isCompleted)
      _slidableKey.currentState.close();
    else
      print('Navigate to messages with $index');
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: _slidableKey,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          icon: FeatherIcons.trash2,
          caption: 'Delete',
          color: CupertinoColors.destructiveRed,
          onTap: () => print('Delete Conversation'),
        )
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          child: ListTile(
            leading: CircleAvatar(
              radius: 28.0,
              backgroundImage: CachedNetworkImageProvider(
                'https://via.placeholder.com/150',
                errorListener: () => print('Error CachedNetworkImage'),
              ),
            ),
            title: Text('Ramses Kamanda'),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: LimitedText(
                    text: _kTestText,
                    height: 50.0,
                  ),
                ),
                SizedBox(width: 8.0),
                Text('•'),
                SizedBox(width: 8.0),
                Text('3w'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(FeatherIcons.moreHorizontal),
              onPressed: _toggleOpen,
            ),
            onTap: _handleTap,
            onLongPress: () => print('Show preview and vibrate'),
          ),
        ),
      ),
    );
  }
}

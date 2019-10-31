import 'package:flutter/material.dart';
import 'package:ui_dev0/utils/theme_utils.dart';

class ReactionTag extends StatelessWidget {
  final String reactionType;
  final int count;

  const ReactionTag(
      {Key key, @required this.reactionType, @required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Text(
        chipEmojis[reactionType] ?? chipEmojis['default'],
      ),
      label: reactionType != null
          ? Text(
              count?.toString() ?? 'Error 415',
              style: TextStyle(
                color:
                    chipLabelColor[reactionType] ?? chipLabelColor['default'],
              ),
            )
          : const Text('Error 415'),
      backgroundColor: chipColors[reactionType] ?? chipColors['default'],
      onPressed: () {},
    );
  }
}

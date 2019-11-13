import 'package:flutter/material.dart';
import 'package:ui_dev0/utils/theme_utils.dart';

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
              (emoji) => Center(
                child: InkWell(
                  child: Text(
                    emoji,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop<String>(emoji);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

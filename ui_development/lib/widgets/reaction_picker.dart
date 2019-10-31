import 'package:flutter/material.dart';
import 'package:ui_development/theme.dart';

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

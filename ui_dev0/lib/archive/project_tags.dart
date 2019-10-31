import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const Map<String, String> tagEmojis = {
  'location': '🌍',
  'type': '👔',
  'workload': '🕓',
};
const Map<String, Color> tagColors = {
  'location': CupertinoColors.activeBlue,
  'type': CupertinoColors.activeOrange,
  'workload': Colors.pink,
};

class ProjectTags extends StatelessWidget {
  final Map<String, dynamic> tags;

  const ProjectTags({Key key, this.tags = const <String, String>{}})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: tags.entries.map(
        (entry) {
          return Chip(
            label: Text(
              entry.value.toString(),
              style: TextStyle(color: CupertinoColors.white),
            ),
            avatar: Text(tagEmojis[entry.key]),
            backgroundColor: tagColors[entry.key],
          );
        },
      ).toList(),
    );
  }
}

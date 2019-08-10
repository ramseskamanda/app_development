import 'package:flutter/material.dart';
import 'package:ui_dev/enum/popup_actions.dart';

class PopupMenuWithActions extends StatelessWidget {
  final void Function() onDelete;

  const PopupMenuWithActions({Key key, this.onDelete}) : super(key: key);

  void _runCommand(PopupAction action) {
    switch (action) {
      case PopupAction.DELETE:
        onDelete();
        break;
      default:
        print('No actions matched for: $action');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: _runCommand,
      itemBuilder: (context) {
        return [
          if (onDelete != null)
            PopupMenuItem(
              value: PopupAction.DELETE,
              enabled: true,
              child: ListTile(
                title: const Text('Delete'),
                trailing: Icon(Icons.delete),
              ),
            ),
        ];
      },
    );
  }
}

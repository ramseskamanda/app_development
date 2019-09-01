import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/popup_actions.dart';

class PopupMenuWithActions extends StatelessWidget {
  final void Function() onDelete;
  final void Function() onLogout;

  const PopupMenuWithActions({Key key, this.onDelete, this.onLogout})
      : super(key: key);

  void _runCommand(PopupAction action) {
    switch (action) {
      case PopupAction.DELETE:
        onDelete();
        break;
      case PopupAction.LOGOUT:
        onLogout();
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
          if (onLogout != null)
            PopupMenuItem(
              value: PopupAction.LOGOUT,
              enabled: true,
              child: ListTile(
                title: const Text('Logout'),
                trailing: Icon(Icons.power_settings_new),
              ),
            ),
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

import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/popup_actions.dart';

class PopupMenuWithActions extends StatelessWidget {
  final void Function() onDelete;
  final void Function() onLogout;
  final Color color;

  const PopupMenuWithActions({
    Key key,
    this.onDelete,
    this.onLogout,
    this.color = Colors.transparent,
  }) : super(key: key);

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
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: PopupMenuButton(
        elevation: 10.0,
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
      ),
    );
  }
}

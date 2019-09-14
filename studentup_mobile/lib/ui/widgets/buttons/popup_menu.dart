import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/popup_actions.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';

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

  Future<void> _runCommand(PopupAction action, BuildContext context) async {
    try {
      switch (action) {
        case PopupAction.DELETE:
          if (await Dialogs.showDeletionDialog(context)) onDelete();
          break;
        case PopupAction.LOGOUT:
          if (await Dialogs.showLogoutDialog(context)) onLogout();
          break;
        default:
          print('No actions matched for: $action');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: PopupMenuButton(
        icon: const Icon(Icons.more_horiz),
        elevation: 10.0,
        onSelected: (PopupAction ac) async => _runCommand(ac, context),
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

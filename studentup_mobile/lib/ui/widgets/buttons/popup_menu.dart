import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/popup_actions.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';

class PopupMenuWithActions extends StatelessWidget {
  final void Function() onDelete;
  final void Function() onLogout;
  final void Function() onSettings;
  final void Function() onEdit;
  final Color color;

  const PopupMenuWithActions({
    Key key,
    this.onDelete,
    this.onLogout,
    this.onSettings,
    this.onEdit,
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
        case PopupAction.SETTINGS:
          onSettings();
          break;
        case PopupAction.EDIT:
          onEdit();
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
            if (onSettings != null)
              PopupMenuItem(
                value: PopupAction.SETTINGS,
                enabled: true,
                child: ListTile(
                  title: const Text('Settings'),
                  trailing: Icon(Platform.isIOS
                      ? CupertinoIcons.settings
                      : Icons.settings),
                ),
              ),
            if (onLogout != null)
              const PopupMenuItem(
                value: PopupAction.LOGOUT,
                enabled: true,
                child: const ListTile(
                  title: const Text('Logout'),
                  trailing: const Icon(Icons.power_settings_new),
                ),
              ),
            if (onEdit != null)
              const PopupMenuItem(
                value: PopupAction.EDIT,
                enabled: true,
                child: const ListTile(
                  title: const Text('Edit'),
                  trailing: const Icon(Icons.edit),
                ),
              ),
            if (onDelete != null)
              PopupMenuItem(
                value: PopupAction.DELETE,
                enabled: true,
                child: ListTile(
                  title: const Text('Delete'),
                  trailing: Icon(
                      Platform.isIOS ? CupertinoIcons.delete : Icons.delete),
                ),
              ),
          ];
        },
      ),
    );
  }
}

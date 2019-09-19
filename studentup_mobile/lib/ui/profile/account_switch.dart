import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';

class AccountSwitch extends StatelessWidget {
  final int _isCurrentAccount = 0;

  void _showAccountSwitcher(BuildContext context) {
    ProfileNotifier notifier = Provider.of<ProfileNotifier>(context);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16.0),
              for (int i = 0; i < 2; i++)
                ListTile(
                  //TODO: add account local storage
                  leading: CachedNetworkImage(
                    imageUrl: notifier.info.imageUrl,
                    placeholder: (_, url) => const CircleAvatar(
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                    ),
                    errorWidget: (_, __, err) => const CircleAvatar(
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                      child: const Icon(Icons.error),
                    ),
                    imageBuilder: (_, image) => CircleAvatar(
                      backgroundImage: image,
                    ),
                  ),
                  title: const Text('Ramses Kamanda'),
                  trailing: _isCurrentAccount != i
                      ? null
                      : Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: CupertinoColors.activeBlue,
                        ),
                  onTap: () {},
                ),
              const SizedBox(height: 16.0),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add Account'),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'ramseskamanda',
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
      onPressed: () => _showAccountSwitcher(context),
    );
  }
}

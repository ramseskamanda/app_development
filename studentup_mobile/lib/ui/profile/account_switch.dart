import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';

class AccountSwitch extends StatelessWidget {
  Future _showAccountSwitcher(BuildContext context) async {
    Completer<List<Preview>> completer = Completer<List<Preview>>()
      ..complete(Locator.of<BaseAuth>().getAccounts());
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      builder: (context) {
        return SafeArea(
          child: FutureBuilder<List<Preview>>(
            future: completer.future,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return ListTile(
                  leading: CircularProgressIndicator(),
                  title: const Text('Loading...'),
                );
              List<Preview> accounts = snapshot.data;
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  if (accounts.isEmpty)
                    Center(
                      child: Text(
                        'An Error Occured...\nPlease sign in again to fix it.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ...accounts
                      .map((account) => AccountListTile(account: account))
                      .toList(),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add Account'),
                    onTap: () {},
                  ),
                ],
              );
            },
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
            Provider.of<ProfileNotifier>(context).preview.givenName,
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

class AccountListTile extends StatelessWidget {
  final Preview account;

  const AccountListTile({Key key, @required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: account.imageUrl,
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
      title: Text(account.givenName),
      trailing: account.uid != Locator.of<BaseAuth>().currentUserId
          ? null
          : Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: CupertinoColors.activeBlue,
            ),
      onTap: () {},
    );
  }
}

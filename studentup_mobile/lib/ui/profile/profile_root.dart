import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/profile/edit_profile.dart';
import 'package:studentup_mobile/ui/profile/profile.dart';
import 'package:studentup_mobile/ui/startup_profile/startup_profile.dart';
import 'package:studentup_mobile/ui/widgets/buttons/popup_menu.dart';
import 'package:studentup_mobile/ui/widgets/utility/network_sensitive_widget.dart';

class ProfileRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // title: AccountSwitch(),
        title: const Text('Profile'),
        leading: FittedBox(
          child: IconButton(
            icon: Text(
              'Edit',
              softWrap: false,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: CupertinoColors.activeBlue),
            ),
            onPressed: () => Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => ProfileEditor(),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          PopupMenuWithActions(
            onSettings: () =>
                Navigator.of(context).pushNamed(Router.settingsPage),
            onLogout: () async {
              await Provider.of<ProfileNotifier>(context).logout();
              await Locator.of<BaseAuth>().logout();
              Provider.of<InnerRouter>(context).resetRouter();
            },
          ),
        ],
      ),
      body: NetworkSensitive(
        child: Consumer<ProfileNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (notifier.isStartup) return StartUpProfile();
            return Profile(isUser: true);
          },
        ),
      ),
    );
  }
}

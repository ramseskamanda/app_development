import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';

class InnerDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<InnerRouter>(context).goToProfile();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ProfileNotifier>(
                builder: (context, notifier, child) {
                  return Column(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.transparent),
                        accountEmail: Text(
                          notifier.isStartup
                              ? 'Startup Account'
                              : 'Student Account',
                        ),
                        accountName: Text(notifier.preview.givenName),
                        currentAccountPicture: CachedNetworkImage(
                          imageUrl: notifier.preview.imageUrl,
                          placeholder: (_, __) => const CircleAvatar(
                            backgroundColor:
                                CupertinoColors.lightBackgroundGray,
                          ),
                          errorWidget: (_, __, e) => const CircleAvatar(
                            backgroundColor:
                                CupertinoColors.lightBackgroundGray,
                            child: const Icon(Icons.error),
                          ),
                          imageBuilder: (_, image) {
                            return CircleAvatar(backgroundImage: image);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('My Projects'),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(Router.userProjects),
          ),
          ListTile(
            leading: const Icon(Icons.settings_system_daydream),
            title: const Text('My Think Tanks'),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(Router.userThinkTanks),
          ),
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text('My Saved Profiles'),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(Router.userSavedProfiles),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: <Widget>[
                // ListTile(
                //   leading: const Icon(Icons.settings),
                //   title: const Text('Settings'),
                //   onTap: () {},
                // ),
                ListTile(
                  leading: const Icon(
                    Icons.weekend,
                    color: CupertinoColors.destructiveRed,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                  onTap: () async {
                    try {
                      if (await Dialogs.showLogoutDialog(context)) {
                        Navigator.of(context).pop();
                        await Provider.of<ProfileNotifier>(context).logout();
                        await Locator.of<BaseAuth>().logout();
                        Provider.of<InnerRouter>(context).resetRouter();
                      }
                    } catch (e) {}
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*

Profile Completion Percentage Indicator

  Row(
    children: <Widget>[
      Spacer(),
      Text(
        'Profile 80% complete',
        style: Theme.of(context).textTheme.caption,
      ),
      Spacer(flex: 20),
      GestureDetector(
        onTap: () {},
        child: Text(
          'Go To Profile',
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(
                  color: Theme.of(context).accentColor),
        ),
      ),
      Spacer(),
    ],
  ),
  const SizedBox(height: 4.0),
  LinearPercentIndicator(
    lineHeight: 8.0,
    percent: 0.8,
    progressColor: Theme.of(context).accentColor,
    backgroundColor: CupertinoColors.lightBackgroundGray,
  ),

*/

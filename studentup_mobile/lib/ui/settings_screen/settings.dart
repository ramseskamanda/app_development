import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/theme_notifier.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';
import 'package:studentup_mobile/util/user_config.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    LocalStorageService localStorage = Locator.of<LocalStorageService>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text('Your Settings'),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          SettingsHeader(text: 'General Settings'),
          SwitchListTile.adaptive(
            title: const Text('Fake Data'),
            subtitle: const Text(
                'This setting will determine whether this app will use fake data.'),
            value: localStorage.getFromUserDisk(FAKE_DATA) ?? false,
            onChanged: (bool value) async {
              await localStorage.saveToUserDisk(FAKE_DATA, value);
              setState(() {});
            },
          ),
          SwitchListTile.adaptive(
            title: const Text('Dark Theme'),
            subtitle: const Text(
                'Experience new colors all the while saving your battery life!'),
            value: Provider.of<ThemeNotifier>(context).mode == ThemeMode.dark,
            onChanged: (bool value) async {
              final ThemeMode _mode = value ? ThemeMode.dark : ThemeMode.light;
              Provider.of<ThemeNotifier>(context).mode = _mode;
              await Locator.of<LocalStorageService>()
                  .saveToUserDisk(THEME_KEY, _mode.toString());
            },
          ),
          SettingsHeader(
            text: 'Feature-specifics',
            disclaimer:
                'some of these settings might require you to refresh the pages affected or restart the app entirely.',
          ),
          SwitchListTile.adaptive(
            title: const Text('Home: Trending First'),
            subtitle: const Text(
                'The order in which you would like your feed to display think tanks will be trending think tanks first'),
            value:
                localStorage.getFromUserDisk(THINK_TANK_QUERY_ORDER) ?? false,
            onChanged: (bool value) async {
              await Locator.of<LocalStorageService>()
                  .saveToUserDisk(THINK_TANK_QUERY_ORDER, value);
              setState(() {});
            },
          ),
          SwitchListTile.adaptive(
            title: const Text('Home: Successful Startup Badges First'),
            subtitle: const Text(
                'The order in which you would like your feed to display startup badges will be successful first'),
            value: localStorage.getFromUserDisk(STARTUP_BADGES_QUERY_ORDER) ??
                false,
            onChanged: (bool value) async {
              await Locator.of<LocalStorageService>()
                  .saveToUserDisk(STARTUP_BADGES_QUERY_ORDER, value);
              setState(() {});
            },
          ),
          SwitchListTile.adaptive(
            title: const Text('Projects: Newest Projects First'),
            subtitle: const Text(
                'The order in which you would like your feed to display projects will be newest projects first'),
            value: localStorage.getFromUserDisk(PROJECTS_QUERY_ORDER) ?? false,
            onChanged: (bool value) async {
              await Locator.of<LocalStorageService>()
                  .saveToUserDisk(PROJECTS_QUERY_ORDER, value);
              setState(() {});
            },
          ),
          const SizedBox(height: 24.0),
          AboutListTile(
            child: const Text('Licenses'),
            icon: Icon(Icons.assignment),
            applicationName: 'Studentup Mobile',
            applicationVersion: 'v-0.0.1-alpha',
            applicationIcon: Icon(Icons.settings_applications),
            applicationLegalese:
                'Studentup, Inc. is  not responsible for any actions originating from advice found on any of its digital products.',
          ),
          ListTile(
            title: const Text(
              'Sign Out',
              style: TextStyle(color: CupertinoColors.destructiveRed),
            ),
            leading: const Icon(
              Icons.power_settings_new,
              color: CupertinoColors.destructiveRed,
            ),
            onTap: () async {
              if (await Dialogs.showLogoutDialog(context))
                Locator.of<BaseAuth>().logout();
            },
          ),
          Container(
            color: CupertinoColors.destructiveRed,
            child: ListTile(
              title: const Text(
                'Delete Profile',
                style: TextStyle(color: CupertinoColors.white),
              ),
              leading: const Icon(
                CupertinoIcons.delete_solid,
                color: CupertinoColors.white,
              ),
              onTap: () => Dialogs.showComingSoon(context),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  final String text;
  final String disclaimer;

  const SettingsHeader({Key key, this.text, this.disclaimer = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        subtitle: disclaimer.isNotEmpty
            ? Text(
                '* ' + disclaimer,
                style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12.0),
              )
            : null,
      ),
    );
  }
}

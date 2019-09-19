import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/local_storage_service.dart';
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
          ListTile(
            title: const Text('Fake Data'),
            subtitle: const Text(
                'This setting will determine whether this app will use fake data.'),
            trailing: Switch.adaptive(
              value: localStorage.getFromUserDisk(FAKE_DATA) ?? false,
              onChanged: (bool value) async {
                await localStorage.saveToUserDisk(FAKE_DATA, value);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_development/communities/create/state_management/privacy.dart';
import 'package:ui_development/communities/enum/privacy.dart';

class CreateCommunityPrivacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CommunityPrivacyPicker privacyPicker = Provider.of(context);
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.86,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 32.0),
            const Text(
              'Would you like to create a public or private community?\nThis can still be changed after creation.',
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            RadioListTile<CommunityPrivacy>(
              title: const Text('Private Community'),
              subtitle: const Text('Invite-only community.'),
              value: CommunityPrivacy.private,
              groupValue: privacyPicker.setting,
              onChanged: (val) => privacyPicker.setting = val,
            ),
            RadioListTile<CommunityPrivacy>(
              title: const Text('Public Community'),
              subtitle: const Text('Everyone can see and join the community.'),
              value: CommunityPrivacy.public,
              groupValue: privacyPicker.setting,
              onChanged: (val) => privacyPicker.setting = val,
            ),
          ],
        ),
      ),
    );
  }
}

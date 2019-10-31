import 'package:flutter/material.dart';
import 'package:ui_dev0/enums/privacy_types.dart';
import 'package:ui_dev0/views/create_community/state/privacy.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';

class CreateCommunityPrivacy extends BaseModelWidget<CommunityPrivacyPicker> {
  @override
  Widget build(BuildContext context, CommunityPrivacyPicker data) {
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
              groupValue: data.setting,
              onChanged: (val) => data.setting = val,
            ),
            RadioListTile<CommunityPrivacy>(
              title: const Text('Public Community'),
              subtitle: const Text('Everyone can see and join the community.'),
              value: CommunityPrivacy.public,
              groupValue: data.setting,
              onChanged: (val) => data.setting = val,
            ),
          ],
        ),
      ),
    );
  }
}

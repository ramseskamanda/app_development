import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/ui/profile/profile.dart';
import 'package:studentup_mobile/ui/startup_profile/startup_profile.dart';
import 'package:studentup_mobile/ui/widgets/utility/network_sensitive_widget.dart';

class OtherProfileRoot extends StatelessWidget {
  final Preview infoModel;
  final bool fromMessaging;

  OtherProfileRoot({
    Key key,
    @required this.infoModel,
    this.fromMessaging = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileNotifier notifier = ProfileNotifier(infoModel.uid)..fetchData();
    return ChangeNotifierProvider<ProfileNotifier>.value(
      value: notifier,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text('Profile'),
        ),
        body: NetworkSensitive(
          callback: notifier.fetchData,
          child: Consumer<ProfileNotifier>(
            builder: (context, notifier, child) {
              if (notifier.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (infoModel.isStartup) return StartUpProfile();
              return Profile(fromMessaging: fromMessaging);
            },
          ),
        ),
      ),
    );
  }
}

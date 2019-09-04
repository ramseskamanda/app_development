import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';
import 'package:studentup_mobile/ui/home/chat_screen/new_message.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';

class ContactOptions extends StatelessWidget {
  final UserInfoModel model;

  const ContactOptions({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserInfoModel>(
      stream: Provider.of<ProfileNotifier>(context).userInfoStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(CupertinoIcons.conversation_bubble),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NewMessage(
                      model: snapshot.data,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 16.0),
            IconButton(
              icon: Icon(CupertinoIcons.heart),
              onPressed: () => Dialogs.showComingSoon(context),
            ),
          ],
        );
      },
    );
  }
}

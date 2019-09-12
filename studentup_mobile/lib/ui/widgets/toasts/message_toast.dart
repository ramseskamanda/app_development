import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/firebase_notification_model.dart';

class MessageToast {
  static void show({
    BuildContext context,
    FirebaseNotificationModel model,
    @required void Function() stateManagerCallback,
  }) {
    showFlash(
      context: context,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          style: FlashStyle.floating,
          boxShadows: kElevationToShadow[4],
          borderRadius: BorderRadius.circular(6.0),
          position: FlashPosition.top,
          onTap: () {
            controller.dismiss();
            stateManagerCallback();
          },
          child: FlashBar(
            icon: const Icon(CupertinoIcons.conversation_bubble),
            leftBarIndicatorColor: Theme.of(context).accentColor,
            title: Text(
              model.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            message: Text(model.body),
          ),
        );
      },
    );
  }
}

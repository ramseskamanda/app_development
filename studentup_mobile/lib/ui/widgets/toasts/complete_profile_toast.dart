import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompleteProfileToast {
  static void show({
    BuildContext context,
    void Function() stateManagerCallback,
    int percentage = 20,
  }) {
    if (percentage == 100) return;
    showFlash(
      context: context,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          style: FlashStyle.floating,
          boxShadows: kElevationToShadow[4],
          borderRadius: BorderRadius.circular(6.0),
          position: FlashPosition.top,
          child: FlashBar(
            icon: Icon(Icons.person_add),
            leftBarIndicatorColor: Theme.of(context).accentColor,
            title: const Text(
              'Complete Your Profile Now',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            message: Text(
              'Your Profile is $percentage% complete. The more information we have, the better for you!',
            ),
            primaryAction: FlatButton(
              textColor: Platform.isIOS
                  ? CupertinoColors.activeBlue
                  : Theme.of(context).accentColor,
              child: const Text('Go Now!'),
              onPressed: () {
                controller.dismiss();
                stateManagerCallback();
              },
            ),
          ),
        );
      },
    );
  }
}

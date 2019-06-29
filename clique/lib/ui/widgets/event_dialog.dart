import 'dart:io';

import 'package:clique/models/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showEventDialog(BuildContext context, Event event) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Event Started!'),
          content: Text('${event.name} has started! Start tracking?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Yes!'),
              isDefaultAction: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: const Text('Not yet...'),
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  } else if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Event Started!'),
          content: Text('${event.name} has started! Start tracking?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes!'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: const Text('Not yet.'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  } else {
    print('[${Platform.operatingSystem} is not supported yet.]');
  }
}

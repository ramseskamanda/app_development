import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentup/util/env.dart';

dynamic showAutoLoginErrorMessage(BuildContext context) {
  if (Platform.isIOS)
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('AUTO LOGIN FAILED'),
          content: Text(
            'We could not determine your identity at start-up. Please sign in again.',
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Go to Sign In'),
              onPressed: Navigator.of(context).pop,
            ),
          ],
        );
      },
    );
  else
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AUTO LOGIN FAILED'),
          content: Text(
            'We could not determine your identity at start-up. Please sign in again.',
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('O.K.'),
              onPressed: Navigator.of(context).pop,
            ),
          ],
        );
      },
    );
}

void showFatalErrorMessage(BuildContext context) {
  Timer(
    const Duration(seconds: 30),
    () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
  );
  if (Platform.isIOS)
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('A Fatal Error Occured.'),
          content: Text(Environment.fatalErrorMessage),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Restart now'),
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            )
          ],
        );
      },
    );
  else
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('A Fatal Error Occured.'),
          content: Text(Environment.fatalErrorMessage),
          actions: <Widget>[
            FlatButton(
              child: const Text('Restart now'),
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            )
          ],
        );
      },
    );
}

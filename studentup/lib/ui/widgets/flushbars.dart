import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:studentup/util/env.dart';

void showAuthenticationErrorMessage(BuildContext context) {
  Flushbar(
    duration: Environment.flushbarDuration,
    title: 'Authentication Failure',
    message: Environment.failedAuthenticationMessage,
    icon: Icon(Icons.error),
    leftBarIndicatorColor: Colors.amberAccent,
  ).show(context);
}

void showFailedRegistration(BuildContext context) {
  Flushbar(
    duration: Environment.flushbarDuration,
    title: 'Failed Registration',
    icon: Icon(Icons.error),
    leftBarIndicatorColor: Colors.redAccent,
    message: Environment.failedRegistrationMessage,
  ).show(context);
}

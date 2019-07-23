import 'package:provider/provider.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup/routers/global_router.dart';

class ApplicationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 48.0,
              left: 32.0,
              child: GestureDetector(
                child: Icon(CupertinoIcons.restart),
                onTap: () {
                  Provider.of<AuthenticationNotifier>(context).logout();
                  Navigator.of(context)
                      .pushReplacementNamed(GlobalRouter.loginRoute);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

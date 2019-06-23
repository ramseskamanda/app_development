import 'package:clique/router.dart';
import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  locator<AuthService>().logout();
                  Navigator.of(context).pushReplacementNamed(Router.loginRoute);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

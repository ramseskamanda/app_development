import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadgeCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => print('object'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Badges',
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(color: CupertinoColors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

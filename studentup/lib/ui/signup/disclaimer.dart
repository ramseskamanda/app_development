import 'package:studentup/util/login_types.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  final LoginType type;
  Disclaimer({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disclaimer'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: const Text('Proceed'),
              onPressed: () => Navigator.pop(context, true),
            ),
            RaisedButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:studentup/util/enums/login_types.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  final AuthType type;
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
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop<bool>(true),
            ),
            RaisedButton(
              child: const Text('Cancel'),
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop<bool>(false),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:provider/provider.dart';
import 'package:studentup/routers/global_router.dart';
import 'package:studentup/util/enums/login_types.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  final LoginType type;
  Disclaimer({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalRouter globalRouter = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disclaimer'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: const Text('Proceed'),
              onPressed: () => globalRouter.popCurrentRoute<bool>(result: true),
            ),
            RaisedButton(
              child: const Text('Cancel'),
              onPressed: () =>
                  globalRouter.popCurrentRoute<bool>(result: false),
            ),
          ],
        ),
      ),
    );
  }
}

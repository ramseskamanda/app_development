import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup/notifiers/count_notifier.dart';

class NotifiableIcon<T extends CountNotifier> extends StatelessWidget {
  final IconData iconData;

  const NotifiableIcon({Key key, @required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 28.0,
        ),
        Consumer<T>(
          builder: (context, notifier, child) {
            if (notifier.countIsZero) return Container();
            return Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text('${notifier.count}'),
                radius: 10.0,
              ),
            );
          },
        ),
      ],
    );
  }
}

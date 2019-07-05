import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;

  ScreenTitle(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.display2.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

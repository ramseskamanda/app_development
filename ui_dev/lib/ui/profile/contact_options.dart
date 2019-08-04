import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(CupertinoIcons.conversation_bubble),
          onPressed: () {},
        ),
        const SizedBox(width: 16.0),
        IconButton(
          icon: Icon(CupertinoIcons.heart),
          onPressed: () {},
        ),
      ],
    );
  }
}

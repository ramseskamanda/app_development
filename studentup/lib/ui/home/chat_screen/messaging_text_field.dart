import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagingTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => print('add picture'),
      ),
      contentPadding: EdgeInsets.all(0),
      title: TextField(
        autofocus: true,
        autocorrect: true,
        style: TextStyle(
          fontSize: 15.0,
          color: Theme.of(context).textTheme.title.color,
        ),
        decoration: InputDecoration(
          fillColor: CupertinoColors.extraLightBackgroundGray,
          focusColor: Colors.transparent,
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Write your message...",
          hintStyle: TextStyle(
            fontSize: 15.0,
            color: Theme.of(context).textTheme.title.color,
          ),
        ),
        maxLines: null,
      ),
      trailing: IconButton(
        icon: Icon(
          FeatherIcons.send,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {},
      ),
    );
  }
}

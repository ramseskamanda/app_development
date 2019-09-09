import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/ui/home/chat_screen/chats.dart';
import 'package:studentup_mobile/ui/home/feed/feed.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InnerRouter router = Provider.of<InnerRouter>(context);
    return SafeArea(
      child: PageView(
        controller: router.homeView,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Feed(),
          Chats(),
        ],
      ),
    );
  }
}

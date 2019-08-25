import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/ui/home/chat_screen/chats.dart';
import 'package:studentup_mobile/ui/home/feed/feed.dart';

class Home extends StatefulWidget {
  final int messaging;
  Home({Key key, this.messaging = 0})
      : assert(messaging == 0 || messaging == 1),
        super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      keepPage: true,
      initialPage: widget.messaging,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<PageController>(
      value: _pageController,
      updateShouldNotify: (_, __) => false,
      child: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Feed(),
            Scaffold(),
            //Chats(),
          ],
        ),
      ),
    );
  }
}

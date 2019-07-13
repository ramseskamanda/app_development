import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup/ui/home/home_screen/home_screen.dart';
import 'package:studentup/ui/home/message_screen/message_root.dart';

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
    return Provider<PageController>.value(
      value: _pageController,
      child: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            HomeScreen(),
            MessagingRoot(),
          ],
        ),
      ),
    );
  }
}

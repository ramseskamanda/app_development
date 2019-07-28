import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/competitions/podium_placement.dart';
import 'package:ui_dev/stadium_button.dart';

class WinnerSelectionRoot extends StatefulWidget {
  @override
  _WinnerSelectionRootState createState() => _WinnerSelectionRootState();
}

class _WinnerSelectionRootState extends State<WinnerSelectionRoot> {
  final List<Widget> _pages = <Widget>[
    PodiumPlacementScreen(),
    //NewCompetitionDeadline(),
  ];

  PageController _controller;
  IconButton _leadingIconButton;
  bool _lastPage;

  void _onPageChanged(int index) {
    if (index == _pages.length - 1) {
      setState(() {
        _lastPage = true;
      });
    } else if (index == _controller.initialPage ||
        index == _controller.initialPage + 1) {
      setState(() {
        _lastPage = false;
        _leadingIconButton = index == _controller.initialPage
            ? IconButton(
                key: ValueKey(index),
                icon: Icon(Icons.close),
                onPressed: () => print('object'),
              )
            : IconButton(
                key: ValueKey(index),
                icon: Icon(Icons.arrow_back),
                onPressed: () => _controller.previousPage(
                  duration: kTabScrollDuration,
                  curve: Curves.bounceIn,
                ),
              );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _lastPage = false;
    _leadingIconButton = IconButton(
      key: ValueKey(_controller.initialPage),
      icon: Icon(Icons.close),
      onPressed: () => print('object'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: AnimatedSwitcher(
          duration: kTabScrollDuration,
          transitionBuilder: (child, animation) => RotationTransition(
            child: FadeTransition(opacity: animation, child: child),
            turns: animation,
          ),
          child: _leadingIconButton,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              onPageChanged: _onPageChanged,
              children: _pages,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: StadiumButton(
                text: _lastPage ? 'Publish' : 'Next',
                onPressed: _lastPage
                    ? () => print('object')
                    : () => _controller.nextPage(
                          duration: kTabScrollDuration,
                          curve: Curves.bounceInOut,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

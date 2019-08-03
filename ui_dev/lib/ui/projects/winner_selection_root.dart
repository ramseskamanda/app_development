import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/ui/projects/summary.dart';
import 'package:ui_dev/widgets/stadium_button.dart';

class ApplicantSelectionRoot extends StatefulWidget {
  @override
  _ApplicantSelectionRootState createState() => _ApplicantSelectionRootState();
}

class _ApplicantSelectionRootState extends State<ApplicantSelectionRoot> {
  final List<Widget> _pages = <Widget>[
    SummaryOwner(),
  ];

  PageController _controller;
  IconButton _leadingIconButton;
  IconButton _trailingIconButton;
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
        _trailingIconButton = index == _controller.initialPage
            ? IconButton(
                key: ValueKey('favorites'),
                icon: Icon(CupertinoIcons.heart),
                onPressed: () => print('object'),
              )
            : IconButton(
                icon: Icon(Icons.no_encryption, color: Colors.transparent),
                onPressed: null,
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
    _trailingIconButton = IconButton(
      key: ValueKey('favorites'),
      icon: Icon(CupertinoIcons.heart),
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
          switchInCurve: Curves.easeInOutCirc,
          switchOutCurve: Curves.easeInOutCirc,
          transitionBuilder: (child, animation) => RotationTransition(
            child: FadeTransition(opacity: animation, child: child),
            turns: animation,
          ),
          child: _leadingIconButton,
        ),
        actions: <Widget>[
          AnimatedSwitcher(
            duration: kTabScrollDuration,
            child: _trailingIconButton,
          )
        ],
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
                text: _lastPage ? 'Submit' : 'Next',
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

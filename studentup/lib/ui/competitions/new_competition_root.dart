import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup/ui/competitions/new_competition_categories.dart';
import 'package:studentup/ui/competitions/new_competition_deadline.dart';
import 'package:studentup/ui/competitions/new_competition_info.dart';
import 'package:studentup/ui/widgets/stadium_button.dart';

class NewCompetitionRoot extends StatefulWidget {
  @override
  _NewCompetitionRootState createState() => _NewCompetitionRootState();
}

class _NewCompetitionRootState extends State<NewCompetitionRoot> {
  final List<Widget> _pages = <Widget>[
    NewCompetitionInformation(),
    NewCompetitionDeadline(),
    NewCompetitionCategories(),
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

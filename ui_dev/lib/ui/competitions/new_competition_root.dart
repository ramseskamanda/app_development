import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/services/competition_creation_service.dart';
import 'package:ui_dev/ui/competitions/new_competition_uploader.dart';
import 'package:ui_dev/ui/competitions/new_competition_categories.dart';
import 'package:ui_dev/ui/competitions/new_competition_deadline.dart';
import 'package:ui_dev/ui/competitions/new_competition_info.dart';
import 'package:ui_dev/widgets/stadium_button.dart';
import 'package:provider/provider.dart';

class NewCompetitionRoot extends StatefulWidget {
  @override
  _NewCompetitionRootState createState() => _NewCompetitionRootState();
}

class _NewCompetitionRootState extends State<NewCompetitionRoot> {
  final List<Widget> _pages = <Widget>[
    NewCompetitionInformation(),
    NewCompetitionDeadline(),
    NewCompetitionCategories(),
    CompetitionUploader(),
  ];

  PageController _controller;
  IconButton _leadingIconButton;
  bool _lastPage;

  void _onPageChanged(int index) {
    if (index == _pages.length - 1)
      _lastPage = true;
    else
      _lastPage = false;
    if (index == _controller.initialPage ||
        index == _controller.initialPage + 1) {
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
    }
    setState(() {});
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
    return ChangeNotifierProvider<CompetitionCreationService>(
      builder: (context) => CompetitionCreationService(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: Consumer<CompetitionCreationService>(
            builder: (context, service, child) {
              if (service.isUploading || service.isDone)
                return Container();
              else
                return child;
            },
            child: AnimatedSwitcher(
              duration: kTabScrollDuration,
              transitionBuilder: (child, animation) => RotationTransition(
                child: FadeTransition(opacity: animation, child: child),
                turns: animation,
              ),
              child: _leadingIconButton,
            ),
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
                child: BottomButton(last: _lastPage, controller: _controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final bool last;
  final PageController controller;

  const BottomButton({Key key, this.last, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompetitionCreationService>(
      builder: (context, service, child) {
        return StadiumButton(
          text: service.isDone ? 'Done' : last ? 'Publish' : 'Next',
          onPressed: service.isDone
              ? () => Navigator.of(context).pop()
              : !last
                  ? () {
                      controller.nextPage(
                        duration: kTabScrollDuration,
                        curve: Curves.bounceInOut,
                      );
                    }
                  : service.formIsValid && !service.isUploading
                      ? () => service.uploadCompetition()
                      : null,
        );
      },
    );
  }
}

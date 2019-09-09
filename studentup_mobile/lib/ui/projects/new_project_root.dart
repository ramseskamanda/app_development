import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_creation_notifier.dart';
import 'package:studentup_mobile/ui/projects/new_project_uploader.dart';
import 'package:studentup_mobile/ui/projects/new_project_categories.dart';
import 'package:studentup_mobile/ui/projects/new_project_deadline.dart';
import 'package:studentup_mobile/ui/projects/new_project_info.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class NewProjectRoot extends StatefulWidget {
  @override
  _NewProjectRootState createState() => _NewProjectRootState();
}

class _NewProjectRootState extends State<NewProjectRoot> {
  final List<Widget> _pages = <Widget>[
    NewProjectInformation(),
    NewProjectDeadline(),
    NewProjectCategories(),
    ProjectUploader(),
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
              onPressed: () => Navigator.of(context).pop(false),
            )
          : IconButton(
              key: ValueKey(index),
              icon: Icon(Icons.arrow_back),
              onPressed: () => _controller.previousPage(
                duration: kTabScrollDuration,
                curve: Curves.easeInOutSine,
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
      onPressed: () => Navigator.of(context).pop(false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectCreationNotifier>(
      builder: (context) => ProjectCreationNotifier(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: Consumer<ProjectCreationNotifier>(
            builder: (context, service, child) {
              if (service.isWriting)
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

  _getFunction(BuildContext context, ProjectCreationNotifier service) {
    if (service.isDone) return () => Navigator.of(context).pop(true);
    if (!last)
      return () {
        controller.nextPage(
          duration: kTabScrollDuration,
          curve: Curves.easeInOutSine,
        );
      };
    if (service.isLoading) return null;
    if (!service.formIsValid) return () => print('Form is not valid');
    return () => service.sendData();
  }

  @override
  Widget build(BuildContext context) {
    final ProjectCreationNotifier service = Provider.of(context);
    return StadiumButton(
      text: service.isDone ? 'Done' : last ? 'Publish' : 'Next',
      onPressed: _getFunction(context, service),
    );
  }
}

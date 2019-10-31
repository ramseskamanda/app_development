import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_development/communities/create/info.dart';
import 'package:ui_development/communities/create/members.dart';
import 'package:ui_development/communities/create/privacy.dart';
import 'package:ui_development/communities/create/state_management/data_sender.dart';
import 'package:ui_development/communities/create/state_management/info.dart';
import 'package:ui_development/communities/create/state_management/members.dart';
import 'package:ui_development/communities/create/state_management/privacy.dart';
import 'package:progress_button/progress_button.dart';

class CreateCommunity extends StatefulWidget {
  final CommunityInfoBloc infoBloc = CommunityInfoBloc();
  @override
  _CreateCommunityState createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  int _currentPageIndex = 0;
  PageController _controller;
  final List<Widget> _list = <Widget>[
    CreateCommunityInfo(),
    CreateCommunityPrivacy(),
    CreateCommunityFirstMembers(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController()
      ..addListener(() =>
          setState(() => _currentPageIndex = _controller.page.truncate()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void previousPage() {
    if (_currentPageIndex == 0) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
    _controller.previousPage(
      duration: kTabScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    FocusScope.of(context).unfocus();
    if (_currentPageIndex == _list.length - 1) return;
    _controller.nextPage(
      duration: kTabScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  String _buildTitle() {
    switch (_currentPageIndex) {
      case 0:
        return 'Create Community';
      case 1:
        return 'Community Privacy';
      case 2:
        return 'First Members';
      default:
        return 'Create Community';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Theme.of(context).iconTheme.color,
          icon: Icon(Icons.arrow_back),
          onPressed: previousPage,
        ),
        title: Text(
          _buildTitle(),
          style: TextStyle(color: Theme.of(context).textTheme.title.color),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: _list,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 0.86,
                child: StreamBuilder<bool>(
                  stream: widget.infoBloc.canContinue,
                  builder: (context, snapshot) {
                    return Consumer<DataSender>(
                      builder: (context, sender, child) {
                        return ProgressButton(
                          child: _currentPageIndex != _list.length - 1
                              ? Text('Next')
                              : Text('Finish'),
                          onPressed: (snapshot.hasData && snapshot.data)
                              ? nextPage
                              : null,
                          buttonState: sender.isLoading
                              ? ButtonState.inProgress
                              : ButtonState.normal,
                          backgroundColor: Theme.of(context).primaryColor,
                          progressColor: Theme.of(context).primaryColor,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

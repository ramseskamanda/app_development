import 'package:flutter/material.dart';
import 'package:progress_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev0/views/create_community/common/info.dart';
import 'package:ui_dev0/views/create_community/common/members.dart';
import 'package:ui_dev0/views/create_community/common/privacy.dart';
import 'package:ui_dev0/views/create_community/state/data_sender.dart';
import 'package:ui_dev0/views/create_community/state/info.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';

class CreateCommunityViewMobilePortrait extends BaseModelWidget<DataSender> {
  final PageController _controller = PageController();
  final List<Widget> _list = <Widget>[
    CreateCommunityInfo(),
    CreateCommunityPrivacy(),
    CreateCommunityFirstMembers(),
  ];

  void previousPage(BuildContext context) {
    if (_controller.page.truncate() == 0) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
    _controller.previousPage(
      duration: kTabScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  void nextPage(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_controller.page.truncate() == _list.length - 1) return;
    _controller.nextPage(
      duration: kTabScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  String _buildTitle() {
    int index = _controller.hasClients ? _controller.page.truncate() : 0;
    switch (index) {
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
  Widget build(BuildContext context, DataSender sender) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Theme.of(context).iconTheme.color,
          icon: Icon(Icons.arrow_back),
          onPressed: () => previousPage(context),
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
                  stream: Provider.of<CommunityInfoBloc>(context).canContinue,
                  builder: (context, snapshot) {
                    return ProgressButton(
                      child: _controller.page.truncate() != _list.length - 1
                          ? Text('Next')
                          : Text('Finish'),
                      onPressed: (snapshot.hasData && snapshot.data)
                          ? () => nextPage(context)
                          : null,
                      buttonState: sender.isLoading
                          ? ButtonState.inProgress
                          : ButtonState.normal,
                      backgroundColor: Theme.of(context).primaryColor,
                      progressColor: Theme.of(context).primaryColor,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev0/enums/controller_states.dart';
import 'package:ui_dev0/views/create_community/common/info.dart';
import 'package:ui_dev0/views/create_community/common/members.dart';
import 'package:ui_dev0/views/create_community/common/privacy.dart';
import 'package:ui_dev0/views/create_community/state/data_sender.dart';
import 'package:ui_dev0/views/create_community/state/info.dart';
import 'package:ui_dev0/views/create_community/state/members.dart';
import 'package:ui_dev0/widgets/base_controller.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';

class CreateCommunityViewMobilePortrait extends BaseModelWidget<DataSender> {
  final PageController _controller = PageController();
  final ButtonController _buttonController = ButtonController(numPages: 3);
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
    if (_controller.page.truncate() == _list.length - 2)
      Provider.of<CommunityMemberAdderController>(context).addMember(testUser);
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
    return ChangeNotifierProvider<ButtonController>.value(
      value: _buttonController,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _buttonController.currentPage -= 1;
              previousPage(context);
            },
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
                      return CupertinoProgressButton(
                        processCallback: () async {
                          await sender.sendData();
                        },
                        callback: (snapshot.hasData && snapshot.data)
                            ? () => nextPage(context)
                            : null,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CupertinoProgressButton extends BaseModelWidget<ButtonController> {
  final void Function() callback;
  final Future Function() processCallback;

  CupertinoProgressButton({
    Key key,
    @required this.callback,
    @required this.processCallback,
  });
  @override
  Widget build(BuildContext context, ButtonController model) {
    return CupertinoButton.filled(
      pressedOpacity: 0.7,
      child: model.hasNext
          ? const Text('Next')
          : model.isLoading
              ? const CupertinoActivityIndicator()
              : const Text('Finish'),
      onPressed: callback == null
          ? null
          : () async {
              if (model.hasNext) {
                callback();
                model.currentPage += 1;
              } else {
                try {
                  model.state = ControllerState.BUSY;
                  await processCallback();
                  model.state = ControllerState.IDLE;
                } catch (e) {
                  model.state = ControllerState.HAS_ERROR;
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                  model.state = ControllerState.IDLE;
                }
              }
            },
    );
  }
}

class ButtonController extends BaseController {
  final int numPages;
  int _currentPage = 0;

  int get currentPage => _currentPage;
  bool get hasNext => currentPage < numPages - 1;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  ButtonController({this.numPages = 0});
}

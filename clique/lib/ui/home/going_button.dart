import 'package:clique/models/event_model.dart';
import 'package:clique/services/events_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/util/button_states.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class GoingButton extends StatefulWidget {
  final Event event;
  final bool isAttending;
  GoingButton({Key key, @required this.event, @required this.isAttending})
      : super(key: key);
  @override
  _GoingButtonState createState() => _GoingButtonState();
}

class _GoingButtonState extends State<GoingButton> {
  ButtonState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.isAttending ? ButtonState.completed : ButtonState.idle;
  }

  Future<void> _handleAttending(bool alreadyAttending) async {
    setState(() => _state = ButtonState.working);
    String result = await locator<EventsService>().userAttends(
      widget.event,
      alreadyAttending,
    );
    if (result != null) {
      setState(() => _state = ButtonState.idle);

      Flushbar(
        title: 'Error',
        message: result,
        leftBarIndicatorColor: Colors.amberAccent,
        icon: Icon(Icons.error),
      ).show(context);
    } else {
      setState(() =>
          _state = alreadyAttending ? ButtonState.idle : ButtonState.completed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).accentTextTheme.button.color,
          onPressed: _state != ButtonState.working
              ? () => _handleAttending(_state == ButtonState.completed)
              : null,
          child: _state == ButtonState.completed
              ? const Text('Cancel')
              : const Text('Going'),
        ),
        SizedBox(height: 8.0),
        if (_state == ButtonState.completed)
          const Text(
            'You\'re going!',
            style: TextStyle(color: Colors.lightGreen),
          ),
      ],
    );
  }
}

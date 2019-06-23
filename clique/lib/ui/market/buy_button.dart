import 'package:clique/models/reward_model.dart';
import 'package:clique/services/market_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/util/button_states.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class BuyButton extends StatefulWidget {
  final Reward reward;
  BuyButton({Key key, @required this.reward}) : super(key: key);
  @override
  _BuyButtonState createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  ButtonState _state;

  @override
  void initState() {
    super.initState();
    _state = ButtonState.idle;
  }

  Future<void> _handleTransaction() async {
    setState(() => _state = ButtonState.working);
    String result =
        await locator<MarketService>().makeTransaction(widget.reward);
    setState(() => _state = ButtonState.idle);
    Flushbar(
      duration: const Duration(seconds: 10),
      title: result == null ? 'Transaction Posted' : 'Error',
      message: result ??
          'Your transaction was posted, the item will be placed in your wallet automatically.',
      leftBarIndicatorColor:
          result == null ? Colors.lightGreen : Colors.amberAccent,
      icon: result == null ? Icon(Icons.info) : Icon(Icons.error),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      textColor: Theme.of(context).accentTextTheme.button.color,
      child: const Text('Buy'),
      onPressed: _state == ButtonState.idle ? _handleTransaction : null,
    );
  }
}

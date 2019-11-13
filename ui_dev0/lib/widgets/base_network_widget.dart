import 'package:flutter/material.dart';
import 'package:ui_dev0/enums/controller_states.dart';

class NetworkLoaderWidget extends StatelessWidget {
  final Widget loading;
  final Widget error;
  final Widget child;
  final ControllerState state;

  const NetworkLoaderWidget({
    Key key,
    this.loading,
    this.error,
    @required this.state,
    @required this.child,
  })  : assert(
          state != null,
          'Unknown state "null" was given to BaseNetworkWidget',
        ),
        assert(
          child != null,
          'A child must be passed to the BaseNetworkWidget',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ControllerState.IDLE:
        return child;
      case ControllerState.BUSY:
        return loading ?? BaseLoadingWidget();
      default:
        return error ?? BaseErrorWidget();
    }
  }
}

class BaseErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.error),
          const SizedBox(height: 2),
          const Text('An error has occured.'),
        ],
      ),
    );
  }
}

class BaseLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
}

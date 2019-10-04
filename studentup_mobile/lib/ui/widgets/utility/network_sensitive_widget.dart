import 'package:flutter/material.dart';
import 'package:connectivity_widget/connectivity_widget.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final String text;
  final Future<void> Function() callback;

  NetworkSensitive({
    @required this.child,
    @required this.callback,
    this.text = 'You have no connection\n\n Please turn on your data',
  });

  @override
  Widget build(BuildContext context) {
    /// @deprecated
    /// Get our connection status from the provider
    /// var connectionStatus = Provider.of<ConnectivityStatus>(context);
    /// if (connectionStatus == ConnectivityStatus.Offline)

    //TODO: redesign this UI to have a proper interface to handle connectivity
    return ConnectivityWidget(
      onlineCallback: callback,
      builder: (context, isOnline) {
        if (isOnline) return child;
        return CustomScrollView(
          slivers: <Widget>[
            SliverFillViewport(
              delegate: SliverChildListDelegate([
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        );
      },
    );
  }
}

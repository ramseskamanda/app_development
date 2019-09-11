import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/connectivity_status.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final String text;

  NetworkSensitive({
    this.child,
    this.text = 'You have no connection\n\n Please turn on your data',
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Offline)
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

    return child;
  }
}

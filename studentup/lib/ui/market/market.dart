import 'package:studentup/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Marketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            transitionBetweenRoutes: false,
            leading: ProfileDrawerButton(),
            largeTitle: const Text('Marketplace'),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.11),
            sliver: StreamBuilder<Object>(
              stream: null,
              builder: (context, snapshot) => MarketplaceScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

class MarketplaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: const Icon(CupertinoIcons.mail),
      ),
    );
  }
}

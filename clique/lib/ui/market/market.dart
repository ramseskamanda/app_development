import 'package:clique/models/reward_model.dart';
import 'package:clique/services/market_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/ui/error/error_widget.dart';
import 'package:clique/ui/market/market_tile.dart';
import 'package:clique/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
            sliver: StreamBuilder<List<Reward>>(
              stream: locator<MarketService>().allRewards,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Reward>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return SliverToBoxAdapter(
                    child: Center(
                      child: const CircularProgressIndicator(),
                    ),
                  );
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return SliverToBoxAdapter(child: ErrorIndicator());
                } else if (snapshot.hasData) {
                  return RewardGrid(rewards: snapshot.data);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RewardGrid extends StatelessWidget {
  final List<Reward> rewards;
  RewardGrid({Key key, @required this.rewards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 2,
      itemCount: rewards.length,
      itemBuilder: (BuildContext context, int index) {
        return MarketTile(reward: rewards[index]);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.count(1, 1.1),
    );
  }
}

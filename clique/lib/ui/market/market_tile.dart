import 'package:cached_network_image/cached_network_image.dart';
import 'package:clique/models/reward_model.dart';
import 'package:clique/ui/market/buy_button.dart';
import 'package:flutter/material.dart';

class MarketTile extends StatelessWidget {
  final Reward reward;
  MarketTile({Key key, @required this.reward}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: reward.media,
              errorWidget: (_, __, ___) => const Icon(Icons.error),
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(reward.name),
                Text('${reward.pointsValue}pts'),
                BuyButton(
                  reward: reward,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

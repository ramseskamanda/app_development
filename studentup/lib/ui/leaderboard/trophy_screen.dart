import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/models/prize_model.dart';
import 'package:ui_dev/test_data.dart';

class TrophyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    assert(TestData.prizes.length == 3);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Prizes'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: TestData.prizes
                  .map((prize) => PrizeTile(prize: prize))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class PrizeTile extends StatelessWidget {
  final PrizeModel prize;

  const PrizeTile({Key key, this.prize}) : super(key: key);

  String _getRankingString(int ranking) {
    switch (ranking) {
      case 1:
        return '1st place';
      case 2:
        return '2nd place';
      case 3:
        return '3rd place';
      default:
        return 'Ranking Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          Text(
            _getRankingString(prize.ranking),
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: CupertinoColors.black),
          ),
          SizedBox(height: 16.0),
          Container(
            height: MediaQuery.of(context).size.height * 0.24,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  prize.imageUrl,
                  errorListener: () =>
                      print('CachedNetworkImageProvider Error'),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                prize.name,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: CupertinoColors.black.withOpacity(0.87)),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                prize.description,
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(color: CupertinoColors.black.withOpacity(0.87)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

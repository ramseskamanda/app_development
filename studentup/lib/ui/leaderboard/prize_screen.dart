import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/custom_sliver_delegate.dart';

class PrizeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: CustomSliverDelegate(
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              hideTitleWhenExpanded: true,
              hideChildWhenExpanded: false,
              stackChildHeight: 96,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => print('object'),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () => print('object'),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'iPhone X',
                      style: Theme.of(context).textTheme.display1.copyWith(
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Sponsored by Apple',
                      style: Theme.of(context).textTheme.title.copyWith(
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Description of an object and how to get it and a motivational speech fror some random shit.',
                        style: Theme.of(context).textTheme.subtitle,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    FlipClock.reverseCountdown(
                      duration: const Duration(days: 2, hours: 2, minutes: 2),
                      backgroundColor: Theme.of(context).cardColor,
                      digitColor: Theme.of(context).textTheme.title.color,
                      digitSize: 32.0,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'before prize is available',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

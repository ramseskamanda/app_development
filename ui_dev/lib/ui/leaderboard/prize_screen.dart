import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/models/prize_model.dart';
import 'package:ui_dev/test_data.dart';
import 'package:ui_dev/widgets/custom_sliver_delegate.dart';
import 'package:ui_dev/widgets/popup_menu.dart';

class PrizeScreen extends StatelessWidget {
  final PrizeModel model;

  const PrizeScreen({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: CustomSliverDelegate(
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              hideTitleWhenExpanded: true,
              hideChildWhenExpanded: true,
              stackChildHeight: 96.0,
              child: Center(child: Text('#${model.ranking}')),
              flexibleSpace: Hero(
                tag: '${model.docId}',
                child: CachedNetworkImage(
                  imageUrl: model.media,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: CupertinoColors.lightBackgroundGray,
                  ),
                  errorWidget: (_, __, error) => Container(
                    color: CupertinoColors.lightBackgroundGray,
                    child: Center(
                      child: const Icon(Icons.error),
                    ),
                  ),
                  imageBuilder: (_, image) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: image, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                PopupMenuWithActions(),
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
                      model.name,
                      style: Theme.of(context).textTheme.display1.copyWith(
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16.0),
                    if (model.sponsored)
                      Text(
                        'Sponsored',
                        style: Theme.of(context).textTheme.title.copyWith(
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        model.description,
                        style: Theme.of(context).textTheme.subtitle,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Hero(
                      tag: 'timer_prizes',
                      child: FlipClock.reverseCountdown(
                        duration: TestData.getDuration(),
                        backgroundColor: Theme.of(context).cardColor,
                        digitColor: Theme.of(context).textTheme.title.color,
                        digitSize: 32.0,
                      ),
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

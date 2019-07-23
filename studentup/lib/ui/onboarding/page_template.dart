import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studentup/routers/global_router.dart';

class PageTemplate extends Container {
  final Brightness brightness;
  final List<Widget> children;
  final String imageUrl;
  final String text;

  PageTemplate({
    Key key,
    @required this.brightness,
    @required this.imageUrl,
    this.children = const <Widget>[],
    this.text,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = brightness == Brightness.dark
        ? Theme.of(context).accentColor
        : Theme.of(context).scaffoldBackgroundColor;
    final Color contrastColor = brightness == Brightness.dark
        ? Theme.of(context).scaffoldBackgroundColor
        : Theme.of(context).accentColor;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: imageUrl,
              ),
              Padding(padding: const EdgeInsets.all(20.0)),
              if (text == null)
                ...children
              else ...[
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    text,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1.copyWith(
                        color: contrastColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ]
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'Skip',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: contrastColor),
                    ),
                    onPressed: () => Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed(GlobalRouter.signupRoute),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

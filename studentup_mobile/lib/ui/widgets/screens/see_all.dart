import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: MAKE THIS TAKE IN LIVE DATA

class SeeAll<T> extends StatelessWidget {
  final List<T> objects;
  final Widget Function(BuildContext, int) builder;
  final Widget separator;
  final String title;
  final Widget buildableWidget;

  const SeeAll({
    Key key,
    @required this.objects,
    @required this.builder,
    @required this.separator,
    this.title,
    this.buildableWidget,
  })  : assert(objects != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: title == null ? null : Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: objects.length,
        itemBuilder: builder,
        separatorBuilder: (context, index) => separator,
      ),
    );
  }
}

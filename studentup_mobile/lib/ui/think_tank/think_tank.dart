import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/think_tank_notifier.dart';

class ThinkTank extends StatelessWidget {
  final ThinkTanksModel model;

  const ThinkTank({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThinkTankNotifier>(
      builder: (_) => ThinkTankNotifier(model),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.0),
                ThinkTankHeader(model: model),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(width: 16.0),
                        VerticalDivider(
                          color: Colors.black,
                        ),
                        Text('A generic one line comment'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThinkTankHeader extends StatelessWidget {
  final ThinkTanksModel model;

  const ThinkTankHeader({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          model.title,
          softWrap: true,
          style: Theme.of(context).textTheme.display1.copyWith(
              color: CupertinoColors.black, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        Text(
          model.premise,
          softWrap: true,
          style: Theme.of(context).textTheme.subhead,
        ),
      ],
    );
  }
}

class ThinkTankResponses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThinkTankNotifier tank = Provider.of<ThinkTankNotifier>(context);
    assert(tank != null);
    return StreamBuilder<List<Object>>(
      stream: tank.comments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        if (snapshot.hasError)
          return Center(child: Text(snapshot.error.toString()));
        return CustomScrollView(
          slivers: <Widget>[
            ThinkTankHeader(model: tank.model),
            if (snapshot.hasData)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile();
                  },
                  childCount: snapshot.data.length,
                ),
              ),
          ],
        );
      },
    );
  }
}

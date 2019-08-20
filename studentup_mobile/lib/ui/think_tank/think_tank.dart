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
        body: CustomScrollView(
                slivers: <Widget>[
                  ThinkTankHeader(),
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
      ),
    );
  }
}

class ThinkTankHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Consumer<ThinkTankNotifier>(
//           builder: (_, tank, child) => StreamBuilder<List<Object>>(
//             stream: tank.comments,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting)
//                 return CircularProgressIndicator();
//               if (snapshot.hasError)
//                 return Center(child: Text(snapshot.error.toString()));
//               return CustomScrollView(
//                 slivers: <Widget>[
//                   ThinkTankHeader(),
//                   if (snapshot.hasData)
//                     SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                         (context, index) {
//                           return ListTile();
//                         },
//                         childCount: snapshot.data.length,
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ),
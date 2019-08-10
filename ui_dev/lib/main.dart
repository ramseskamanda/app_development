import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/test_data.dart';
import 'package:ui_dev/ui/app_navigation.dart';

import 'notifiers/view_notifiers/profile_notifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //!TODO: add global cache
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => ProfileNotifier(uid: TestData.userId),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: Application(),
      ),
    );
  }
}

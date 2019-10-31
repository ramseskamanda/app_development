import 'package:flutter/material.dart';
import 'package:ui_dev0/service_models/locator.dart';
import 'package:ui_dev0/views/communities/communities_view.dart';

// main() => runApp(DevicePreview(builder: (context) => MyApp()));
Future<void> main() async {
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: DevicePreview.of(context).locale,
      // builder: DevicePreview.appBuilder,
      theme: ThemeData.dark(),
      home: CommunitiesView(),
    );
  }
}

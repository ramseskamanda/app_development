import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/ui/search/search_root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: MultiProvider(
        providers: [],
        child: SearchRoot(),
      ),
    );
  }
}

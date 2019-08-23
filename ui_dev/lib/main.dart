import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //!TODO: add global cache
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: ThinkTank(),
    );
  }
}

class ThinkTank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

enum SearchCategory {
  ALL,
  AI,
  ART,
  BLOCKCHAIN,
  CODING,
  DESIGN,
  ENGINEERING,
  FINANCE,
  LAW,
  MANAGEMENT,
  MARKETING,
  MUSIC,
  WEB,
  OTHER,
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

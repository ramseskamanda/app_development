import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_development/communities/communities_root.dart';

import 'package:uuid/uuid.dart';

final uuid = new Uuid();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Communities(),
    );
  }
}

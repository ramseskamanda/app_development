import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UI Development'),
        ),
        body: Center(
          child: Text(
            'Welcome',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    );
  }
}

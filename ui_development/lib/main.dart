import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'model.title',
                    softWrap: true,
                    style: Theme.of(context).textTheme.display1.copyWith(
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'model.premise',
                    softWrap: true,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Divider(),
              Row(
                children: <Widget>[
                  Container(
                    width: 1.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 24.0),
                      Text(
                        'first comment!!!',
                        textAlign: TextAlign.left,
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

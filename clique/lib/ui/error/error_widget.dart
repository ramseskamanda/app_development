import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.error),
          Text('An error has occured'),
        ],
      ),
    );
  }
}

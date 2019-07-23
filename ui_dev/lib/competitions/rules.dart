import 'package:flutter/material.dart';
import 'package:ui_dev/stadium_button.dart';
import 'package:ui_dev/test_data.dart';

class CompetitionRules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => print('object'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () => print('object'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Competition Rules',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            for (int i = 0; i < TestData.rules.length; i++)
              RuleTile(TestData.rules[i], TestData.icons[i]),
            SizedBox(height: 16.0),
            StadiumButton(
              text: 'Accept',
              onPressed: () => print('object'),
            ),
          ],
        ),
      ),
    );
  }
}

class RuleTile extends StatelessWidget {
  final String rule;
  final IconData iconData;

  const RuleTile(this.rule, this.iconData);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, size: 32.0),
      title: Text(rule, softWrap: true),
      contentPadding: EdgeInsets.all(16.0),
    );
  }
}

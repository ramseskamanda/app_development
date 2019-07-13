import 'package:flutter/material.dart';
import 'package:studentup/util/theme.dart';

class DiscussionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Iterable<int>.generate(10)
            .map((index) => DiscussionWidget(discussion: index))
            .toList(),
      ),
    );
  }
}

class DiscussionWidget extends StatelessWidget {
  final int discussion;

  DiscussionWidget({Key key, this.discussion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white,
          boxShadow: AppTheme.getSimpleBoxShadow(
            color: Theme.of(context).accentColor,
          ),
        ),
        child: Center(
          child: Text('$discussion'),
        ),
      ),
    );
  }
}

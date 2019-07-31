import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompetitionFeedback extends StatefulWidget {
  @override
  _CompetitionFeedbackState createState() => _CompetitionFeedbackState();
}

class _CompetitionFeedbackState extends State<CompetitionFeedback>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 32.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Feedback',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 32.0),
            TextField(
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Write your feedback here...',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

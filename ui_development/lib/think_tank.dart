import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final String loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec at nisi nec lacus tincidunt venenatis vel eu tortor. Donec mattis nibh nec orci suscipit, sed vulputate metus dapibus. Sed finibus elementum consectetur. Etiam pretium justo est, ac maximus leo tempor ac. Vivamus non lorem vitae justo vulputate consectetur. Integer porta, dui ac sollicitudin egestas, dolor mi tristique leo, quis consectetur neque tellus et urna. Proin facilisis auctor ante, et accumsan quam imperdiet at. Aliquam semper mauris eu molestie congue. Curabitur venenatis odio in lectus molestie scelerisque. Phasellus laoreet mollis ullamcorper. Aenean venenatis mauris viverra gravida dictum. Cras sollicitudin viverra sodales. Morbi id nulla nunc. Maecenas ac dictum odio. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum commodo odio ut rhoncus tempor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;.';

class ThinkTank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('New Comment'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewCommentRoute(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                CommentWidget(),
                CommentWidget(),
                CommentWidget(),
                CommentWidget(),
                CommentWidget(),
                CommentWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        // Build the textspan
        var span = TextSpan(
          text: loremIpsum,
          style: Theme.of(context).textTheme.body1,
        );

        // Use a textpainter to determine if it will exceed max lines
        var tp = TextPainter(
          maxLines: 2,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: span,
        );

        // trigger it to layout
        tp.layout(maxWidth: size.maxWidth);

        // whether the text overflowed or not
        var exceeded = tp.didExceedMaxLines;

        return ExpandableNotifier(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommentHeaderWidget(),
              if (!exceeded) ...[
                Text.rich(
                  span,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ] else ...[
                Expandable(
                  collapsed: ExpandableButton(
                    child: Column(
                      children: <Widget>[
                        Text.rich(
                          span,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          'more',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  expanded: Column(
                    children: [
                      Text(
                        loremIpsum,
                        softWrap: true,
                      ),
                      ExpandableButton(
                        child: Text(
                          'collapse',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class CommentHeaderWidget extends StatefulWidget {
  @override
  _CommentHeaderWidgetState createState() => _CommentHeaderWidgetState();
}

class _CommentHeaderWidgetState extends State<CommentHeaderWidget> {
  final Random rand = Random();
  int randomUser;

  bool upvote;
  bool downvote;

  @override
  void initState() {
    super.initState();
    randomUser = rand.nextInt(1000);
    upvote = false;
    downvote = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: <Widget>[
          Text(
            'Random User #$randomUser',
            style:
                Theme.of(context).textTheme.subhead.apply(fontWeightDelta: 2),
          ),
          Spacer(),
          FlatButton.icon(
            icon: const Icon(Icons.keyboard_arrow_up),
            label: Text(
              '7k',
              style: TextStyle(
                color: upvote
                    ? Theme.of(context).accentColor
                    : Theme.of(context).disabledColor,
              ),
            ),
            onPressed: () {
              if (upvote)
                upvote = false;
              else {
                upvote = true;
                downvote = false;
              }
              setState(() {});
            },
          ),
          FlatButton.icon(
            icon: const Icon(Icons.keyboard_arrow_down),
            label: Text(
              '7k',
              style: TextStyle(
                color: downvote
                    ? CupertinoColors.destructiveRed
                    : Theme.of(context).disabledColor,
              ),
            ),
            onPressed: () {
              if (downvote)
                downvote = false;
              else {
                downvote = true;
                upvote = false;
              }
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

class NewCommentRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: CupertinoColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('New Comment'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Stack(
              children: <Widget>[
                TextField(
                  maxLength: 1000,
                  maxLengthEnforced: true,
                  minLines: 10,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your comment here...'),
                ),
                Positioned(
                  bottom: 24.0,
                  left: 0,
                  right: 0,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: const Text('Post Comment'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

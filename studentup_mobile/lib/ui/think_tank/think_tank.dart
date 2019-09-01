import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/think_tank_notifier.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/think_tank/new_comment_route.dart';

class ThinkTank extends StatelessWidget {
  final ThinkTanksModel model;

  const ThinkTank({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThinkTankNotifier notifier = ThinkTankNotifier(model);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: FloatingActionButton.extended(
          icon: const Icon(
            Icons.add,
            color: CupertinoColors.white,
          ),
          label: const Text(
            'New Comment',
            style: TextStyle(color: CupertinoColors.white),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewCommentRoute(notifier: notifier),
              ),
            );
          },
        ),
      ),
      body: ChangeNotifierProvider<ThinkTankNotifier>.value(
        value: notifier,
        child: SafeArea(
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
                        model.title,
                        softWrap: true,
                        style: Theme.of(context).textTheme.display1.copyWith(
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        model.premise,
                        softWrap: true,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Divider(),
                  StreamBuilder(
                    stream: notifier.comments,
                    initialData: null,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(
                            child: const CircularProgressIndicator(),
                          );
                        print(snapshot.error);
                        return Center(child: const Text('An Error Occured...'));
                      }
                      String uid = Locator.of<AuthService>().currentUser.uid;
                      return Column(
                        children: <Widget>[
                          for (Comments comment in snapshot.data)
                            CommentWidget(
                              key: ValueKey(comment.docId),
                              uid: uid,
                              model: comment,
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final Comments model;
  final String uid;

  const CommentWidget({Key key, this.model, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        // Build the textspan
        var span = TextSpan(
          text: model.content,
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
              CommentHeaderWidget(model: model, uid: uid),
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
                        model.content,
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
  final Comments model;
  final String uid;

  const CommentHeaderWidget({Key key, @required this.model, @required this.uid})
      : super(key: key);
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThinkTankNotifier>(
      builder: (context, notifier, child) {
        upvote = widget.model.upvotes.contains(widget.uid);
        downvote = widget.model.downvotes.contains(widget.uid);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: <Widget>[
              Text(
                'Random User #$randomUser',
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .apply(fontWeightDelta: 2),
              ),
              Spacer(),
              FlatButton.icon(
                icon: const Icon(Icons.keyboard_arrow_up),
                label: Text(
                  widget.model.upvotesCount,
                  style: TextStyle(
                    color: upvote
                        ? Theme.of(context).accentColor
                        : Theme.of(context).disabledColor,
                  ),
                ),
                onPressed: () async => await notifier.upvoteComment(
                  cancelVote: upvote,
                  id: widget.model.docId,
                ),
              ),
              FlatButton.icon(
                icon: const Icon(Icons.keyboard_arrow_down),
                label: Text(
                  widget.model.downvotesCount,
                  style: TextStyle(
                    color: downvote
                        ? CupertinoColors.destructiveRed
                        : Theme.of(context).disabledColor,
                  ),
                ),
                onPressed: () async => await notifier.downvoteComment(
                  cancelVote: downvote,
                  id: widget.model.docId,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

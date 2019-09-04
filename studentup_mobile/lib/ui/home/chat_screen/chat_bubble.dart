import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/util/util.dart';
import 'package:timeago/timeago.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel model;
  final String timeSeenAgo, timeSent;
  final bool isUser, isLast;

  ChatBubble({
    Key key,
    @required this.model,
    @required this.isLast,
    @required this.isUser,
  })  : timeSeenAgo = model.seenAt != null ? format(model.seenAt) : null,
        timeSent = Util.formatHour(model.sentAt),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = isUser ? Theme.of(context).accentColor : Colors.grey[200];
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isUser
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.3,
            minWidth: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  model.text,
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black,
                  ),
                ),
              ),
              FittedBox(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    timeSent,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isLast && isUser)
          Padding(
            padding: isUser
                ? EdgeInsets.only(
                    right: 10,
                    bottom: 10.0,
                  )
                : EdgeInsets.only(
                    left: 10,
                    bottom: 10.0,
                  ),
            child: Text(
              model.seenAt != null ? 'Seen $timeSeenAgo' : 'Sent',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.0,
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatBubble extends StatefulWidget {
  final String timeAgo;
  final bool isMe, isLast;
  final bool seen = true;

  ChatBubble({
    Key key,
    @required bool isLast,
  })  : timeAgo = timeago.format(DateTime.now().subtract(Duration(days: 1))),
        isMe = false,
        isLast = isLast;

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    final bg = widget.isMe ? Theme.of(context).accentColor : Colors.grey[200];
    final align =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = widget.isMe
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
              SizedBox(width: 2),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Hello, world!',
                  style: TextStyle(
                    color: widget.isMe ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.isLast)
          Padding(
            padding: widget.isMe
                ? EdgeInsets.only(
                    right: 10,
                    bottom: 10.0,
                  )
                : EdgeInsets.only(
                    left: 10,
                    bottom: 10.0,
                  ),
            child: Text(
              '${widget.seen ? 'Seen' : 'Sent'} ${widget.timeAgo}',
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

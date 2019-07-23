import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ui_dev/chat_screen/conversation.dart';
import 'package:ui_dev/models/chat_model.dart';

class ChatItem extends StatefulWidget {
  final ChatModel chatModel;
  final String imageUrl;

  ChatItem({
    Key key,
    @required this.chatModel,
  })  : imageUrl = 'https://via.placeholder.com/150',
        super(key: key ?? ValueKey(chatModel.id));

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[
            Hero(
              tag: widget.chatModel.id,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  widget.imageUrl,
                  errorListener: () => print('Network Image error'),
                ),
                radius: 25,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 6.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 11,
                width: 11,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.chatModel.status
                          ? Colors.greenAccent
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 7,
                    width: 7,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          widget.chatModel.interlocutorId,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(widget.chatModel.messages.first.message),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              timeago.format(widget.chatModel.messages.first.timestamp),
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 5),
            widget.chatModel.numUnread == 0
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 11,
                      minHeight: 11,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                      child: Text(
                        widget.chatModel.numUnread.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ),
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            CupertinoPageRoute(
              builder: (context) => Conversation(chatModel: widget.chatModel),
            ),
          );
        },
      ),
    );
  }
}

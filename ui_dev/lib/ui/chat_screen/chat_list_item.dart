import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ui_dev/models/chat_model.dart';
import 'package:ui_dev/notifiers/view_notifiers/chats_notifier.dart';
import 'package:ui_dev/ui/chat_screen/conversation.dart';

class ChatListItem extends StatelessWidget {
  final ChatModel model;

  ChatListItem({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[
            Hero(
              tag: 'chat_model',
              child: CachedNetworkImage(
                imageUrl: model.other.mediaRef,
                placeholder: (_, url) => CircleAvatar(
                  radius: 25,
                  backgroundColor: CupertinoColors.lightBackgroundGray,
                ),
                errorWidget: (_, url, error) => CircleAvatar(
                  radius: 25,
                  backgroundColor: CupertinoColors.lightBackgroundGray,
                  child: Icon(Icons.error),
                ),
                imageBuilder: (context, image) {
                  return CircleAvatar(
                    radius: 25,
                    backgroundImage: image,
                  );
                },
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
                      color: model.lastMessage.sentAt.isBefore(DateTime.now()
                              .subtract(const Duration(minutes: 5)))
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
          model.other.givenName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(model.lastMessage.text),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              timeago.format(model.lastMessage.sentAt),
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 5),
            model.userUnread == 0
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
                        model.userUnread.toString(),
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
          Provider.of<ChatsNotifier>(context)?.updateRead(model.docId);
          Navigator.of(context, rootNavigator: true).push(
            CupertinoPageRoute(
              builder: (context) => Conversation(chat: model),
            ),
          );
        },
      ),
    );
  }
}

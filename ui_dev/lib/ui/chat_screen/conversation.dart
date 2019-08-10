import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/models/chat_model.dart';
import 'package:ui_dev/models/message_model.dart';
import 'package:ui_dev/services/messaging_service.dart';
import 'package:ui_dev/ui/chat_screen/chat_bubble.dart';
import 'package:ui_dev/ui/chat_screen/messaging_text_field.dart';
import 'package:ui_dev/ui/profile/other_profile.dart';
import 'package:ui_dev/widgets/popup_menu.dart';

class Conversation extends StatelessWidget {
  final ChatModel chat;
  const Conversation({Key key, @required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessagingService>(
      builder: (_) => MessagingService(
        collection: chat.messagesCollection,
        uid: chat.userId,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: InkWell(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 10.0),
                  child: Hero(
                    tag: 'chat_model',
                    child: CachedNetworkImage(
                      imageUrl: chat.other.mediaRef,
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
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Text(
                        chat.other.givenName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        chat.lastMessage.sentAt.isAfter(DateTime.now()
                                .subtract(const Duration(minutes: 5)))
                            ? 'Online'
                            : 'Offline',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OtherProfile(
                  infoModel: chat.other,
                  fromMessaging: true,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Consumer<MessagingService>(
              builder: (context, service, child) {
                return PopupMenuWithActions(
                  onDelete: () {
                    service.deleteConversation();
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Flexible(
                child: Consumer<MessagingService>(
                  builder: (context, service, child) {
                    return StreamBuilder<List<MessageModel>>(
                      stream: service.messages,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(
                              child: const CircularProgressIndicator());
                        if (snapshot.hasError)
                          return Center(
                            child: const Text(
                              'An error occured, please try again later.',
                            ),
                          );
                        if ((snapshot.connectionState == ConnectionState.none ||
                                snapshot.connectionState ==
                                    ConnectionState.done) &&
                            !snapshot.hasData)
                          return Center(
                            child: const Text(
                              'Your request timed out and no data was found.',
                            ),
                          );

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemCount: snapshot.data.length,
                          reverse: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ChatBubble(
                              model: snapshot.data[index],
                              isUser:
                                  chat.userId == snapshot.data[index].senderId,
                              isLast: index == 0,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(child: MessagingTextField()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

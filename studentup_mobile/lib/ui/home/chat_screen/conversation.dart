import 'package:cached_network_image/cached_network_image.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/messaging_action.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/messaging_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/ui/home/chat_screen/chat_bubble.dart';
import 'package:studentup_mobile/ui/home/chat_screen/messaging_text_field.dart';
import 'package:studentup_mobile/ui/widgets/buttons/popup_menu.dart';
import 'package:studentup_mobile/ui/widgets/utility/network_sensitive_widget.dart';

class Conversation extends StatefulWidget {
  final ChatModel chat;
  const Conversation({Key key, @required this.chat}) : super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  ScrollController _controller;
  MessagingNotifier messagingService;

  @override
  void initState() {
    super.initState();
    messagingService = MessagingNotifier(
      collection: widget.chat.messagesCollection,
      uid: widget.chat.userId,
    );
    _controller = ScrollController(); //..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _loadMore() {
  //   double maxScroll = _controller.position.maxScrollExtent;
  //   double currentScroll = _controller.position.pixels;
  //   double delta = MediaQuery.of(context).size.height * 0.25;

  //   // if (maxScroll - currentScroll <= delta) messagingService.loadMore();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessagingNotifier>.value(
      value: messagingService,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
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
                    tag: 'chat_model:${widget.chat.docId}',
                    child: CachedNetworkImage(
                      imageUrl: widget.chat.otherProfile.imageUrl,
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
                        widget.chat.otherProfile.givenName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        widget.chat.lastMessage.sentAt.isAfter(DateTime.now()
                                .subtract(const Duration(minutes: 15)))
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
            onTap: () {
              Navigator.of(context).pushNamed(
                Router.otherProfile,
                arguments: {
                  'infoModel': widget.chat.otherProfile,
                  'fromMessaging': true,
                },
              );
            },
          ),
          actions: <Widget>[
            Consumer<MessagingNotifier>(
              builder: (context, service, child) {
                return PopupMenuWithActions(
                  onDelete: () {
                    service.sendData(MessagingAction.DELETE);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ],
        ),
        body: NetworkSensitive(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Flexible(
                  child: Consumer<MessagingNotifier>(
                    builder: (context, service, child) {
                      return FirestoreAnimatedList(
                        controller: _controller,
                        query: service.messages,
                        reverse: true,
                        emptyChild:
                            Center(child: const Text('No messages here yet!')),
                        itemBuilder: (context, document, animation, index) {
                          MessageModel model = MessageModel.fromDoc(document);
                          return FadeTransition(
                            key: ObjectKey(model),
                            opacity: animation,
                            child: ChatBubble(
                              key: ObjectKey(model),
                              model: model,
                              isUser: model.senderId ==
                                  Locator.of<BaseAuth>().currentUserId,
                              isLast: index == 0,
                            ),
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
      ),
    );
  }
}

/*
StreamBuilder<List<MessageModel>>(
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
*/

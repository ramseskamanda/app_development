import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/chats_notifier.dart';
import 'package:studentup_mobile/ui/home/chat_screen/chat_list_item.dart';
import 'package:studentup_mobile/ui/home/chat_screen/new_message.dart';

class Chats extends StatefulWidget {
  //! TODO: create new chats,  pagination (messages and chats)
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<ChatsNotifier>(
      builder: (_) => ChatsNotifier(),
      child: WillPopScope(
        onWillPop: () async {
          Provider.of<PageController>(context).animateToPage(
            0,
            duration: kTabScrollDuration,
            curve: Curves.easeInOutQuad,
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text('Direct Messaging'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back),
              onPressed: () {
                Provider.of<PageController>(context).animateToPage(
                  0,
                  duration: kTabScrollDuration,
                  curve: Curves.easeInOutQuad,
                );
              },
            ),
          ),
          body: UserChats(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NewMessage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UserChats extends StatefulWidget {
  @override
  _UserChatsState createState() => _UserChatsState();
}

class _UserChatsState extends State<UserChats> {
  final ScrollController _controller = ScrollController();

  Future<void> _loadMore() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChatsNotifier notifier = Provider.of(context);
    return FirestoreAnimatedList(
      controller: _controller,
      query: notifier.chatPreviews,
      emptyChild: Center(
        child: const Text('No chats here yet!'),
      ),
      itemBuilder: (context, document, animation, index) {
        ChatModel model = ChatModel.fromDoc(document);
        return FadeTransition(
          opacity: animation,
          child: ChatListItem(model: model),
        );
      },
    );
  }
}

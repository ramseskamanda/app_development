import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/chats_notifier.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/ui/home/chat_screen/chat_list_item.dart';
import 'package:studentup_mobile/ui/widgets/utility/network_sensitive_widget.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ChatsNotifier notifier = ChatsNotifier();
    return ChangeNotifierProvider<ChatsNotifier>.value(
      value: notifier,
      child: WillPopScope(
        onWillPop: () async {
          Provider.of<InnerRouter>(context).goToPage(0);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text('Direct Messaging'),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back),
              onPressed: () => Provider.of<InnerRouter>(context).goToPage(0),
            ),
          ),
          body: NetworkSensitive(
            callback: notifier.fetchData,
            child: UserChats(),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'new_message',
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              Icons.add,
              color: CupertinoColors.white,
            ),
            onPressed: () => Navigator.of(context).pushNamed(Router.newMessage),
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
    return StreamProvider<List<ChatModel>>(
      builder: (_) => notifier.chatPreviews,
      updateShouldNotify: (a, b) => true,
      catchError: (_, error) => [],
      child: Consumer<List<ChatModel>>(
        builder: (context, chats, child) {
          if (chats == null)
            return Center(child: const CircularProgressIndicator());
          if (chats.isEmpty)
            return Center(child: const Text('No chats here yet!'));
          return LiquidPullToRefresh(
            onRefresh: notifier.fetchData,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: chats.length,
              itemBuilder: (_, index) => ChatListItem(
                  key: ObjectKey(chats[index]), model: chats[index]),
            ),
          );
        },
      ),
    );
  }
}

// return FirestoreAnimatedList(
//   controller: _controller,
//   query: notifier.chatPreviews,
//   emptyChild: Center(child: const Text('No chats here yet!')),
//   itemBuilder: (context, document, animation, index) {
//     ChatModel model = ChatModel.fromDoc(document);
//     print(model.lastMessage);
//     return FadeTransition(
//       key: ObjectKey(model),
//       opacity: animation,
//       child: ChatListItem(key: ObjectKey(model), model: model),
//     );
//   },
// );

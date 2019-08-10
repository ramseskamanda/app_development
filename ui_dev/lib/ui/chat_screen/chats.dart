import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/notifiers/view_notifiers/chats_notifier.dart';
import 'package:ui_dev/test_data.dart';
import 'package:ui_dev/ui/chat_screen/chat_list_item.dart';

class Chats extends StatefulWidget {
  //! TODO: create new chats, search for chats, pagination (messages and chats)
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<ChatsNotifier>(
      builder: (_) => ChatsNotifier(TestData.userId),
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
            actions: <Widget>[
              IconButton(
                icon: Icon(CupertinoIcons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: UserChats(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
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
    return Consumer<ChatsNotifier>(
      builder: (context, notifier, child) {
        if (notifier.isLoading)
          return Center(child: CircularProgressIndicator());
        if (notifier.hasError)
          return Center(child: Text(notifier.error.message));
        if (notifier.conversations.isEmpty)
          return Center(child: const Text('No Data Here Yet'));
        //TODO: change this into streambuilder
        return LiquidPullToRefresh(
          onRefresh: () => notifier.onRefresh(),
          child: ListView.separated(
            controller: _controller,
            padding: EdgeInsets.all(10),
            itemCount: notifier.conversations.length,
            separatorBuilder: (BuildContext context, int index) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 0.5,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Divider(),
                ),
              );
            },
            itemBuilder: (BuildContext context, int index) {
              //if (index == _data.length) return CupertinoActivityIndicator();
              return ChatListItem(model: notifier.conversations[index]);
            },
          ),
        );
      },
    );
  }
}

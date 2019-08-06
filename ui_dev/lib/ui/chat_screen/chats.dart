import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/ui/chat_screen/chat_item.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Direct Messaging'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () async {},
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
  List<String> _data;
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
    _data = <String>[''];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) return Center(child: const Text('No Data Here Yet'));
    return ListView.separated(
      controller: _controller,
      padding: EdgeInsets.all(10),
      itemCount: _data.length,
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
        return ChatItem();
      },
    );
  }
}

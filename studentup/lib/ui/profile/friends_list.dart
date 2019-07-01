import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Your Friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              FriendTile(index: index + 1),
        ),
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  final int index;

  const FriendTile({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        isThreeLine: true,
        leading: const Icon(CupertinoIcons.profile_circled),
        trailing: IconButton(
          icon: const Icon(CupertinoIcons.clear),
          onPressed: () => print('remove friend #$index'),
        ),
        title: Text('Full Name #$index'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('username'),
            const Text(
                'Bio and the likes are pretty cool and softwrap around here'),
          ],
        ),
      ),
    );
  }
}

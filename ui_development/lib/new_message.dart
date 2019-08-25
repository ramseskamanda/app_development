import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  bool userSelected = false;

  Future<void> _search() async {
    final int result = await showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
    );
    if (result != null)
      setState(() {
        userSelected = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: CupertinoColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'New Message',
          style: TextStyle(color: CupertinoColors.black),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (userSelected)
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                        title: Text('User McUsername'),
                        subtitle: Text('User University'),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: _search,
                        ),
                      )
                    else
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Search user...'),
                        trailing: const Icon(CupertinoIcons.search),
                        onTap: _search,
                      ),
                    const SizedBox(height: 24.0),
                    TextField(
                      maxLength: 1000,
                      maxLengthEnforced: true,
                      minLines: 10,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your message here...',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<int> {
  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isEmpty) return null;
    return <Widget>[
      IconButton(
        icon: Icon(CupertinoIcons.clear_circled_solid),
        color: CupertinoColors.lightBackgroundGray,
        splashColor: Theme.of(context).accentColor,
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8.0),
              Text(
                'People',
                style:
                    Theme.of(context).textTheme.title.apply(fontWeightDelta: 1),
              ),
              const SizedBox(height: 12.0),
              for (int i in [0, 1, 2])
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: CupertinoColors.activeGreen,
                  ),
                  title: Text('User $i'),
                  subtitle: Text('University of $i'),
                  onTap: () => close(context, i),
                ),
              const SizedBox(height: 20.0),
              Text(
                'Startups',
                style:
                    Theme.of(context).textTheme.title.apply(fontWeightDelta: 1),
              ),
              const SizedBox(height: 12.0),
              for (int i in [0, 1, 2])
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: CupertinoColors.activeGreen,
                  ),
                  title: Text('User $i'),
                  subtitle: Text('University of $i'),
                  onTap: () => close(context, i),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8.0),
              Text(
                'People',
                style:
                    Theme.of(context).textTheme.title.apply(fontWeightDelta: 1),
              ),
              const SizedBox(height: 12.0),
              for (int i in [0, 1, 2])
                ListTile(
                  title: Text('User $i'),
                  onTap: () {
                    query = 'User $i';
                    showResults(context);
                  },
                ),
              const SizedBox(height: 20.0),
              Text(
                'Startups',
                style:
                    Theme.of(context).textTheme.title.apply(fontWeightDelta: 1),
              ),
              const SizedBox(height: 12.0),
              for (int i in [0, 1, 2])
                ListTile(
                  title: Text('Startup $i'),
                  onTap: () {
                    query = 'Startup $i';
                    showResults(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

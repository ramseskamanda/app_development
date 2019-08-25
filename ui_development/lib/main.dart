import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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

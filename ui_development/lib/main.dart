import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_development/data.dart';

import 'package:uuid/uuid.dart';

final uuid = new Uuid();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Communities(),
    );
  }
}

class Communities extends StatelessWidget {
  final List<Tab> _tabs = [
    Tab(text: 'Discover'),
    Tab(text: 'My Communities'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs,
            indicatorColor: Theme.of(context).accentColor,
            labelColor: Theme.of(context).textTheme.title.color,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              DiscoverCommunities(),
              Container(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateCommunity()),
          ),
        ),
      ),
    );
  }
}

class DiscoverCommunities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: () async {},
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 16.0),
          SearchBar(
            title: 'Search Communities',
            callback: () async {},
          ),
          const SizedBox(height: 16.0),
          for (int _ in [0, 1, 2, 3, 4]) CommunityCard(),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final String title;
  final Future<void> Function() callback;
  final double widthFactor;

  const SearchBar({
    Key key,
    @required this.title,
    @required this.callback,
    this.widthFactor = 0.86,
  })  : assert(widthFactor > 0.0 && widthFactor <= 1.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Center(
        child: RaisedButton(
          color: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () async => await callback(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 4.0),
              Opacity(
                opacity: 0.7,
                child: const Icon(CupertinoIcons.search),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Opacity(
                  opacity: 0.7,
                  child: Text(title),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  print('Settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCommunities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: DropdownButton(
            hint: const Text(''),
            items: [],
          ),
        )
      ],
    );
  }
}

class CommunityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.26,
      child: Card(
        child: FractionallySizedBox(
          widthFactor: 0.86,
          child: Column(
            children: <Widget>[
              Spacer(flex: 3),
              Text(
                'Maastricht University',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.apply(
                      fontSizeFactor: 1.1,
                      fontWeightDelta: 2,
                    ),
              ),
              Spacer(),
              Text(
                'Created by Studentup',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    CupertinoIcons.group_solid,
                    color: Theme.of(context).accentColor,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '2.456 members',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle.apply(
                        fontSizeDelta: 5, color: Theme.of(context).accentColor),
                  ),
                ],
              ),
              Spacer(),
              Text(
                loremIpsum.substring(0, 400),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateCommunity extends StatefulWidget {
  @override
  _CreateCommunityState createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  final CommunityCreator communityCreator = CommunityCreator();
  int _currentPageIndex = 0;
  PageController _controller;
  final List<Widget> _list = <Widget>[
    CreateCommunityInfo(),
    CreateCommunityPrivacy(),
    CreateCommunityFirstMembers(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController()
      ..addListener(() =>
          setState(() => _currentPageIndex = _controller.page.truncate()));
  }

  @override
  void dispose() {
    communityCreator.dispose();
    _controller.dispose();
    super.dispose();
  }

  void previousPage() {
    if (_currentPageIndex == 0) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
    _controller.previousPage(
      duration: kTabScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    FocusScope.of(context).unfocus();
    if (_currentPageIndex == _list.length - 1) return;
    _controller.nextPage(
      duration: kTabScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  String _buildTitle() {
    switch (_currentPageIndex) {
      case 0:
        return 'Create Community';
      case 1:
        return 'Community Privacy';
      case 2:
        return 'First Members';
      default:
        return 'Create Community';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Theme.of(context).iconTheme.color,
          icon: Icon(Icons.arrow_back),
          onPressed: previousPage,
        ),
        title: Text(
          _buildTitle(),
          style: TextStyle(color: Theme.of(context).textTheme.title.color),
        ),
      ),
      body: ChangeNotifierProvider<CommunityCreator>.value(
        value: communityCreator,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                children: _list,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.86,
                  child: StreamBuilder<String>(
                      stream: communityCreator.input.name,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          shape: StadiumBorder(),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: _currentPageIndex != _list.length - 1
                              ? Text('Next')
                              : Text('Finish'),
                          onPressed:
                              (snapshot.hasData && snapshot.data.length >= 3)
                                  ? nextPage
                                  : null,
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateCommunityInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.86,
        child: Consumer<CommunityCreator>(
            builder: (context, communityCreator, child) {
          return Column(
            children: <Widget>[
              const SizedBox(height: 32.0),
              TextField(
                controller: communityCreator.input.nameController,
                maxLines: 1,
                maxLength: 32,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Community Name',
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: communityCreator.input.descriptionController,
                minLines: 5,
                maxLines: null,
                maxLength: 400,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write a description',
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CreateCommunityPrivacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CommunityCreator communityCreator = Provider.of(context);
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.86,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 32.0),
            const Text(
              'Would you like to create a public or private community?\nThis can still be changed after creation.',
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            RadioListTile<CommunityPrivacy>(
              title: const Text('Private Community'),
              subtitle: const Text('Invite-only community.'),
              value: CommunityPrivacy.private,
              groupValue: communityCreator.setting,
              onChanged: (val) => communityCreator.setting = val,
            ),
            RadioListTile<CommunityPrivacy>(
              title: const Text('Public Community'),
              subtitle: const Text('Everyone can see and join the community.'),
              value: CommunityPrivacy.public,
              groupValue: communityCreator.setting,
              onChanged: (val) => communityCreator.setting = val,
            ),
          ],
        ),
      ),
    );
  }
}

class CreateCommunityFirstMembers extends StatefulWidget {
  @override
  _CreateCommunityFirstMembersState createState() =>
      _CreateCommunityFirstMembersState();
}

class _CreateCommunityFirstMembersState
    extends State<CreateCommunityFirstMembers> {
  @override
  Widget build(BuildContext context) {
    final CommunityCreator communityCreator = Provider.of(context);
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.86,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 32.0),
            Text(
              'Almost done! As a last step, invite the first members to your community.',
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.body2.apply(fontSizeDelta: 3),
            ),
            const SizedBox(height: 32.0),
            SearchBar(
              title: 'Search for new members',
              widthFactor: 1.0,
              callback: () async => communityCreator.addMember(uuid.v4()),
            ),
            const SizedBox(height: 32.0),
            if (communityCreator.earlyMembers.length == 0) ...[
              const Text('No members added yet!')
            ] else
              ...communityCreator.earlyMembers.map((member) {
                return ListTile(
                  title: Text(member),
                  leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/portrait.jpeg')),
                  trailing: IconButton(
                    icon: Icon(
                      CupertinoIcons.delete,
                      color: CupertinoColors.destructiveRed,
                    ),
                    onPressed: () => communityCreator.removeMember(member),
                  ),
                  onTap: () => print(member),
                );
              }),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}

enum CommunityPrivacy {
  private,
  public,
}

class CommunityCreator extends ChangeNotifier {
  final CommunityCreatorBloc _inputBloc = CommunityCreatorBloc();
  CommunityPrivacy _setting = CommunityPrivacy.public;
  final List<String> _earlyMembers = [];

  CommunityCreatorBloc get input => _inputBloc;
  CommunityPrivacy get setting => _setting;
  List<String> get earlyMembers => _earlyMembers;

  set setting(CommunityPrivacy value) {
    _setting = value;
    notifyListeners();
  }

  void addMember(String value) {
    _earlyMembers.add(value);
    notifyListeners();
  }

  void removeMember(String value) {
    _earlyMembers.remove(value);
    notifyListeners();
  }

  @override
  void dispose() {
    _inputBloc.dispose();
    super.dispose();
  }
}

class CommunityCreatorBloc {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final BehaviorSubject<String> _nameStream = BehaviorSubject();
  final BehaviorSubject<String> _descriptionStream = BehaviorSubject();

  TextEditingController get nameController => _name;
  TextEditingController get descriptionController => _description;
  ValueObservable<String> get name => _nameStream.stream;
  ValueObservable<String> get description => _descriptionStream.stream;

  CommunityCreatorBloc() {
    _name.addListener(() => _nameStream.sink.add(_name.text));
    _description
        .addListener(() => _descriptionStream.sink.add(_description.text));
  }

  void dispose() {
    _name.dispose();
    _description.dispose();
    _nameStream.close();
    _descriptionStream.close();
  }
}

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:provider/provider.dart';
import 'package:ui_development/communities/community_card.dart';
import 'package:ui_development/communities/community_page.dart';
import 'package:ui_development/communities/community_post.dart';
import 'package:ui_development/communities/create/root.dart';
import 'package:ui_development/data.dart';
import 'package:ui_development/models.dart';

class Communities extends StatelessWidget {
  // final CommunityDiscoverer discoverer = CommunityDiscoverer();
  final List<Tab> _tabs = [
    Tab(text: 'Discover'),
    Tab(text: 'My Communities'),
    Tab(text: 'My Feed'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            color: Theme.of(context).iconTheme.color,
            onPressed: () {},
          ),
          title: Text(
            'Communities',
            style: TextStyle(color: Theme.of(context).textTheme.title.color),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(CupertinoIcons.search),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {},
            )
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: _tabs,
            indicatorColor: Theme.of(context).accentColor,
            labelColor: Theme.of(context).textTheme.title.color,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              //Make this more efficient by only creating CommunityDiscoverer once
              // ChangeNotifierProvider<CommunityDiscoverer>.value(
              //   value: discoverer,
              //   child: DiscoverCommunities(),
              // ),
              DiscoverCommunities(),
              MyCommunities(),
              MyCommunityFeed(),
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
    // final CommunityDiscoverer discoverer = Provider.of(context);

    // if (discoverer.hasError)
    //   return Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text('An Error Occured...'),
    //         RaisedButton(
    //           child: const Text('Retry now!'),
    //           onPressed: () async => await discoverer.fetchData(),
    //         ),
    //       ],
    //     ),
    //   );

    // if (discoverer.isLoading) return Center(child: CircularProgressIndicator());

    return LiquidPullToRefresh(
      onRefresh: () async => {}, //discoverer.fetchData(),
      child: ListView(
        children: listCommunities
            .map((community) => CommunityCard(community: community))
            .toList(),
      ),
    );
  }
}

class MyCommunities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: listCommunities.map((community) {
            return Card(
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: community.creator.photoUrl,
                  imageBuilder: (context, image) {
                    return CircleAvatar(
                      backgroundImage: image,
                    );
                  },
                ),
                title: Text(community.name),
                subtitle: Text(community.description),
                trailing: Chip(
                  label: Text(community.memberCount.toString()),
                  backgroundColor: CupertinoColors.activeBlue,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CommunityPage(
                        community: community,
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MyCommunityFeed extends StatefulWidget {
  @override
  _MyCommunityFeedState createState() => _MyCommunityFeedState();
}

class _MyCommunityFeedState extends State<MyCommunityFeed> {
  static final Random rand = Random();
  CommunityModel selected;
  final List<CommunityModel> _items = [
    defaultCommunity,
    ...listCommunities,
  ];

  @override
  void initState() {
    super.initState();
    selected = _items[0];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 16.0),
        Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selected,
              onChanged: (val) => setState(() => selected = val),
              items: _items
                  .map(
                    (community) => DropdownMenuItem(
                      value: community,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(community.name),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        AllCommunityPosts(community: selected),
        const SizedBox(height: kBottomNavigationBarHeight),
      ],
    );
  }
}

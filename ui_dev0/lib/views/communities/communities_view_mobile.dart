import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/views/communities/common/community_card.dart';
import 'package:ui_dev0/views/communities/common/community_post.dart';
import 'package:ui_dev0/views/communities/state/communities_controller.dart';
import 'package:ui_dev0/views/community_page/community_page_view.dart';
import 'package:ui_dev0/views/create_community/create_community_view.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';
import 'package:ui_dev0/widgets/base_network_widget.dart';

class CommunitiesViewMobilePortrait extends StatelessWidget {
  final List<Tab> _tabs = [
    //Tab(text: 'Discover'),
    Tab(text: 'My Feed'),
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
              //DiscoverCommunities(),
              MyCommunityFeed(),
              MyCommunities(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateCommunityView()),
          ),
        ),
      ),
    );
  }
}

class DiscoverCommunities extends BaseModelWidget<CommunitiesController> {
  @override
  Widget build(BuildContext context, CommunitiesController data) {
    return NetworkLoaderWidget(
      state: data.state,
      child: LiquidPullToRefresh(
        onRefresh: () async => await data.fetchData(),
        child: ListView.builder(
          itemCount: data.communities.length,
          itemBuilder: (context, index) {
            return CommunityCard(
              community: data.communities[index],
            );
          },
        ),
      ),
    );
  }
}

class MyCommunities extends BaseModelWidget<CommunitiesController> {
  @override
  Widget build(BuildContext context, CommunitiesController data) {
    return NetworkLoaderWidget(
      state: data.state,
      child: ListView.builder(
        itemCount: data.communities.length,
        itemBuilder: (context, index) {
          CommunityModel community = data.communities[index];
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
                    builder: (_) => CommunityPageView(community: community),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MyCommunityFeed extends BaseModelWidget<CommunitiesController> {
  @override
  Widget build(BuildContext context, CommunitiesController data) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16.0),
        Center(
          child: DropdownButtonHideUnderline(
            child: StreamBuilder<List<CommunityModel>>(
              stream: data.userCommunities,
              builder: (context, snapshot) {
                return DropdownButton(
                  value: data.selected,
                  onChanged: (val) => data.selected = val,
                  items: [null, ...(snapshot.data ?? [])]
                      .map(
                        (community) => DropdownMenuItem(
                          value: community,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(community?.name ?? 'All communities'),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: CommunityPostsFeed(
            postStream: data.userPostFeed,
          ),
        ),
      ],
    );
  }
}

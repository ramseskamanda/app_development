import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Newest start-ups nearby',
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.separated(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    index == 0 ? Container() : SizedBox(width: 8.0),
                itemBuilder: (context, index) =>
                    index == 0 ? SizedBox(width: 16.0) : StartupCard(),
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'This month\'s prizes',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                    child: const Text('See all'),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.separated(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    index == 0 ? Container() : SizedBox(width: 8.0),
                itemBuilder: (context, index) =>
                    index == 0 ? SizedBox(width: 16.0) : PrizeCard(),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Competitions',
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class StartupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16.0),
            CircleAvatar(
              radius: 36.0,
              backgroundImage: CachedNetworkImageProvider(
                'https://via.placeholder.com/150',
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Studentup',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Studentup is the virtual campus where a student can find everything they need to start a business',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrizeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: CupertinoColors.darkBackgroundGray.withOpacity(0.57),
                  ),
                ),
                Center(
                  child: Text(
                    'iPhone X',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Sponsored',
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Theme.of(context).accentColor),
          ),
        ],
      ),
    );
  }
}

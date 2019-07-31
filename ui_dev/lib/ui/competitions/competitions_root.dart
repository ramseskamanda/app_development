import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ui_dev/widgets/custom_sliver_delegate.dart';
import 'package:ui_dev/widgets/stadium_button.dart';

class CompetitionPage extends StatelessWidget {
  final bool isOwner;

  const CompetitionPage({Key key, this.isOwner = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isSignedUp = true;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverDelegate(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                  ),
                ),
                stackChildHeight: 96.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => print('object'),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () => print('object'),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Column(
                    children: <Widget>[
                      if (_isSignedUp) ...[
                        Text(
                          'Signed Up!',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                        SizedBox(height: 16.0),
                      ],
                      Text(
                        'Studentup',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Competition Title for the science of data',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.display1.copyWith(
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          children: <Widget>[
                            LinearPercentIndicator(
                              lineHeight: 10.0,
                              percent: 0.8,
                              progressColor: Theme.of(context).accentColor,
                              backgroundColor:
                                  CupertinoColors.lightBackgroundGray,
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                if (isOwner)
                                  Text('80 participants signed up')
                                else
                                  Text('20 places left / 100'),
                                Text('15 days to go'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        '150 - 200 XP',
                        style: Theme.of(context).textTheme.title,
                      ),
                      const SizedBox(height: 16.0),
                      if (_isSignedUp) ...[
                        FlatButton.icon(
                          textColor: Theme.of(context).accentColor,
                          icon: Icon(Icons.file_download),
                          label: Text(
                            'Download attachement',
                            style: Theme.of(context).textTheme.title,
                          ),
                          onPressed: () => print('object'),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                      const Text(
                        'Description that talks about how data is the future and the future is data and makes complete sense because it s a great description.',
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                      const SizedBox(height: 16.0),
                      if (!isOwner) ...[
                        Text(
                          'Your Team',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12.0),
                        for (var i = 0; i < 3; i++)
                          TeamMemberListTile(isUser: i == 0),
                        if (true) const TeamMemberListTile(add: true),
                        const SizedBox(height: 16.0),
                        StadiumButton(
                          text: _isSignedUp ? 'Submit Answer' : 'Participate',
                          onPressed: () => print('object'),
                        ),
                      ] else ...[
                        FlatButton(
                          child: const Text('Download attachment'),
                          textColor: Theme.of(context).accentColor,
                          onPressed: () => print('object'),
                        ),
                        const SizedBox(height: 24.0),
                        StadiumButton(
                          text: 'Select Winners',
                          onPressed: () => print('object'),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMemberListTile extends StatelessWidget {
  final bool add;
  final bool isUser;

  const TeamMemberListTile({
    this.add = false,
    this.isUser = false,
  });

  void _search() => print('search');

  void _goToProfile() => print('object');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: ListTile(
        leading: !add
            ? CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  'https://via.placeholder.com/150',
                ),
              )
            : const Icon(Icons.add),
        title: !add
            ? const Text('Ramses Kamanda')
            : const Text(
                'Add Teammates..',
                style: TextStyle(
                  color: CupertinoColors.lightBackgroundGray,
                ),
              ),
        trailing: isUser ? const Text('You') : null,
        onTap: add ? _search : _goToProfile,
      ),
    );
  }
}

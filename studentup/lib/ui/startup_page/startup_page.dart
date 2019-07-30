import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:studentup/ui/widgets/stadium_button.dart';

class StartUpPageRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
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
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 32.0),
                CircleAvatar(
                  radius: 56.0,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://via.placeholder.com/150',
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Studentup',
                  style: Theme.of(context).textTheme.headline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                      ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'San Francisco, California',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: CupertinoColors.inactiveGray),
                ),
                const SizedBox(height: 12.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.67,
                  child: Text(
                    'Studentup is the first virtual campus where students can found start-ups and build experience.',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: CupertinoColors.black,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'www.studentup.com',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Theme.of(context).accentColor),
                ),
                const SizedBox(height: 24.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.67,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Team',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          FlatButton(
                            child: Text(
                              'See all',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                            onPressed: () => print('object'),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          for (int i in [0, 1, 2, 3])
                            TeamMember(isAdditional: i == 3, numAdditional: i),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 56.0),
                Text(
                  'Ongoing Competitions',
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                for (int i in [0, 1, 2]) CompetitionPost(index: i),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TeamMember extends StatelessWidget {
  final bool isAdditional;
  final int numAdditional;

  const TeamMember({Key key, this.isAdditional, this.numAdditional})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: CircleAvatar(
        radius: 32.0,
        child: isAdditional ? Text('+$numAdditional') : Container(),
        backgroundColor: isAdditional
            ? CupertinoColors.lightBackgroundGray
            : Colors.transparent,
        backgroundImage: isAdditional
            ? null
            : CachedNetworkImageProvider(
                'https://via.placeholder.com/150',
              ),
      ),
    );
  }
}

class CompetitionPost extends StatelessWidget {
  final int index;

  const CompetitionPost({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.56,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: CupertinoColors.inactiveGray.withOpacity(0.57),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 12.0),
                              Text(
                                'Studentup',
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                              ),
                              Text(
                                'Competition Title',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: CachedNetworkImageProvider(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.87,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    LinearPercentIndicator(
                      percent: 0.8,
                      progressColor: Theme.of(context).accentColor,
                      backgroundColor: CupertinoColors.lightBackgroundGray,
                      lineHeight: 8.0,
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '60 places left / 100',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          '15 days to go',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '150 - 200 XP!',
                      style: Theme.of(context).textTheme.title,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'A small description of the competition because that\'s important and everybody needs to know',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Spacer(),
                    StadiumButton(
                      text: 'Learn more!',
                      onPressed: () => print('object'),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

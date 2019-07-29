import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/stadium_button.dart';

class NotificationsRoot extends StatelessWidget {
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
        title: const Text('Notifications'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 10,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            itemBuilder: (context, index) {
              int _actions = index.isEven ? 1 : index == 3 ? 2 : 0;
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                    title: const Text('Mary Gilbert'),
                    subtitle: const Text('commented on your discussion.'),
                    trailing: CircleAvatar(
                      radius: 5.0,
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                  ),
                  if (_actions == 1) ...[
                    StadiumButton(
                      text: 'Claim Reward',
                      onPressed: () {},
                    ),
                  ] else if (_actions == 2) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              shape: StadiumBorder(),
                              color: Theme.of(context).accentColor,
                              textColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: const Text('Accept'),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: RaisedButton(
                              shape: StadiumBorder(),
                              color: Theme.of(context).accentColor,
                              textColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: const Text('Decline'),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

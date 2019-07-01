import 'package:studentup/router.dart';
import 'package:studentup/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (true)
            Icon(
              CupertinoIcons.profile_circled,
              size: MediaQuery.of(context).size.width * 0.3,
            ),
          /* if (false)
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.15,
              backgroundImage: CachedNetworkImageProvider(
                '',
                errorListener: () => _showNetworkError(context),
              ),
            ), */

          //Text Profile
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'user.name',
                  style: Theme.of(context).textTheme.headline,
                  softWrap: true,
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 6.0),
                Text(
                  'user.accountBalance points earned',
                  style: Theme.of(context).textTheme.title,
                  softWrap: true,
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 6.0),
                Text(
                  'user.bio',
                  style: Theme.of(context).textTheme.title,
                  softWrap: true,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        leading: ProfileDrawerButton(),
        middle: Text('@' + 'username'),
      ),
      body: Material(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Upper Profile
                  _buildUserProfile(context),
                  //Friends-related functionalities
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor:
                            Theme.of(context).accentTextTheme.button.color,
                        child: const Text('See Friends List'),
                        onPressed: () => Navigator.pushNamed(
                              context,
                              Router.friendsListRoute,
                            ),
                      ),
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor:
                            Theme.of(context).accentTextTheme.button.color,
                        child: const Text('Your Rewards'),
                        onPressed: () => Navigator.pushNamed(
                              context,
                              Router.friendsListRoute,
                            ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'Your studentup\'s Code.',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: PaddedFAB(
        icon: CupertinoIcons.add,
        text: 'Friend',
        onPressed: () => print('add friend'),
      ),
    );
  }
}

import 'package:studentup/router.dart';
import 'package:studentup/ui/profile/profile_head.dart';
import 'package:studentup/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
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
                  ProfileHeader(),
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
                    'The rest of your profile!😙',
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

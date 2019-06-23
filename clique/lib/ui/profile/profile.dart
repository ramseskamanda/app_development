import 'package:cached_network_image/cached_network_image.dart';
import 'package:clique/models/user_profile.dart';
import 'package:clique/router.dart';
import 'package:clique/services/friends_manager_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/ui/widgets/widgets.dart';
import 'package:clique/util/env.dart';
import 'package:clique/util/error_message.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simple_permissions/simple_permissions.dart';

class Profile extends StatelessWidget {
  void _showNetworkError(BuildContext context) {
    Flushbar(
      title: 'Network Error',
      message: 'Failed to load information due to network issues.',
      leftBarIndicatorColor: Colors.blueAccent,
      icon: Icon(Icons.info_outline),
    ).show(context);
  }

  Widget _buildUserProfile(BuildContext context, UserProfile user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (user.photoUrl == null)
            Icon(
              CupertinoIcons.profile_circled,
              size: MediaQuery.of(context).size.width * 0.3,
            ),
          if (user.photoUrl != null)
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.15,
              backgroundImage: CachedNetworkImageProvider(
                user.photoUrl,
                errorListener: () => _showNetworkError(context),
              ),
            ),

          //Text Profile
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${user.name}',
                  style: Theme.of(context).textTheme.headline,
                  softWrap: true,
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 6.0),
                Text(
                  '${user.accountBalance} points earned',
                  style: Theme.of(context).textTheme.title,
                  softWrap: true,
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 6.0),
                Text(
                  user.bio,
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

  Widget _buildUserQRCode(BuildContext context, String uid) {
    return QrImage(
      data: uid,
      size: MediaQuery.of(context).size.width * 0.77,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProfile _user = Provider.of<UserProfile>(context);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        leading: ProfileDrawerButton(),
        middle: Text('@' + _user.username),
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
                  _buildUserProfile(context, _user),
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
                    'Your Clique\'s Code.',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Spacer(),
                  _buildUserQRCode(context, _user.uid),
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
        onPressed: () => _handleAddFriend(context),
      ),
    );
  }

  Future<void> _handleAddFriend(BuildContext context) async {
    ErrorMessage result = await locator<FriendsManagerService>().scan();
    if (result != null) {
      print(result.code);
      if (result.code == Environment.permissionDeniedCamera) {
        SimplePermissions.requestPermission(Permission.Camera);
      } else {
        Flushbar(
          duration: const Duration(seconds: 3),
          title: result.code,
          message: result.details,
          leftBarIndicatorColor: Colors.amberAccent,
          icon: Icon(Icons.error),
        ).show(context);
      }
    } else {
      Flushbar(
        duration: const Duration(seconds: 3),
        title: 'Your friend request was sent succesfully!',
        message: 'You will be notified when the user accepts it.',
        leftBarIndicatorColor: Colors.lightGreen,
        icon: Icon(Icons.check_circle),
      ).show(context);
    }
  }
}

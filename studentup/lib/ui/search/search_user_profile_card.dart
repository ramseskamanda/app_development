import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatefulWidget {
  @override
  _UserProfileCardState createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  bool hearted;

  @override
  void initState() {
    super.initState();
    hearted = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('object'),
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: 32.0,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://via.placeholder.com/150',
                  ),
                ),
                Text(
                  'Ramses Kamanda',
                  softWrap: true,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Maastricht University',
                  softWrap: true,
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                RaisedButton(
                  child: const Text('Contact'),
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {},
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: hearted
                    ? Icon(CupertinoIcons.heart_solid, color: Colors.red)
                    : Icon(CupertinoIcons.heart),
                onPressed: () {
                  setState(() {
                    hearted = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

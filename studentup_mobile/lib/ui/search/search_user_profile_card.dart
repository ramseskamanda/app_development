import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/user_info_model.dart';

class UserProfileCard extends StatefulWidget {
  final UserInfoModel model;

  const UserProfileCard({Key key, @required this.model}) : super(key: key);

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
                CachedNetworkImage(
                  imageUrl: 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return CircularProgressIndicator();
                  },
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error);
                  },
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                      radius: 32.0,
                      backgroundImage: imageProvider,
                    );
                  },
                ),
                Text(
                  widget.model.givenName,
                  softWrap: true,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.model.university,
                  softWrap: true,
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                RaisedButton(
                  child: const Text('Contact'),
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () => print(widget.model.bio),
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

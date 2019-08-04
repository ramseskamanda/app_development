import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/notifiers/view_notifiers/profile_notifier.dart';
import 'package:ui_dev/theme.dart';

class ProfileAboutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: getSimpleBoxShadow(
            color: Theme.of(context).accentColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'About',
              style: Theme.of(context).textTheme.headline.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'This is some random text im typing because it\'s fun and I want to test this shit'
                'This is some random text im typing because it\'s fun and I want to test this shit',
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Spacer(flex: 2),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.06,
              backgroundImage: CachedNetworkImageProvider(
                'https://cdn1.iconfinder.com/data/icons/logotypes/32/square-linkedin-512.png',
                errorListener: () =>
                    print('⚠️  [📸 CachedNetworkImageProvider Error]'),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ProfileBadges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width * 0.12;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [0, 1, 2].map((int index) {
          return Padding(
            padding: EdgeInsets.only(top: index == 1 ? radius * 1.25 : 0.0),
            child: Material(
              elevation: 4.0,
              shape: CircleBorder(),
              shadowColor: Theme.of(context).accentColor,
              child: Consumer<ProfileNotifier>(
                builder: (context, notifier, child) {
                  if (notifier.isLoading || notifier.hasError)
                    return CircleAvatar(
                      radius: radius,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: notifier.isLoading
                          ? CircularProgressIndicator()
                          : Icon(Icons.error),
                    );
                  return CachedNetworkImage(
                    imageUrl: 'https://via.placeholder.com/150',
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                    imageBuilder: (context, image) {
                      return CircleAvatar(
                        radius: radius,
                        backgroundImage: image,
                      );
                    },
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/notifiers/view_notifiers/profile_notifier.dart';
import 'package:ui_dev/test_data.dart';

class ProfileEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _kDefaultSize = MediaQuery.of(context).size.width * 0.36;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: CupertinoColors.destructiveRed,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Edit Profile'),
        actions: <Widget>[
          Consumer<ProfileNotifier>(
            builder: (context, notifier, child) {
              return FlatButton(
                child: const Text('Done'),
                textColor: CupertinoColors.activeBlue,
                onPressed: notifier.isLoading || notifier.hasError
                    ? null
                    : () async {
                        await notifier.uploadEditorInfo();
                        if (!notifier.hasError) {
                          notifier.clearEditor();
                          Navigator.of(context).pop();
                        }
                      },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 48.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    child: Stack(
                      children: <Widget>[
                        //TODO: Image modifier
                        Hero(
                          tag: 'profile_picture',
                          child: Consumer<ProfileNotifier>(
                            builder: (context, notifier, child) {
                              if (notifier.isLoading || notifier.hasError)
                                return CircleAvatar(radius: _kDefaultSize / 2);
                              return CachedNetworkImage(
                                imageUrl: notifier.info.mediaRef,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error)),
                                imageBuilder: (context, image) {
                                  return CircleAvatar(
                                    radius: _kDefaultSize / 2,
                                    backgroundImage: image,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.camera_enhance),
                              color: Theme.of(context).accentColor,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48.0),
                  Consumer<ProfileNotifier>(
                    builder: (context, notifier, child) {
                      if (notifier.isLoading || notifier.hasError)
                        return Container();
                      return TextField(
                        controller: notifier.nameEditor,
                        minLines: 1,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: notifier.info.givenName,
                        ),
                      );
                    },
                  ),
                  Divider(),
                  Consumer<ProfileNotifier>(
                    builder: (context, notifier, child) {
                      if (notifier.isLoading || notifier.hasError)
                        return Container();
                      return TextField(
                        controller: notifier.universityEditor,
                        minLines: 1,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: notifier.info.university,
                        ),
                      );
                    },
                  ),
                  Divider(),
                  Consumer<ProfileNotifier>(
                    builder: (context, notifier, child) {
                      if (notifier.isLoading || notifier.hasError)
                        return Container();
                      return TextField(
                        controller: notifier.locationEditor,
                        minLines: 1,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: TestData.geoPointToLocation(
                              notifier.info.location),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  Consumer<ProfileNotifier>(
                    builder: (context, notifier, child) {
                      if (notifier.isLoading || notifier.hasError)
                        return Container();
                      return TextField(
                        controller: notifier.bioEditor,
                        minLines: 5,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: notifier.info.bio,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/profile_notifier.dart';

class ProfileEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileNotifier profile = Provider.of<ProfileNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: CupertinoColors.destructiveRed,
          ),
          onPressed: () {
            profile.clearEditor();
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Edit Profile'),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: profile.canPostEdit,
            initialData: false,
            builder: (context, snapshot) {
              return Consumer<ProfileNotifier>(
                  builder: (context, notifier, child) {
                return FlatButton(
                  child: const Text('Done'),
                  textColor: CupertinoColors.activeBlue,
                  onPressed:
                      (snapshot.hasData && snapshot.data) && !notifier.isLoading
                          ? () async {
                              final bool result =
                                  await profile.sendData(profile.isStartup);
                              if (result) {
                                profile.clearEditor();
                                Navigator.of(context).pop();
                              }
                            }
                          : null,
                );
              });
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
              child: profile.isStartup
                  ? StartupProfileEditor()
                  : StudentProfileEditor(),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentProfileEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _kDefaultSize = MediaQuery.of(context).size.width * 0.36;
    final ProfileNotifier profile = Provider.of<ProfileNotifier>(context);

    return StreamProvider<UserInfoModel>(
      builder: (context) => profile.userInfoStream,
      initialData: null,
      updateShouldNotify: (a, b) => true,
      catchError: (context, err) {
        profile.readError = NetworkError(message: err.toString());
        return null;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            child: Stack(
              children: <Widget>[
                Consumer<UserInfoModel>(
                  builder: (context, user, child) {
                    if (user == null)
                      return CircleAvatar(
                        radius: _kDefaultSize / 2,
                        backgroundColor:
                            CupertinoColors.extraLightBackgroundGray,
                      );
                    if (profile.image != null)
                      return CircleAvatar(
                        radius: _kDefaultSize / 2,
                        backgroundImage: FileImage(profile.image),
                      );
                    return CachedNetworkImage(
                      imageUrl: user.mediaRef,
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
                      onPressed: () async {
                        await profile.pickImage(1);
                        await profile.cropImage();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48.0),
          Consumer<UserInfoModel>(
            builder: (context, user, child) {
              if (user == null) return Container();
              return TextField(
                controller: profile.nameEditor,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Provider.of<UserInfoModel>(context).givenName,
                ),
              );
            },
          ),
          Divider(),
          Consumer<UserInfoModel>(
            builder: (context, user, child) {
              if (user == null) return Container();
              return TextField(
                controller: profile.additionalInfoEditor,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Provider.of<UserInfoModel>(context).university,
                ),
              );
            },
          ),
          Divider(),
          Consumer<UserInfoModel>(
            builder: (context, user, child) {
              if (user == null) return Container();
              return TextField(
                controller: profile.locationEditor,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Provider.of<UserInfoModel>(context).location,
                ),
              );
            },
          ),
          Divider(),
          Consumer<UserInfoModel>(
            builder: (context, user, child) {
              if (user == null) return Container();
              return TextField(
                controller: profile.bioEditor,
                minLines: 5,
                maxLines: null,
                maxLength: 140,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Provider.of<UserInfoModel>(context).bio,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StartupProfileEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _kDefaultSize = MediaQuery.of(context).size.width * 0.36;
    final ProfileNotifier profile = Provider.of<ProfileNotifier>(context);

    return StreamProvider<StartupInfoModel>(
      builder: (context) => profile.startupInfoStream,
      initialData: null,
      updateShouldNotify: (a, b) => true,
      catchError: (context, err) {
        profile.readError = NetworkError(message: err.toString());
        return null;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            child: Stack(
              children: <Widget>[
                Consumer<StartupInfoModel>(
                  builder: (context, user, child) {
                    if (user == null)
                      return CircleAvatar(
                        radius: _kDefaultSize / 2,
                        backgroundColor:
                            CupertinoColors.extraLightBackgroundGray,
                      );
                    if (profile.image != null)
                      return CircleAvatar(
                        radius: _kDefaultSize / 2,
                        backgroundImage: FileImage(profile.image),
                      );
                    return CachedNetworkImage(
                      imageUrl: user.imageUrl,
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
                      onPressed: () async {
                        await profile.pickImage(1);
                        await profile.cropImage();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48.0),
          Consumer<StartupInfoModel>(
            builder: (context, startup, child) {
              if (startup == null) return Container();
              return TextField(
                controller: profile.nameEditor,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: startup.name,
                ),
              );
            },
          ),
          Divider(),
          Consumer<StartupInfoModel>(
            builder: (context, startup, child) {
              if (startup == null) return Container();
              return TextField(
                controller: profile.additionalInfoEditor,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Provider.of<StartupInfoModel>(context).website,
                ),
              );
            },
          ),
          Divider(),
          Consumer<StartupInfoModel>(
            builder: (context, startup, child) {
              if (startup == null) return Container();
              return TextField(
                controller: profile.locationEditor,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Provider.of<StartupInfoModel>(context).location,
                ),
              );
            },
          ),
          Divider(),
          Consumer<StartupInfoModel>(
            builder: (context, startup, child) {
              if (startup == null) return Container();
              return TextField(
                controller: profile.bioEditor,
                minLines: 5,
                maxLines: null,
                maxLength: 140,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Provider.of<StartupInfoModel>(context).description,
                  hintMaxLines: 5,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

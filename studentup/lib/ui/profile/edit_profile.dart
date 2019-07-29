import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: CupertinoColors.destructiveRed,
          ),
          onPressed: () {},
        ),
        title: const Text('Edit Profile'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Done'),
            textColor: CupertinoColors.activeBlue,
            onPressed: () {}, // () => Navigator.of(context).pop(),
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
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundImage: CachedNetworkImageProvider(
                            'https://via.placeholder.com/150',
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
                  TextField(
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ramses Kamanda',
                    ),
                  ),
                  Divider(),
                  TextField(
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Maastricht University',
                    ),
                  ),
                  Divider(),
                  TextField(
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Maastricht, Netherlands',
                    ),
                  ),
                  Divider(),
                  TextField(
                    minLines: 5,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'This is my bio.',
                    ),
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

//University
//Location

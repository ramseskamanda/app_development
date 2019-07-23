import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/custom_sliver_delegate.dart';
import 'package:ui_dev/stadium_button.dart';

class Submission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverDelegate(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                  ),
                ),
                stackChildHeight: 96.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => print('object'),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () => print('object'),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Studentup',
                        style: Theme.of(context).textTheme.title,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Competition Title',
                        softWrap: true,
                        style: Theme.of(context).textTheme.display1,
                      ),
                      const SizedBox(height: 12.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          children: <Widget>[
                            TextField(
                              maxLines: null,
                              minLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Write a reply...',
                                border: InputBorder.none,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ListTile(
                              onTap: () => print('object'),
                              leading: Icon(Icons.attach_file),
                              title: const Text(
                                'Add attachments, if necessary',
                                style: TextStyle(
                                  color: CupertinoColors.inactiveGray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      StadiumButton(
                        text: 'Finished',
                        onPressed: () => print('object'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

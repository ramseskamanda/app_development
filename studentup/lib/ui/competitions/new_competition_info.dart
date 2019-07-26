import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/competitions/file_attachment.dart';

class NewCompetitionInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'New Competition',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    'https://via.placeholder.com/150',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Card(
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name of the competition',
                  hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                  prefix: SizedBox(width: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              child: TextField(
                maxLines: null,
                minLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write a description...',
                  hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                  prefix: SizedBox(width: 16.0),
                ),
              ),
            ),
            for (int i in [0, 1, 2, 3])
              FileAttachment(
                key: ValueKey(i),
                isAddButton: i == 3,
                index: i,
              ),
          ],
        ),
      ),
    );
  }
}

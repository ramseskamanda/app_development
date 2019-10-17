import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_development/models.dart';

class ViewableImage extends StatelessWidget {
  final FileAsset image;
  final BoxFit fit;
  final int overflowNumber;
  final GestureTapCallback onTap;

  const ViewableImage({
    Key key,
    @required this.image,
    @required this.onTap,
    this.fit = BoxFit.cover,
    this.overflowNumber = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image.downloadUrl,
      imageBuilder: (context, cachedImage) {
        return GestureDetector(
          onTap: onTap,
          child: Stack(
            children: <Widget>[
              Hero(
                tag: image.id,
                child: Image(
                  image: cachedImage,
                  fit: fit,
                ),
              ),
              if (overflowNumber > 0)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(),
                    child: Container(
                      color:
                          CupertinoColors.darkBackgroundGray.withOpacity(0.8),
                      child: Center(
                        child: Text(
                          '+ $overflowNumber',
                          style: Theme.of(context).textTheme.display3,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

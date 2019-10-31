import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/widgets/photo_gallery/image_wrapper.dart';
import 'package:ui_dev0/widgets/photo_gallery/photo_gallery.dart';

class ImagePostDisplayer extends StatelessWidget {
  final List<FileAsset> images;

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      TransparentMaterialPageRoute(
        builder: (_) => PhotoGallery(
          selectedIndex: index,
          images: images,
        ),
      ),
    );
  }

  const ImagePostDisplayer({Key key, this.images = const []}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (images == null || images.isEmpty) return Container();
    if (images.length == 1)
      return ViewableImage(
        image: images.first,
        onTap: () => open(context, 0),
      );
    if (images.length == 2)
      return Row(
        children: <Widget>[
          Expanded(
            child: ViewableImage(
              image: images[0],
              fit: BoxFit.fitHeight,
              onTap: () => open(context, 0),
            ),
          ),
          Expanded(
            child: ViewableImage(
              image: images[1],
              fit: BoxFit.fitHeight,
              onTap: () => open(context, 1),
            ),
          ),
        ],
      );
    return Column(
      children: <Widget>[
        ViewableImage(
          image: images[0],
          fit: BoxFit.fitWidth,
          onTap: () => open(context, 0),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ViewableImage(
                image: images[1],
                fit: BoxFit.fitHeight,
                onTap: () => open(context, 1),
              ),
            ),
            Expanded(
              child: ViewableImage(
                image: images[2],
                fit: BoxFit.fitHeight,
                overflowNumber: images.length - 3,
                onTap: () => open(context, 2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/views/communities/common/community_action_menu.dart';

class PhotoGallery extends StatefulWidget {
  final int selectedIndex;
  final List<FileAsset> images;
  PhotoGallery({this.selectedIndex, this.images});

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.selectedIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ExtendedImageSlidePage(
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ExtendedImageGesturePageView.builder(
                itemCount: widget.images.length,
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => ImageTest(
                  image: widget.images[index].downloadUrl,
                  size: size,
                  index: index,
                  isCurrent: index == widget.selectedIndex,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(width: 8.0),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Spacer(),
                    ActionMenuCommunities(
                      reportCallback: () => print(
                          'Report: ${widget.images[_controller.page.truncate()].fileName}'),
                      canDownloadFile: true,
                      startFileDownload: () => print(
                          'Download File: ${widget.images[_controller.page.truncate()].downloadUrl}'),
                    ),
                    const SizedBox(width: 8.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageTest extends StatefulWidget {
  final String image;
  final Size size;
  final int index;
  final bool isCurrent;
  const ImageTest({
    Key key,
    this.image,
    this.size,
    this.index,
    this.isCurrent,
  }) : super(key: key);

  @override
  _ImageTestState createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  Function animationListener;
  List<double> doubleTapScales = <double>[1.0, 2.0];

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    clearGestureDetailsCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Wrap this in a gesture detector and add on tap menu shows
    return ExtendedImage.network(
      widget.image,
      fit: BoxFit.contain,
      enableSlideOutPage: true,
      mode: ExtendedImageMode.gesture,
      heroBuilderForSlidingPage: (Widget result) {
        if (widget.isCurrent) {
          return Hero(
            tag: widget.image + widget.index.toString(),
            child: result,
            flightShuttleBuilder: (BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext) {
              final Hero hero = flightDirection == HeroFlightDirection.pop
                  ? fromHeroContext.widget
                  : toHeroContext.widget;
              return hero.child;
            },
          );
        } else {
          return result;
        }
      },
      initGestureConfigHandler: (state) {
        double initialScale = 1.0;

        if (state.extendedImageInfo != null &&
            state.extendedImageInfo.image != null) {
          initialScale = initScale(
              size: widget.size,
              initialScale: initialScale,
              imageSize: Size(state.extendedImageInfo.image.width.toDouble(),
                  state.extendedImageInfo.image.height.toDouble()));
        }
        return GestureConfig(
          inPageView: true,
          initialScale: initialScale,
          maxScale: max(initialScale, 5.0),
          animationMaxScale: max(initialScale, 5.0),
          //you can cache gesture state even though page view page change.
          //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
          cacheGesture: false,
        );
      },
      onDoubleTap: (ExtendedImageGestureState state) {
        ///you can use define pointerDownPosition as you can,
        ///default value is double tap pointer down postion.
        var pointerDownPosition = state.pointerDownPosition;
        double begin = state.gestureDetails.totalScale;
        double end;

        //remove old
        _animation?.removeListener(animationListener);

        //stop pre
        _animationController.stop();

        //reset to use
        _animationController.reset();

        if (begin == doubleTapScales[0]) {
          end = doubleTapScales[1];
        } else {
          end = doubleTapScales[0];
        }

        animationListener = () {
          //print(_animation.value);
          state.handleDoubleTap(
              scale: _animation.value, doubleTapPosition: pointerDownPosition);
        };
        _animation =
            _animationController.drive(Tween<double>(begin: begin, end: end));

        _animation.addListener(animationListener);

        _animationController.forward();
      },
    );
  }
}

double initScale({Size imageSize, Size size, double initialScale}) {
  var n1 = imageSize.height / imageSize.width;
  var n2 = size.height / size.width;
  if (n1 > n2) {
    final FittedSizes fittedSizes =
        applyBoxFit(BoxFit.contain, imageSize, size);
    //final Size sourceSize = fittedSizes.source;
    Size destinationSize = fittedSizes.destination;
    return size.width / destinationSize.width;
  } else if (n1 / n2 < 1 / 4) {
    final FittedSizes fittedSizes =
        applyBoxFit(BoxFit.contain, imageSize, size);
    //final Size sourceSize = fittedSizes.source;
    Size destinationSize = fittedSizes.destination;
    return size.height / destinationSize.height;
  }

  return initialScale;
}

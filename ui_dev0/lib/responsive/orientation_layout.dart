import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
  final Widget Function(BuildContext) landscape;
  final Widget Function(BuildContext) portrait;

  const OrientationLayout({Key key, this.landscape, this.portrait})
      : assert(
          portrait != null,
          'OrientationLayout Widget needs at least a portrait mode.',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Orientation orientation = MediaQuery.of(context).orientation;
        if (orientation == Orientation.landscape && landscape != null)
          return landscape(context);
        return portrait(context);
      },
    );
  }
}

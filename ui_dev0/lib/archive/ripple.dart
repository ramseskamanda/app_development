import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class RippleScaffold extends StatefulWidget {
  final Widget newRoute;
  final Widget body;
  final PreferredSizeWidget appBar;

  const RippleScaffold({
    Key key,
    @required this.newRoute,
    this.body = const Scaffold(),
    this.appBar,
  }) : super(key: key);
  @override
  _RippleScaffoldState createState() => _RippleScaffoldState();
}

class _RippleScaffoldState extends State<RippleScaffold> {
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  void _onTap() {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: widget.newRoute))
        .then((_) => setState(() => rect = null));
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: widget.appBar,
          body: widget.body,
          floatingActionButton: RectGetter(
            key: rectGetterKey,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: _onTap,
            ),
          ),
        ),
        _ripple(),
      ],
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

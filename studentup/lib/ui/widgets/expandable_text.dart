import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 500),
          child: new ConstrainedBox(
              constraints: isExpanded
                  ? new BoxConstraints()
                  : new BoxConstraints(maxHeight: 50.0),
              child: new Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      isExpanded
          ? new ConstrainedBox(constraints: new BoxConstraints())
          : new FlatButton(
              child: const Text('...'),
              onPressed: () => setState(() => isExpanded = true))
    ]);
  }
}

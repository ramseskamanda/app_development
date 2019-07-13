import 'package:flutter/material.dart';

class LimitedText extends StatefulWidget {
  LimitedText({
    Key key,
    this.text,
    this.height,
    this.width = double.infinity,
  }) : super(key: key);

  final String text;
  final double height;
  final double width;

  @override
  _LimitedTextState createState() => _LimitedTextState();
}

class _LimitedTextState extends State<LimitedText> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.height,
        maxWidth: widget.width,
      ),
      child: Text(
        widget.text,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

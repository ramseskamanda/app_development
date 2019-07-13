import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Section extends StatefulWidget {
  final Text title;
  final void Function() onMoreCallback;
  final Widget child;

  Section({
    Key key,
    @required this.title,
    @required this.onMoreCallback,
    @required this.child,
  }) : super(key: key);

  @override
  _SectionState createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.title,
              FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashColor: Colors.transparent,
                onPressed: widget.onMoreCallback,
                child: Text(
                  'See all',
                  style: widget.title.style?.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w400,
                      ) ??
                      TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        widget.child,
      ],
    );
  }
}

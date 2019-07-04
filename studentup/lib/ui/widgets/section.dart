import 'package:flutter/material.dart';

class Section extends StatelessWidget {
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
              title,
              GestureDetector(
                onTap: onMoreCallback,
                child: Text(
                  'See all',
                  style: title.style?.copyWith(
                        color: Theme.of(context).accentColor,
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
        child,
      ],
    );
  }
}

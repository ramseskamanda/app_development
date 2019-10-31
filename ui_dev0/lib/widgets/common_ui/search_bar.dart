import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String title;
  final Future<void> Function() callback;
  final double widthFactor;

  const SearchBar({
    Key key,
    @required this.title,
    @required this.callback,
    this.widthFactor = 0.86,
  })  : assert(widthFactor > 0.0 && widthFactor <= 1.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Center(
        child: RaisedButton(
          color: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () async => await callback(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 4.0),
              Opacity(
                opacity: 0.7,
                child: const Icon(CupertinoIcons.search),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Opacity(
                  opacity: 0.7,
                  child: Text(title),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  print('Settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

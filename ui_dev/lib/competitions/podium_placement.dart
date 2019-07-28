import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodiumPlacementScreen extends StatefulWidget {
  @override
  _PodiumPlacementScreenState createState() => _PodiumPlacementScreenState();
}

class _PodiumPlacementScreenState extends State<PodiumPlacementScreen> {
  List<String> _podium = List<String>(3);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 32.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Winners',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 24.0),
            for (int i = 0; i < 3; i++) PodiumPlacement(name: _podium[i]),
            const SizedBox(height: 32.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Participants',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 24.0),
            UserPlacementTile(),
          ],
        ),
      ),
    );
  }
}

class PodiumPlacement extends StatelessWidget {
  final String name;
  final void Function() onDelete;

  const PodiumPlacement({Key key, this.name, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height:
            name != null ? MediaQuery.of(context).size.height * 0.28 : 100.0,
        color: name != null ? Colors.red : Colors.blue,
      ),
    );
  }
}

class UserPlacementTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: CupertinoColors.lightBackgroundGray,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ramses Kamanda',
                  style: Theme.of(context).textTheme.title,
                ),
                FlatButton(
                  padding: const EdgeInsets.all(0),
                  child: Text('#1'),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 1.0,
                    ),
                  ),
                  onPressed: () {},
                ),
                FlatButton(
                  padding: const EdgeInsets.all(0),
                  child: Text('#1'),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 1.0,
                    ),
                  ),
                  onPressed: () {},
                ),
                FlatButton(
                  padding: const EdgeInsets.all(0),
                  child: Text('#1'),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 1.0,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:reorderables/reorderables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/theme.dart';

class PodiumPlacementScreen extends StatefulWidget {
  @override
  _PodiumPlacementScreenState createState() => _PodiumPlacementScreenState();
}

class _PodiumPlacementScreenState extends State<PodiumPlacementScreen>
    with AutomaticKeepAliveClientMixin {
  List<PodiumPlacement> _podium;

  void _selectPlacementTile() {
    int index = _podium.indexWhere((PodiumPlacement w) => w.name == null);
    if (index != -1) {
      _podium.setRange(
        index,
        index + 1,
        [
          PodiumPlacement(
            key: ValueKey(index),
            name: 'name',
            placement: index,
          ),
        ],
      );
      setState(() {});
    }
  }

  void _addPodiumSpot() {
    setState(() {
      _podium.add(
        PodiumPlacement(
          key: ValueKey(_podium.length),
          name: null,
          placement: _podium.length,
        ),
      );
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      PodiumPlacement row = _podium.removeAt(oldIndex);
      _podium.insert(newIndex, row);
    });
  }

  @override
  void initState() {
    super.initState();
    _podium = Iterable.generate(1)
        .map((i) => PodiumPlacement(
              key: ValueKey(i),
              name: null,
              placement: i,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            ReorderableColumn(
              scrollController: ScrollController(),
              onReorder: _onReorder,
              children: _podium,
            ),
            if (_podium.length < 5)
              PodiumPlaceIncrementer(
                onAddPodiumSpot: _addPodiumSpot,
              ),
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
            UserPlacementTile(
              onSelect: _selectPlacementTile,
            ),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PodiumPlaceIncrementer extends StatelessWidget {
  final void Function() onAddPodiumSpot;

  const PodiumPlaceIncrementer({Key key, @required this.onAddPodiumSpot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListTile(
        leading: const Icon(Icons.add),
        title: const Text('Add more winners...'),
        onTap: onAddPodiumSpot,
      ),
    );
  }
}

class PodiumPlacement extends StatelessWidget {
  final String name;
  final void Function() onDelete;
  final int placement;

  const PodiumPlacement(
      {Key key, this.name, this.onDelete, @required this.placement})
      : assert(placement != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height:
            name != null ? MediaQuery.of(context).size.height * 0.28 : 100.0,
        width: MediaQuery.of(context).size.width * 0.8,
        color: name != null ? Colors.red : CupertinoColors.lightBackgroundGray,
        child: Center(
          child: Text('${placement + 1}'),
        ),
      ),
    );
  }
}

class UserPlacementTile extends StatelessWidget {
  final void Function() onSelect;

  const UserPlacementTile({Key key, @required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: getSimpleBoxShadow(color: Theme.of(context).accentColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://via.placeholder.com/150',
                  ),
                ),
                title: const Text('Ramses Kamanda'),
                trailing: IconButton(
                  icon: Icon(CupertinoIcons.heart),
                  onPressed: () => print('object'),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'Market research',
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'This project is about market research and all that stuff and this is a description of it.',
                  style: Theme.of(context).textTheme.subhead,
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: const Text('Read more'),
                    onPressed: () => print('object'),
                  ),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const Text('Select'),
                    onPressed: onSelect,
                  ),
                  const SizedBox(width: 24.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

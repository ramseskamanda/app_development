import 'package:cached_network_image/cached_network_image.dart';
import 'package:clique/models/event_model.dart';
import 'package:clique/ui/home/going_button.dart';
import 'package:flutter/material.dart';

const double _kEventTileHeight = 300.0;

class FakeEventTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kEventTileHeight,
      child: Card(),
    );
  }
}

class EventTile extends StatelessWidget {
  final Event event;
  final bool isAttending;
  EventTile({Key key, @required this.event, @required this.isAttending})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kEventTileHeight,
      child: Card(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: event.media,
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                  placeholder: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(flex: 1),
                          Text('${event.name}'),
                          Text('${event.time.toDate()}'),
                          Spacer(flex: 4),
                        ],
                      ),
                      GoingButton(
                        event: event,
                        isAttending: isAttending,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

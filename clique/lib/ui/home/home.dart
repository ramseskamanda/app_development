import 'package:clique/models/event_model.dart';
import 'package:clique/models/user_profile.dart';
import 'package:clique/services/events_service.dart';
import 'package:clique/services/location_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/ui/home/event_tile.dart';
import 'package:clique/ui/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PaddedFAB(
        icon: Icons.bug_report,
        onPressed: locator<GeoLocationService>().debugGeofencesAndSchedule,
      ),
      body: StreamBuilder<List<Event>>(
        stream: locator<EventsService>().allEvents,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return EventList.waiting();
          else {
            if (snapshot.hasData)
              return EventList(events: snapshot.data);
            else if (snapshot.hasError)
              return EventList.error(error: snapshot.error);
          }
        },
      ),
    );
  }
}

class EventList extends StatelessWidget {
  final List<Event> events;
  final Object error;
  EventList({Key key, @required this.events, this.error}) : super(key: key);
  EventList.waiting()
      : events = null,
        error = null;
  EventList.error({this.error}) : events = null;

  Widget _buildSliver(BuildContext context) {
    if (error != null) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(error.toString()),
        ),
      );
    } else {
      List<DocumentReference> _userEvents =
          Provider.of<UserProfile>(context).userEvents;

      return SliverList(
        delegate: SliverChildListDelegate(
          events == null
              ? Iterable<int>.generate(10)
                  .map((int i) => FakeEventTile())
                  .toList()
              : events.map((Event event) {
                  return EventTile(
                    event: event,
                    isAttending: _userEvents.contains(event.reference),
                  );
                }).toList(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: (error != null || events == null)
          ? NeverScrollableScrollPhysics()
          : AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          transitionBetweenRoutes: false,
          leading: ProfileDrawerButton(),
          largeTitle: const Text('Events'),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.11,
          ),
          sliver: _buildSliver(context),
        ),
      ],
    );
  }
}

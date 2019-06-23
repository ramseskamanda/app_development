import 'dart:async';

import 'package:clique/models/event_model.dart';
import 'package:clique/models/user_event_attending_model.dart';
import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/messaging_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show PlatformException;

class EventsService {
  Firestore _firestore;

  EventsService() {
    _firestore = Firestore.instance;
  }

  Stream<List<Event>> get allEvents =>
      _firestore.collection('events').snapshots().transform(_eventTransformer);
  CollectionReference get userEventAttending =>
      _firestore.collection('user_event_attending');

  Future<QuerySnapshot> getEventsUserIsAttending(String uid) async {
    return userEventAttending.where('user', isEqualTo: uid).getDocuments();
  }

  StreamTransformer _eventTransformer =
      StreamTransformer<QuerySnapshot, List<Event>>.fromHandlers(
    handleData: (QuerySnapshot snapshot, EventSink<List<Event>> sink) {
      if (snapshot == null || snapshot.documents.length == 0)
        return;
      else {
        try {
          List<Event> _events = <Event>[];
          snapshot.documents.forEach((DocumentSnapshot doc) {
            if (!doc.documentID.contains('statistics'))
              _events.add(Event.fromDoc(doc));
          });
          sink.add(_events);
        } catch (e) {
          sink.addError(e);
        }
      }
    },
    handleError: (Object error, _, EventSink<List<Event>> sink) =>
        sink.addError(error),
  );

  Future<String> userAttends(Event event, bool alreadyAttending) async {
    try {
      String uid = await locator<AuthService>().currentUser.then((u) => u.uid);
      if (!alreadyAttending) {
        UserEventAttendingModel _info = UserEventAttendingModel()
          ..userID = uid
          ..event = event
          ..timeStamp = DateTime.now()
          ..pointRewards = 100
          ..deviceToken = await locator<MessagingService>().deviceToken;
        await userEventAttending.add(_info.doc);
      } else {
        QuerySnapshot _query = await userEventAttending
            .where('user', isEqualTo: uid)
            .where('event', isEqualTo: event.reference)
            .getDocuments();
        _query.documents.forEach(
          (DocumentSnapshot doc) => doc.reference.delete(),
        );
      }
      return null; //no error
    } on PlatformException catch (e) {
      return e.message;
    } catch (ue) {
      print(ue);
      return 'Unknown Error';
    }
  }
}

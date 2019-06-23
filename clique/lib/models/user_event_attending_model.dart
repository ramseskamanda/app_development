import 'dart:core';

import 'package:clique/models/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserEventAttendingModel {
  Map<String, dynamic> _info;

  UserEventAttendingModel() : _info = <String, dynamic>{};

  set userID(String uid) => _info['user'] = uid ?? '';
  set event(Event event) => _info['event'] = event.reference;
  set pointRewards(int points) => _info['points_reward'] = points ?? 0;
  set timeStamp(DateTime now) => _info['timestamp'] = Timestamp.fromDate(now);
  set deviceToken(String token) => _info['token'] = token ?? '';

  Map<String, dynamic> get doc {
    assert(_info['user'] != null);
    assert(_info['event'] != null);
    assert(_info['points_reward'] != null);
    assert(_info['timestamp'] != null);
    assert(_info['token'] != null);

    return _info;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FriendshipModel {
  Map<String, dynamic> _info;

  FriendshipModel() : _info = <String, dynamic>{};

  set from(String code) => _info['user_a'] = code ?? '';
  set to(String code) => _info['user_b'] = code ?? '';
  set timestamp(Timestamp time) => _info['timestamp'] = time ?? '';

  Map<String, dynamic> get info {
    assert(_info['user_a'] != null);
    assert(_info['user_b'] != null);
    assert(_info['user_a'] != null);
    _info['accpeted'] = false;

    return _info;
  }
}

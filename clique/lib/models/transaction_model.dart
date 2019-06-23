import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  Map<String, dynamic> _data;

  TransactionModel() : _data = <String, dynamic>{};

  set amount(int amount) => _data['amount'] = amount ?? 0;
  set business(String business) => _data['business'] = business ?? '';
  set reward(DocumentReference object) => _data['object'] = object;
  set timestamp(DateTime timestamp) =>
      _data['timestamp'] = Timestamp.fromDate(timestamp) ?? Timestamp.now();
  set userId(String userId) => _data['user_id'] = userId ?? '';
  set deviceToken(String token) => _data['device_token'] = token ?? '';

  Map<String, dynamic> get doc {
    assert(_data['amount'] != null);
    assert(_data['business'] != null);
    assert(_data['object'] != null);
    assert(_data['timestamp'] != null);
    assert(_data['user_id'] != null);
    assert(_data['device_token'] != null);
    _data['status'] = 'pending';
    return _data;
  }
}

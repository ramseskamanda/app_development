import 'package:cloud_firestore/cloud_firestore.dart';

class Reward {
  String _business;
  String _category;
  num _discount;
  String _media;
  Timestamp _expiryDate;
  String _name;
  num _numLeft;
  num _originalPrice;
  num _pointsValue;
  String _type;
  DocumentReference _reference;

  String get business => _business ?? '';
  String get category => _category ?? '';
  num get discount => _discount ?? 0;
  String get media => _media ?? '';
  DateTime get expiryDate => _expiryDate?.toDate() ?? DateTime.now();
  String get name => _name ?? '';
  num get numLeft => _numLeft ?? 0;
  num get originalPrice => _originalPrice ?? 0;
  num get pointsValue => _pointsValue ?? 0;
  String get type => _type ?? '';
  DocumentReference get reference => _reference;

  Reward.fromDoc(DocumentSnapshot doc) {
    _reference = doc.reference;
    _business = doc.data['business'];
    _category = doc.data['category'];
    _discount = doc.data['discount'];
    _media = doc.data['media'];
    _expiryDate = doc.data['expiry_date'];
    _name = doc.data['name'];
    _numLeft = doc.data['num_left'];
    _originalPrice = doc.data['original_price'];
    _pointsValue = doc.data['token_price']; //points_value
    _type = doc.data['type'];
  }
}

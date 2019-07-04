import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_model.dart';

class BadgeModel extends BaseModel {
  final int _placement;
  final String _badgePhoto;

  BadgeModel({int ranking})
      : _placement = ranking,
        _badgePhoto = 'https://via.placeholder.com/150',
        super.fromDoc(null);

  BadgeModel.fromDoc(DocumentSnapshot doc, int p)
      : _placement = null,
        _badgePhoto = null,
        super.fromDoc(doc);

  int get placement => _placement;
  String get photoUrl => _badgePhoto;
}

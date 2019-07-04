import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_model.dart';

class UserModel extends BaseModel {
  final Map<String, dynamic> _map;
  UserModel.fromDoc(DocumentSnapshot doc)
      : _map = doc.data,
        super.fromDoc(doc);

  Map<String, dynamic> get map => _map;
}

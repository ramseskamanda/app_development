import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';

class PrizeModel extends BaseModel {
  Timestamp _batch;
  String _mediaRef;
  String _name;
  bool _sponsored;
  int _ranking;
  String _description;

  DateTime get batch => _batch?.toDate() ?? DateTime.now();
  String get media => _mediaRef ?? '500 Error';
  String get name => _name ?? '500 Error';
  bool get sponsored => _sponsored ?? false;
  int get ranking => _ranking ?? -1;
  String get description => _description ?? '500 Error';

  PrizeModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _batch = json['batch'];
    _mediaRef = json['media_ref'];
    _name = json['name'];
    _sponsored = json['sponsored'];
    _ranking = json['ranking'];
    _description = json['description'];
  }
}

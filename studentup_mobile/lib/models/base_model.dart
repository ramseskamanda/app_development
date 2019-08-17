import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class BaseModel {
  final String _docId;

  BaseModel() : _docId = '';

  @mustCallSuper
  BaseModel.fromDoc(DocumentSnapshot doc) : _docId = doc?.documentID ?? '';

  String get docId => _docId;
}

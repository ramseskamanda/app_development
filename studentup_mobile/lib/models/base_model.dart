import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class BaseModel {
  final String _docId;

  BaseModel() : _docId = '';

  @mustCallSuper
  BaseModel.fromDoc(DocumentSnapshot doc) : _docId = doc?.documentID ?? '';

  @mustCallSuper
  BaseModel.fromIndex(AlgoliaObjectSnapshot snapshot)
      : _docId = snapshot?.objectID ?? '';

  String get docId => _docId;
}

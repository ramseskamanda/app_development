import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {
  final String _documentId;
  BaseModel.fromDoc(DocumentSnapshot doc)
      : _documentId = null; //doc.documentID;

  String get documentId => _documentId ?? '';
}

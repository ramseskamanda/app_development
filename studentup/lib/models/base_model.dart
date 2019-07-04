import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {
  final String _documentId;
  //TODO: remove comment after testing is done
  BaseModel.fromDoc(DocumentSnapshot doc)
      : _documentId = null; //doc.documentID;

  String get documentId => _documentId ?? '';
}

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {
  BaseModel fromDoc(DocumentSnapshot doc);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studentup/models/user_model.dart';

import 'base_notifier.dart';

class UserProfileNotifier extends BaseNotifier {
  UserModel _model;
  FirebaseUser _user;
  DocumentReference _query;

  String get userId => _user?.uid ?? 'fetching uid...';
  String get name => _user?.displayName ?? 'fetching user info...';
  String get email => _user?.email ?? 'no email found...';
  String get photoUrl => _user?.photoUrl ?? '';
  Map<String, dynamic> get userModel => _model?.map;

  Future<void> initialize() async {
    isLoading = true;
    _user = await FirebaseAuth.instance.currentUser();
    _query = Firestore.instance.collection('users').document(_user.uid);
    _model = UserModel.fromDoc(await _query.get());
    isLoading = false;
  }

  Future<void> refresh() async {
    isLoading = true;
    await _user.reload();
    _model = UserModel.fromDoc(await _query.get());
    isLoading = false;
  }
}

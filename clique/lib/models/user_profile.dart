import 'package:clique/models/user_information_model.dart';
import 'package:clique/models/wallet_model.dart';
import 'package:clique/util/env.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class UserProfile {
  FirebaseUser _user;
  List<DocumentReference> _eventsAttending;
  WalletModel _wallet;
  UserInformation _info;

  UserProfile({
    @required FirebaseUser user,
    List<DocumentReference> eventsAttending,
    WalletModel wallet,
    UserInformation info,
  })  : _user = user,
        _eventsAttending = eventsAttending,
        _wallet = wallet,
        _info = info;

  String get uid => _user.uid;
  String get name => _user?.displayName ?? 'No Name';
  String get email => _user?.email ?? 'No Email';
  String get photoUrl => _user?.photoUrl ?? Environment.defaultPhotoUrl;
  String get bio => _info?.bio ?? Environment.defaultBio;
  int get accountBalance => _wallet?.balance ?? 0;
  String get username => _info?.username ?? name;
  List<String> get userPastEvents => _info?.eventsAttended ?? <String>[];
  List<DocumentReference> get userEvents =>
      _eventsAttending ?? <DocumentReference>[];
}

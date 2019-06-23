import 'package:clique/models/user_information_model.dart';
import 'package:clique/models/user_profile.dart';
import 'package:clique/models/wallet_model.dart';
import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/events_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

class UserService {
  Firestore _firestore;
  UserProfile _currentUser;

  UserService() {
    _firestore = Firestore.instance;
  }

  Future<UserProfile> get currentUser async {
    if (_currentUser == null) {
      FirebaseUser u = await locator<AuthService>().currentUser;
      _currentUser = await createUserProfile(u);
      return _currentUser;
    }
    return _currentUser;
  }

  CollectionReference get userCollection => _firestore.collection('users');
  CollectionReference get walletCollection => _firestore.collection('wallets');

  Future<UserProfile> createUserProfile(FirebaseUser u) async {
    try {
      //Query for wallet information doc
      DocumentSnapshot wallet =
          await walletCollection.document(" " + u.uid).get();
      print(wallet.exists);
      WalletModel _wallet = WalletModel.fromDoc(wallet.data);
      //Query for user information doc
      DocumentSnapshot _user = await userCollection.document(u.uid).get();
      UserInformation _info = UserInformation.fromDoc(_user.data);
      //Query for events user has attended
      QuerySnapshot _events =
          await locator<EventsService>().getEventsUserIsAttending(u.uid);
      List<DocumentReference> _eventsAttending = _events.documents
          .map((DocumentSnapshot doc) => doc.data['event'] as DocumentReference)
          .toList();
      _currentUser = UserProfile(
        user: u,
        info: _info,
        wallet: _wallet,
        eventsAttending: _eventsAttending,
      );
      return _currentUser;
    } on PlatformException catch (e) {
      print('[UserProfile -> _initializeUser] error: ${e.code}');
      return null;
    }
  }
}

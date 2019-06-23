import 'dart:async';

import 'package:clique/models/reward_model.dart';
import 'package:clique/models/transaction_model.dart';
import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/messaging_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class MarketService {
  Firestore _firestore;

  MarketService() {
    _firestore = Firestore.instance;
  }

  Stream<List<Reward>> get allRewards => _firestore
      .collection("rewards")
      .snapshots()
      .transform(_rewardTransformer);
  CollectionReference get transactions => _firestore.collection('transactions');

  StreamTransformer _rewardTransformer =
      StreamTransformer<QuerySnapshot, List<Reward>>.fromHandlers(
    handleData: (QuerySnapshot snapshot, EventSink<List<Reward>> sink) {
      if (snapshot == null || snapshot.documents.length == 0)
        return;
      else {
        try {
          List<Reward> _rewards = <Reward>[];
          snapshot.documents.forEach((DocumentSnapshot doc) {
            if (!doc.documentID.contains('statistics'))
              _rewards.add(Reward.fromDoc(doc));
          });
          sink.add(_rewards);
        } catch (e) {
          sink.addError(e);
        }
      }
    },
    handleError: (Object error, _, EventSink<List<Reward>> sink) =>
        sink.addError(error),
  );

  Future<String> makeTransaction(Reward reward) async {
    try {
      String uid = await locator<AuthService>().currentUser.then((u) => u.uid);
      TransactionModel _info = TransactionModel()
        ..business = reward.business
        ..userId = uid
        ..reward = reward.reference
        ..timestamp = DateTime.now()
        ..amount = 100
        ..deviceToken = await locator<MessagingService>().deviceToken;
      _preprocessTransaction(_info);
      await transactions.add(_info.doc);
      return null; //no error
    } on PlatformException catch (e) {
      return e.message;
    } catch (ue) {
      print(ue);
      return 'Unknown Error';
    }
  }

  void _preprocessTransaction(TransactionModel transaction) {
    if (transaction == null) throw 'Transaction is null';
  }
}

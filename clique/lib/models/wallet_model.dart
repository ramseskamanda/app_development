import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  int _balance;
  CollectionReference _rewardsOwned;

  WalletModel.fromDoc(Map<String, dynamic> data) {
    if (data == null) return;
    _balance = data['balance'] ?? -404;
    _rewardsOwned = data['rewards_owned'];
  }

  int get balance => _balance;
  CollectionReference get rewardsOwned => _rewardsOwned;
}

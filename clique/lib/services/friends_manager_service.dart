import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:clique/models/friendship_model.dart';
import 'package:clique/models/user_information_model.dart';
import 'package:clique/services/authentication_service.dart';
import 'package:clique/services/service_locator.dart';
import 'package:clique/util/error_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FriendsManagerService {
  Firestore _firestore;

  FriendsManagerService() {
    _firestore = Firestore.instance;
  }

  CollectionReference get friendsCollection => _firestore.collection('friends');

  Future _addFriend(String code) async {
    try {
      String uid = await locator<AuthService>().currentUser.then((u) => u.uid);
      FriendshipModel _friendship = FriendshipModel()
        ..from = uid
        ..to = code
        ..timestamp = Timestamp.now();
      await friendsCollection.add(_friendship.info);
      String token =
          await _firestore.collection('users').document(code).get().then(
        (snapshot) {
          UserInformation _info = UserInformation.fromDoc(snapshot.data);
          return _info.deviceToken;
        },
      );
      //TODO: send a notification to the above token
      print(token);
    } on PlatformException catch (e) {
      throw e;
    } catch (ue) {
      throw ue;
    }
  }

  _verifyCode(String barcode) {
    if (barcode?.isEmpty ?? true) throw "Erroneous barcode provided.";
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      _verifyCode(barcode);
      await _addFriend(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        return ErrorMessage(
          code: e.code,
          details: 'User did not grant permission to use the camera.',
          importance: ErrorImportance.fatal,
        );
      } else {
        return ErrorMessage(
          code: e.code,
          details: e.details,
          stack: 'QRScannerService.scan',
          importance: ErrorImportance.fatal,
        );
      }
    } on FormatException {
      return ErrorMessage(
        code: 'Cancel',
        details: 'User returned before scanning a code.',
        importance: ErrorImportance.none,
      );
    } catch (e) {
      return ErrorMessage(
        code: e.toString(),
        stack: 'QRScannerService.scan',
        importance: ErrorImportance.fatal,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class ThinkTankNotifier extends NetworkNotifier {
  final ThinkTanksModel model;
  FirestoreReader _firestoreReader;
  FirestoreWriter _firestoreWriter;
  TextEditingController _newComment;

  ThinkTankNotifier(this.model) {
    _firestoreReader = FirestoreReader();
    _firestoreWriter = FirestoreWriter();
    _newComment = TextEditingController();
  }

  Stream<List<Comments>> get comments =>
      _firestoreReader.fetchComments(model.comments);
  TextEditingController get newComment => _newComment;

  @override
  Future fetchData() async {}

  @override
  Future onRefresh() async {}

  Future postComment() async {
    if (_newComment.text.isEmpty) return;
    isLoading = true;
    Comments comment = Comments(
      content: _newComment.text,
      createdAt: DateTime.now(),
      userId: Locator.of<AuthService>().currentUser.uid,
    );
    try {
      _firestoreWriter.postComment(model: comment, collection: model.comments);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
    isLoading = false;
  }

  Future upvoteComment({bool cancelVote, @required String id}) async {
    try {
      if (cancelVote)
        await _firestoreWriter.removeVoter(
          upvote: true,
          collection: model.comments,
          docId: id,
          uid: Locator.of<AuthService>().currentUser.uid,
        );
      else
        await _firestoreWriter.addVoter(
          upvote: true,
          collection: model.comments,
          docId: id,
          uid: Locator.of<AuthService>().currentUser.uid,
        );
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
  }

  Future downvoteComment({bool cancelVote, @required String id}) async {
    try {
      if (cancelVote)
        await _firestoreWriter.removeVoter(
          upvote: false,
          collection: model.comments,
          docId: id,
          uid: Locator.of<AuthService>().currentUser.uid,
        );
      else
        await _firestoreWriter.addVoter(
          upvote: false,
          collection: model.comments,
          docId: id,
          uid: Locator.of<AuthService>().currentUser.uid,
        );
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
    }
  }
}

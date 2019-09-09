import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class ThinkTankNotifier extends NetworkIO {
  final ThinkTanksModel model;
  TextEditingController _newComment;
  Stream<List<Comments>> _comments;

  ThinkTankNotifier(this.model) {
    _newComment = TextEditingController();
    fetchData();
  }

  Stream<List<Comments>> get comments => _comments;
  TextEditingController get newComment => _newComment;

  @override
  Future fetchData() async {
    isReading = true;
    _comments = reader.fetchComments(model.comments.path);
    isReading = false;
  }

  Future _postComment() async {
    if (_newComment.text.isEmpty) return;
    isWriting = true;
    Comments comment = Comments(
      content: _newComment.text,
      createdAt: DateTime.now(),
      userId: Locator.of<AuthService>().currentUser.uid,
    );
    writer.postComment(model: comment, collectionPath: model.comments.path);
    isWriting = false;
  }

  Future _upvoteComment(Upvote vote) async {
    if (vote.cancelVote)
      await writer.removeVoter(
        upvote: true,
        collectionPath: model.comments.path,
        docId: vote.docId,
        uid: Locator.of<AuthService>().currentUser.uid,
      );
    else
      await writer.addVoter(
        upvote: true,
        collectionPath: model.comments.path,
        docId: vote.docId,
        uid: Locator.of<AuthService>().currentUser.uid,
      );
  }

  Future _downvoteComment(Downvote vote) async {
    if (vote.cancelVote)
      await writer.removeVoter(
        upvote: false,
        collectionPath: model.comments.path,
        docId: vote.docId,
        uid: Locator.of<AuthService>().currentUser.uid,
      );
    else
      await writer.addVoter(
        upvote: false,
        collectionPath: model.comments.path,
        docId: vote.docId,
        uid: Locator.of<AuthService>().currentUser.uid,
      );
  }

  @override
  Future<bool> sendData([data]) async {
    try {
      switch (data.runtimeType) {
        case Null:
          _postComment();
          break;
        case Upvote:
          _upvoteComment(data);
          break;
        case Downvote:
          _downvoteComment(data);
          break;
        default:
      }
    } catch (e) {
      print(e);
      writeError = NetworkError(message: e.toString());
      return false;
    }
    return true;
  }
}

class Upvote {
  final String docId;
  final bool cancelVote;

  Upvote(this.docId, this.cancelVote);
}

class Downvote {
  final String docId;
  final bool cancelVote;

  Downvote(this.docId, this.cancelVote);
}

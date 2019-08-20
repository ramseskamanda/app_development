import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';

class ThinkTanksModel extends BaseModel {
  CollectionReference _comments;
  String _askerId;
  String _askerImage;
  int _commentCount;
  int _likesCount;
  int _interactionCount;
  Timestamp _lastActivity;
  String _premise;
  String _title;
  List<Comments> _recentComments;

  ThinkTanksModel({
    CollectionReference comments,
    String askerId,
    String askerImage,
    int commentCount,
    int likesCount,
    int interactionCount,
    DateTime lastActivity,
    String premise,
    String title,
    List<Comments> recentComments,
  }) {
    _comments = comments;
    _askerId = askerId;
    _askerImage = askerImage;
    _commentCount = commentCount;
    _likesCount = likesCount;
    _interactionCount = interactionCount;
    _lastActivity = Timestamp.fromDate(lastActivity);
    _premise = premise;
    _title = title;
    _recentComments = recentComments;
  }

  CollectionReference get comments => _comments;
  String get askerId => _askerId;
  String get askerImage => _askerImage;
  int get commentCount => _commentCount;
  int get likesCount => _likesCount;
  int get interactionCount => _interactionCount;
  DateTime get lastActivity => _lastActivity?.toDate() ?? DateTime.now();
  String get premise => _premise;
  String get title => _title;
  List<Comments> get recentComments => _recentComments;

  ThinkTanksModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _comments = json['comments'];
    _askerId = json['asker_id'];
    _askerImage = json['asker_image'];
    _commentCount = json['commentCount'];
    _likesCount = json['likesCount'];
    _interactionCount = json['interactionCount'];
    _lastActivity = json['lastActivity'];
    _premise = json['premise'];
    _title = json['title'];
    if (json['recentComments'] != null) {
      _recentComments = new List<Comments>();
      json['recentComments'].forEach((v) {
        _recentComments.add(new Comments.fromDoc(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = _comments;
    data['asker_id'] = _askerId;
    data['asker_image'] = _askerImage;
    data['commentCount'] = 0;
    data['likesCount'] = 0;
    data['interactionCount'] = 0;
    data['lastActivity'] = _lastActivity;
    data['premise'] = _premise;
    data['title'] = _title;
    data['recentComments'] = [];
    return data;
  }
}

class Comments {
  String _content;
  Timestamp _createdAt;
  int _downvotes;
  int _upvotes;

  Comments({
    String content,
    DateTime createdAt,
    int downvotes,
    int upvotes,
  }) {
    _content = content;
    _createdAt = Timestamp.fromDate(createdAt);
    _downvotes = downvotes;
    _upvotes = upvotes;
  }

  String get content => _content;
  DateTime get createdAt => _createdAt?.toDate() ?? DateTime.now();
  int get downvotes => _downvotes;
  int get upvotes => _upvotes;

  Comments.fromDoc(Map<String, dynamic> json) {
    _content = json['content'];
    _createdAt = json['created_at'];
    _downvotes = json['downvotes'];
    _upvotes = json['upvotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = _content;
    data['created_at'] = _createdAt;
    data['downvotes'] = _downvotes;
    data['upvotes'] = _upvotes;
    return data;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/base_model.dart';
import 'package:studentup_mobile/util/util.dart';

class ThinkTanksModel extends BaseModel {
  CollectionReference _comments;
  String _askerId;
  String _askerImage;
  int _commentCount;
  Timestamp _lastActivity;
  String _premise;
  String _title;

  ThinkTanksModel({
    CollectionReference comments,
    String askerId,
    String askerImage,
    int commentCount,
    DateTime lastActivity,
    String premise,
    String title,
  }) {
    _comments = comments;
    _askerId = askerId;
    _askerImage = askerImage;
    _commentCount = commentCount;
    _lastActivity = Timestamp.fromDate(lastActivity);
    _premise = premise;
    _title = title;
  }

  CollectionReference get comments => _comments;
  String get askerId => _askerId;
  String get askerImage => _askerImage;
  int get commentCount => _commentCount;
  DateTime get lastActivity => _lastActivity?.toDate() ?? DateTime.now();
  String get premise => _premise;
  String get title => _title;

  ThinkTanksModel.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _comments = doc.reference.collection('comments');
    _askerId = json['asker_id'];
    _askerImage = json['asker_image'];
    _commentCount = json['commentCount'];
    _lastActivity = json['lastActivity'];
    _premise = json['premise'];
    _title = json['title'];
    print(_askerId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = _comments;
    data['asker_id'] = _askerId;
    data['asker_image'] = _askerImage;
    data['commentCount'] = 0;
    data['lastActivity'] = _lastActivity;
    data['premise'] = _premise;
    data['title'] = _title;
    return data;
  }
}

class Comments extends BaseModel {
  String _content;
  String _userId;
  Timestamp _createdAt;
  List<String> _downvotes;
  List<String> _upvotes;

  Comments({
    String content,
    DateTime createdAt,
    String userId,
  }) {
    _content = content;
    _createdAt = Timestamp.fromDate(createdAt);
    _userId = userId;
    _upvotes = [];
    _downvotes = [];
  }

  String get content => _content ?? 'Error 404';
  DateTime get createdAt => _createdAt?.toDate() ?? DateTime.now();
  List<String> get upvotes => _upvotes ?? [];
  List<String> get downvotes => _downvotes ?? [];
  String get upvotesCount =>
      Util.formatCount(_upvotes?.length) ?? (-1).toString();
  String get downvotesCount =>
      Util.formatCount(_downvotes?.length) ?? (-1).toString();

  Comments.fromDoc(DocumentSnapshot doc) : super.fromDoc(doc) {
    final Map<String, dynamic> json = doc.data;
    _content = json['content'];
    _createdAt = json['created_at'];
    _downvotes = json['downvotes'].cast<String>();
    _upvotes = json['upvotes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = _content;
    data['created_at'] = _createdAt;
    data['downvotes'] = _downvotes;
    data['upvotes'] = _upvotes;
    data['user_id'] = _userId;
    return data;
  }
}

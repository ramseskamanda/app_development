class PendingStartupRequestModel {
  bool _accepted;
  String _userId;
  String _startupId;

  PendingStartupRequestModel({bool accepted, String userId, String startupId}) {
    _accepted = accepted;
    _userId = userId;
    _startupId = startupId;
  }

  bool get accepted => _accepted ?? false;
  String get userId => _userId ?? '500 Error';
  String get startupId => _startupId ?? '500 Error';

  PendingStartupRequestModel.fromJson(Map<String, dynamic> json) {
    _accepted = json['accepted'];
    _userId = json['user_id'];
    _startupId = json['startup_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accepted'] = _accepted;
    data['user_id'] = _userId;
    data['startup_id'] = _startupId;
    return data;
  }
}

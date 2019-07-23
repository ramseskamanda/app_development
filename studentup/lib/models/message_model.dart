class MessageModel {
  String _message;
  String _imageRef;
  String _senderId;
  String _receiverId;
  DateTime _timestamp;
  bool _sent;
  bool _seen;

  MessageModel({
    String message,
    String imageRef,
    String senderId,
    String receiverId,
    DateTime timestamp,
    bool sent,
    bool seen,
  }) {
    this._message = message;
    this._imageRef = imageRef;
    this._senderId = senderId;
    this._receiverId = receiverId;
    this._timestamp = timestamp;
    this._sent = sent;
    this._seen = seen;
  }

  String get message => _message ?? '';
  String get imageRef => _imageRef ?? '';
  String get senderId => _senderId ?? '';
  String get receiverId => _receiverId ?? '';
  DateTime get timestamp => _timestamp ?? DateTime.now();
  bool get sent => _sent;
  bool get seen => _seen;

  MessageModel.fromFirebase(Map<String, dynamic> doc) {
    _message = doc['message'];
    _imageRef = doc['image_ref'];
    _senderId = doc['sender_id'];
    _receiverId = doc['receiver_id'];
    _timestamp = doc['timestamp'];
    _sent = doc['sent'];
    _seen = doc['seen'];
  }

  Map<String, dynamic> toFirebase() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['image_ref'] = this._imageRef;
    data['sender_id'] = this._senderId;
    data['receiver_id'] = this._receiverId;
    data['timestamp'] = this._timestamp;
    data['sent'] = this._sent;
    data['seen'] = this._seen;
    return data;
  }
}

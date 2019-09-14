import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/util/util.dart';

mixin UserProfileEditBloc on ChangeNotifier {
  bool _isStartup = false;
  File _image;
  TextEditingController _nameEditor = TextEditingController();
  TextEditingController _additionalInfoEditor = TextEditingController();
  TextEditingController _locationEditor = TextEditingController();
  TextEditingController _bioEditor = TextEditingController();
  BehaviorSubject<String> _name = BehaviorSubject<String>.seeded('');
  BehaviorSubject<String> _additionalInfo = BehaviorSubject<String>.seeded('');
  BehaviorSubject<String> _location = BehaviorSubject<String>.seeded('');
  BehaviorSubject<String> _bio = BehaviorSubject<String>.seeded('');
  BehaviorSubject<bool> _imageStream = BehaviorSubject<bool>.seeded(false);

  void initializeMixin({bool isStartup}) {
    _isStartup = isStartup;
    _nameEditor.addListener(() => name.add(_nameEditor.text));
    _additionalInfoEditor
        .addListener(() => additionalInfo.add(_additionalInfoEditor.text));
    _locationEditor.addListener(() => location.add(_locationEditor.text));
    _bioEditor.addListener(() => bio.add(_bioEditor.text));
  }

  File get image => _image;
  TextEditingController get nameEditor => _nameEditor;
  TextEditingController get additionalInfoEditor => _additionalInfoEditor;
  TextEditingController get locationEditor => _locationEditor;
  TextEditingController get bioEditor => _bioEditor;

  Sink<String> get name => _name.sink;
  Sink<String> get additionalInfo => _additionalInfo.sink;
  Sink<String> get location => _location.sink;
  Sink<String> get bio => _bio.sink;
  Sink<bool> get imageSink => _imageStream.sink;

  String get nameValue => _name.value;
  String get emailValue => _additionalInfo.value;
  String get passwordValue => _location.value;

  Stream<bool> get canPostEdit => Observable.combineLatest5(
        _name.stream,
        _additionalInfo.stream,
        _location.stream,
        _bio.stream,
        _imageStream.stream,
        (String a, String b, String c, String d, bool e) =>
            (a != null && a.isNotEmpty) ||
            (b != null && b.isNotEmpty) ||
            (c != null && c.isNotEmpty) ||
            (d != null && d.isNotEmpty) ||
            (e != null && e),
      );

  Map<String, dynamic> get editorData {
    Map<String, dynamic> data = {};
    if (_isStartup) {
      if (_nameEditor.text.isNotEmpty) data['name'] = _nameEditor.text;
      if (_additionalInfoEditor.text.isNotEmpty)
        data['website'] = _additionalInfoEditor.text;
      if (_locationEditor.text.isNotEmpty)
        data['location'] = Util.locationToGeoPoint(_locationEditor.text);
      if (_bioEditor.text.isNotEmpty) data['description'] = _bioEditor.text;
    } else {
      if (_nameEditor.text.isNotEmpty) data['given_name'] = _nameEditor.text;
      if (_additionalInfoEditor.text.isNotEmpty)
        data['university'] = _additionalInfoEditor.text;
      if (_locationEditor.text.isNotEmpty)
        data['location'] = Util.locationToGeoPoint(_locationEditor.text);
      if (_bioEditor.text.isNotEmpty) data['bio'] = _bioEditor.text;
    }
    return data;
  }

  set image(File value) {
    _image = value;
    imageSink.add(value != null);
    notifyListeners();
  }

  /// Cropper plugin
  Future<void> cropImage() async {
    if (_image == null) return;
    File cropped = await ImageCropper.cropImage(
      sourcePath: _image.path,
      circleShape: true,
      toolbarColor: Colors.purple,
      toolbarWidgetColor: Colors.white,
      toolbarTitle: 'Crop It',
    );
    image = cropped ?? image;
    notifyListeners();
  }

  /// Select an image via gallery or camera
  Future<void> pickImage(int source) async {
    File selected = await ImagePicker.pickImage(
      source: ImageSource.values[source],
      imageQuality: 60,
    );
    image = selected;
    notifyListeners();
  }

  /// Remove image
  void clearImage() {
    image = null;
    notifyListeners();
  }

  void disposeMixin() {
    _name.close();
    _additionalInfo.close();
    _location.close();
    _bio.close();
    _imageStream.close();
    _nameEditor.dispose();
    _additionalInfoEditor.dispose();
    _locationEditor.dispose();
    _bioEditor.dispose();
  }

  void clearEditor() {
    _nameEditor.clear();
    _additionalInfoEditor.clear();
    _locationEditor.clear();
    _bioEditor.clear();
    clearImage();
  }
}
